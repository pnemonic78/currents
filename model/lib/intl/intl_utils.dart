import 'dart:io';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/locale.dart' as loc;

loc.Locale getPlatformLocale() {
  String localeName = intl.Intl.getCurrentLocale();

  try {
    localeName = Platform.localeName;
  } catch (e) {}
  final locale = loc.Locale.parse(localeName);

  Get.locale ??= Locale.fromSubtags(
      languageCode: locale.languageCode,
      scriptCode: locale.scriptCode,
      countryCode: locale.countryCode,
    );

  return locale;
}

String getPlatformLanguage() {
  return getPlatformLocale().languageCode;
}
