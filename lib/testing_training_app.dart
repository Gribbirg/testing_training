import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:testing_training/repositories/settings/model/color_settings.dart';
import 'package:testing_training/repositories/settings/model/settings.dart';
import 'package:testing_training/router/router.dart';
import 'package:testing_training/theme/theme.dart';
import 'package:testing_training/theme/theme_changer.dart';

class TestingTrainingApp extends StatefulWidget {
  const TestingTrainingApp({super.key});

  @override
  State<StatefulWidget> createState() => _TestingTrainingAppState();
}

class _TestingTrainingAppState extends State<TestingTrainingApp> {
  final _settings = GetIt.I<Settings>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ThemeChanger(
                getTheme(
                    colorTheme: ThemeChanger.lightDynamic,
                    colorSettings: _settings.colorSetting,
                    darkMode: _settings.colorSetting.lightness ==
                        ColorLightness.dark),
                getTheme(
                    colorTheme: ThemeChanger.darkDynamic,
                    darkMode: _settings.colorSetting.lightness ==
                            ColorLightness.system ||
                        _settings.colorSetting.lightness == ColorLightness.dark,
                    colorSettings: _settings.colorSetting))),
      ],
      child: const TestingTrainingThemeApp(),
    );
  }
}

class TestingTrainingThemeApp extends StatefulWidget {
  const TestingTrainingThemeApp({super.key});

  @override
  State<TestingTrainingThemeApp> createState() =>
      _TestingTrainingThemeAppState();
}

class _TestingTrainingThemeAppState extends State<TestingTrainingThemeApp> {
  final _router = AppRouter();
  final _settings = GetIt.I<Settings>();

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return DynamicColorBuilder(
        builder: (ColorScheme? lightColorScheme, ColorScheme? darkColorScheme) {
      ThemeChanger.setDynamic(lightColorScheme, darkColorScheme);
      Provider.of<ThemeChanger>(context).setThemeWithoutNotify(
          getTheme(
              colorTheme: ThemeChanger.lightDynamic,
              colorSettings: _settings.colorSetting,
              darkMode:
                  _settings.colorSetting.lightness == ColorLightness.dark),
          getTheme(
              colorTheme: ThemeChanger.darkDynamic,
              darkMode:
                  _settings.colorSetting.lightness == ColorLightness.system ||
                      _settings.colorSetting.lightness == ColorLightness.dark,
              colorSettings: _settings.colorSetting),
      );
      return MaterialApp.router(
        title: "Подготовка к ЦТ",
        theme: theme.getTheme,
        darkTheme: theme.getDartTheme,
        themeMode: ThemeMode.system,
        routerConfig: _router.config(),
      );
    });
  }
}
