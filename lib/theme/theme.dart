import 'package:flutter/material.dart';
import 'package:testing_training/repositories/settings/model/color_settings.dart';

ThemeData getTheme(
    {required ColorSettings colorSettings, colorTheme, bool darkMode = false}) {
  if (!colorSettings.dynamic || colorTheme == null) {
    colorTheme = ColorScheme.fromSeed(
      seedColor: Color(colorSettings.base),
      brightness: colorSettings.lightness == ColorLightness.system
          ? darkMode
              ? Brightness.dark
              : Brightness.light
          : colorSettings.lightness == ColorLightness.dark
              ? Brightness.dark
              : Brightness.light,
    );
  }
  return ThemeData(
    colorScheme: colorTheme,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      // shape: Border(
      //     bottom: BorderSide(color: colorTheme.outlineVariant, width: 1)),
      color: colorTheme.background,
      elevation: 10,
      titleTextStyle: TextStyle(color: colorTheme.onBackground, fontSize: 25),
    ),
  );
}
