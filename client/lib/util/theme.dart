import 'package:flutter/material.dart';

import 'colors.dart';

class MyAppThemeConfig {
  MyAppThemeConfig.dark();

  ThemeData getTheme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: bgColorDark,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          foregroundColor: MaterialStateProperty.all(buttonTextColor),
          textStyle: MaterialStateProperty.all(
            const TextStyle(color: buttonTextColor, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
