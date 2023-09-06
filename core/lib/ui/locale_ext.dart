import 'package:currentsapi_model/api/language.dart' as cal;
import 'package:currentsapi_model/api/region.dart' as car;
import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:get/get.dart';
import 'package:intl/locale.dart' as intl;
import 'package:sealed_countries/sealed_countries.dart';

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
      return NaturalLanguage.fromCodeShort(languageCode).name;
    } on Error {
      // ignore
    }
  }

  if (languageCode.length == 3) {
    try {
      return NaturalLanguage.fromCode(languageCode).name;
    } on Error {
      // ignore
    }
  }

  return null;
}

final NaturalLanguage _languageEnglish =
    NaturalLanguage.fromCodeShort(cal.Language.english);

String? getRegionName(BuildContext context, String regionCode) {
  Locale locale = Localizations.localeOf(context);
  NaturalLanguage language;
  try {
    language = NaturalLanguage.fromCodeShort(locale.languageCode);
  } on Error {
    language = _languageEnglish;
  }
  return getRegionNameForLanguage(context, regionCode, language) ??
      getRegionNameForLanguage(context, regionCode, _languageEnglish);
}

String? getRegionNameForLanguage(
  BuildContext context,
  String regionCode,
  NaturalLanguage language,
) {
  if (regionCode == car.Region.regionInternational) {
    return "International";
  }
  if (regionCode == car.Region.regionAsia) {
    return "Asia";
  }
  if (regionCode == car.Region.regionEurope) {
    return "Europe";
  }

  if (regionCode.length == 2) {
    try {
      WorldCountry wc = WorldCountry.fromCodeShort(regionCode);
      return wc.nameTranslated(language)?.common ?? wc.name.common;
    } on Error {
      // ignore
    }
  }

  if (regionCode.length == 3) {
    try {
      WorldCountry wc = WorldCountry.fromCode(regionCode);
      return wc.nameTranslated(language)?.common ?? wc.name.common;
    } on Error {
      // ignore
    }
  }

  return null;
}
