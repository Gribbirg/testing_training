import 'package:flutter/material.dart';

part 'color_schemes.g.dart';

ThemeData getTheme({darkMode = false}) {
  final colorTheme = darkMode ? darkColorScheme : lightColorScheme;
  return ThemeData(
    colorScheme: colorTheme,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),
  );
}