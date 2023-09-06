import 'package:currentsapi_model/prefs/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void applyTheme(AppThemeMode themeMode) async {
  switch (themeMode) {
    case AppThemeMode.dark:
      Get.changeThemeMode(ThemeMode.dark);
      break;
    case AppThemeMode.light:
      Get.changeThemeMode(ThemeMode.light);
      break;
    default:
      Get.changeThemeMode(ThemeMode.system);
      break;
  }
}
