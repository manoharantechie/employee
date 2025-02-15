import 'package:flutter/material.dart';

enum MyThemeKeys {
  LIGHT,
  DARK,
}

class MyThemes {
  static final ThemeData lightTheme = ThemeData(
      primaryColor:Color(0xFF1DA1F2),
      dividerColor: Color(0xFFE5E5E5),
      disabledColor: Color(0xFF323238),
      hintColor: Color(0xFF949C9E),
      highlightColor: Color(0xFFEDF8FF),
      primaryColorDark: Color(0xFF1FA5FF),
      primaryColorLight: Color(0xFF0E8AD7),
      focusColor: Color(0xFFFFFFFF),
      dialogBackgroundColor: Color(0xFFF2F2F2),
      brightness: Brightness.light,
      canvasColor: Color(0xFF1B232A),
      cardColor: Color(0xFFFFFFFF),
      shadowColor: Color(0xFFF2F1F1),
      // cursorColor: Color(0xFFFFFFFF),
      splashColor: Color(0xFF032621),
      // errorColor: Color(0xFF5968B1),
      hoverColor: Color(0xFFDD2942),
      secondaryHeaderColor:Color(0xFFFFFFFF),
      indicatorColor: Color(0xFF1B9368),
      unselectedWidgetColor: Color(0xFF666969),
      scaffoldBackgroundColor: Color(0xFFffffff)
  );


  static final ThemeData darkTheme = ThemeData(
      primaryColor: Color(0xFFffffff),
      primaryColorDark: Color(0xFF1FA5FF),
      brightness: Brightness.dark,
      disabledColor: Color(0xFF1FA5FF),
      focusColor: Color(0xFFFFFFFF),
      dialogBackgroundColor: Color(0xFF242B48),
      primaryColorLight: Color(0xFF9ED8FF),
      canvasColor: Color(0xFFF2F1F1),
      cardColor: Color(0xFF000000),
      dividerColor: Color(0xFFB3B3B3),
      // cursorColor: Color(0xFF0e1839),
      shadowColor: Color(0xFFA7AFB7),
      secondaryHeaderColor: Color(0xFFFFFFFF),
      splashColor: Color(0xFF0035FF),
      highlightColor: Color(0xffFAC579),
      // errorColor: Color(0xFF5968B1),
      hintColor: Color(0xFF1B232A),
      hoverColor:  Color(0xFFDD2942),
      indicatorColor: Color(0xFF1B9368),
      unselectedWidgetColor: Color(0xFF777777),
      scaffoldBackgroundColor: Color(0xFFCCDBFF)
  );

  static ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.LIGHT:
        return lightTheme;
      case MyThemeKeys.DARK:
        return darkTheme;
      default:
        return lightTheme;
    }
  }
}
