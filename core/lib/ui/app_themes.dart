import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeDark = ThemeData.dark(useMaterial3: true).copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepOrangeAccent,
      brightness: Brightness.dark,
      onPrimary: Colors.black,
    ),
  );

  static ThemeData themeLight = ThemeData.light(useMaterial3: true).copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.orange,
      brightness: Brightness.light,
      onPrimary: Colors.white,
    ),
  );
}
