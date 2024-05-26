import 'package:flutter/material.dart';

class ThemeChanger extends ChangeNotifier {
  ThemeData _themeData;
  ThemeData _darkThemeData;

  static ColorScheme? lightDynamic;
  static ColorScheme? darkDynamic;

  ThemeChanger(this._themeData, this._darkThemeData);

  static void setDynamic(ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
    ThemeChanger.lightDynamic = lightDynamic;
    ThemeChanger.darkDynamic = darkDynamic;
  }

  get getTheme => _themeData;

  void setTheme(ThemeData theme, ThemeData darkTheme) {
    setThemeWithoutNotify(theme, darkTheme);
    notifyListeners();
  }

  void setThemeWithoutNotify(ThemeData theme, ThemeData darkTheme) {
    _themeData = theme;
    _darkThemeData = darkTheme;
  }

  get getDartTheme => _darkThemeData;
}
