import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../../repositories/settings/abstract_settings_repository.dart';
import '../../../repositories/settings/model/settings.dart';
import '../../../theme/theme.dart';
import '../../../theme/theme_changer.dart';
import '../bloc/settings_bloc.dart';

class ColorPickerDialog extends StatefulWidget {
  const ColorPickerDialog({super.key, required this.startTheme});

  final ThemeData startTheme;

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  final _settings = GetIt.I<Settings>();
  final _settingsCopy = Settings.copy(GetIt.I<Settings>());
  final _settingsBloc = SettingsBloc(GetIt.I<AbstractSettingsRepository>());
  late ThemeChanger _themeProvider;
  late ThemeData _dialogTheme;

  @override
  void initState() {
    _dialogTheme = widget.startTheme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _themeProvider = Provider.of<ThemeChanger>(context);
    // print(_dialogTheme.dialogTheme.backgroundColo);
    return AlertDialog(
      title: Text('Выберите цвет:', style: TextStyle(color: _dialogTheme.colorScheme.onBackground),),
      backgroundColor: _dialogTheme.colorScheme.background,
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: Color(_settingsCopy.colorSetting.base),
          onColorChanged: (Color pickerColor) {
            setState(() {
              _dialogTheme = getTheme(
                  colorSettings: _settingsCopy.colorSetting
                    ..base = pickerColor.value,
                  darkMode: Theme
                      .of(context)
                      .brightness == Brightness.dark);
            });
          },
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            AutoRouter.of(context).maybePop();
          },
          child: Text('Отменить', style: TextStyle(color: _dialogTheme.colorScheme.primary),),
        ),
        FilledButton(
          onPressed: () {
            _settings.colorSetting.base = _settingsCopy.colorSetting.base;
            _themeProvider.setTheme(
              getTheme(
                colorSettings: _settings.colorSetting,
              ),
              getTheme(colorSettings: _settings.colorSetting, darkMode: true),
            );
            _settingsBloc.add(SaveSettings(settings: _settings));
            AutoRouter.of(context).maybePop();
          },
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(_dialogTheme.colorScheme.primary)),
          child: Text('Сохранить', style:  TextStyle(color: _dialogTheme.colorScheme.onPrimary),),
        ),
      ],
    );
  }
}
