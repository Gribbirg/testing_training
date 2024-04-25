import 'package:flutter/material.dart';

part 'color_schemes.g.dart';

ThemeData getTheme({darkMode = false, colorTheme}) {
  colorTheme ??= darkMode ? darkColorScheme : lightColorScheme;
  return ThemeData(
    colorScheme: colorTheme,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      // shape: Border(
      //     bottom: BorderSide(color: colorTheme.outlineVariant, width: 1)),
      backgroundColor: colorTheme.background,
      elevation: 10,
      titleTextStyle: TextStyle(color: colorTheme.onBackground, fontSize: 25),
    ),
  );
}
