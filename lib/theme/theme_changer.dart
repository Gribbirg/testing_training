import 'package:flutter/material.dart';

class ThemeChanger extends ChangeNotifier {
  ThemeData _themeData;
  ThemeData _darkThemeData;
  ThemeChanger(this._themeData, this._darkThemeData);

  get getTheme => _themeData;
  void setTheme(ThemeData theme, ThemeData darkTheme) {
    _themeData = theme;
    _darkThemeData = darkTheme;
    notifyListeners();
  }

  get getDartTheme => _darkThemeData;
}