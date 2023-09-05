import 'package:currentsapi_model/prefs/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:get/get.dart';
import 'package:intl/locale.dart' as intl;
import 'package:sealed_languages/sealed_languages.dart';

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

String? getLanguageName(BuildContext context, String languageCode) {
  final locales = LocaleNames.of(context);
  if (locales == null) return null;

  String? name = locales.nameOf(languageCode);
  if (name != null) return name;

  if (languageCode.length == 2) {
    try {
      NaturalLanguage nl2 = NaturalLanguage.fromCodeShort(languageCode);
      return nl2.name;
    } on Error {}
  }

  if (languageCode.length == 3) {
    try {
      NaturalLanguage nl3 = NaturalLanguage.fromCode(languageCode);
      return nl3.name;
    } on Error {}
  }

  return null;
}
