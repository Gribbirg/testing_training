import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:testing_training/features/settings/bloc/settings_bloc.dart';
import 'package:testing_training/features/settings/widgets/color_picker_dialog.dart';
import 'package:testing_training/repositories/settings/abstract_settings_repository.dart';
import 'package:testing_training/repositories/settings/model/color_settings.dart';
import 'package:testing_training/repositories/settings/model/model.dart';
import 'package:testing_training/theme/theme.dart';
import 'package:testing_training/widgets/app_bar.dart';

import '../../../repositories/settings/model/settings.dart';
import '../../../theme/theme_changer.dart';
import '../widgets/settings_drawer.dart';

@RoutePage()
class ColorsSelectPage extends StatefulWidget {
  const ColorsSelectPage({super.key});

  @override
  State<ColorsSelectPage> createState() => _ColorsSelectPageState();
}

class _ColorsSelectPageState extends State<ColorsSelectPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _settings = GetIt.I<Settings>();
  final _settingsCopy = Settings.copy(GetIt.I<Settings>());
  final _settingsBloc = SettingsBloc(GetIt.I<AbstractSettingsRepository>());
  late ThemeChanger _themeProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _themeProvider = Provider.of<ThemeChanger>(context);
    return Scaffold(
      key: _key,
      drawer: SettingsDrawer(scaffoldKey: _key),
      appBar: getAppBar(context, text: 'Внешний вид'),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 2.0),
                    child: ListTile(
                      title: const Text('Тема'),
                      trailing: DropdownMenu<ColorLightness>(
                        initialSelection: _settings.colorSetting.lightness,
                        dropdownMenuEntries: ColorLightness.values
                            .map(
                                (e) => DropdownMenuEntry(value: e, label: e.ru))
                            .toList(),
                        onSelected: (ColorLightness? colorLightness) {
                          if (colorLightness == null) {
                            return;
                          }
                          _settings.colorSetting.lightness = colorLightness;
                          _themeProvider.setTheme(
                              getTheme(
                                  colorSettings: _settings.colorSetting,
                                  darkMode:
                                      colorLightness == ColorLightness.dark),
                              getTheme(
                                  colorSettings: _settings.colorSetting,
                                  darkMode: !(colorLightness ==
                                      ColorLightness.light)));
                          _settingsBloc.add(SaveSettings(settings: _settings));
                        },
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ListTile(
                      title: const Text('Основной цвет'),
                      trailing: FilledButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => ColorPickerDialog(
                                    startTheme: Theme.of(context),
                                  ));
                        },
                        child: null,
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => ColorPickerDialog(
                                startTheme: Theme.of(context)));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  if (ThemeChanger.lightDynamic != null)
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SwitchListTile(
                        title: const Text('Использовать системный цвет'),
                        onChanged: (bool on) {
                          setState(() {
                            _settings.colorSetting.dynamic = on;
                            if (on) {
                              _themeProvider.setTheme(
                                  getTheme(
                                      colorSettings: _settings.colorSetting,
                                      colorTheme: ThemeChanger.lightDynamic,
                                      darkMode: false),
                                  getTheme(
                                      colorSettings: _settings.colorSetting,
                                      colorTheme: ThemeChanger.darkDynamic,
                                      darkMode: true));
                            } else {
                              _themeProvider.setTheme(
                                  getTheme(
                                      colorSettings: _settings.colorSetting,
                                      darkMode: false),
                                  getTheme(
                                      colorSettings: _settings.colorSetting,
                                      darkMode: true));
                            }
                            _settingsBloc.add(SaveSettings(settings: _settings));
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        value: _settings.colorSetting.dynamic,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
