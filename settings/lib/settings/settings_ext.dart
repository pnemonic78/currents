import 'package:currentsapi_model/prefs/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/locale.dart' as intl;

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

void applyLanguage(String languageCode) async {
  final ilocale = intl.Locale.parse(languageCode);
  final locale = Locale.fromSubtags(
    languageCode: ilocale.languageCode,
    countryCode: ilocale.countryCode,
    scriptCode: ilocale.scriptCode,
  );
  applyLocale(locale);
}

void applyLocale(Locale locale) async {
  await Get.updateLocale(locale);
}
