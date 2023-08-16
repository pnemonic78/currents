import 'package:flutter/material.dart';

extension ContextDarkMode on BuildContext {
  /// is dark mode currently enabled?
  bool get isDarkMode {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }
}

extension ThemeDarkMode on ThemeData {
  /// is dark mode currently enabled?
  bool get isDarkMode {
    return brightness == Brightness.dark;
  }
}