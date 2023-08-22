import 'dart:io';

import 'package:intl/locale.dart' as intl;

intl.Locale getPlatformLocale() {
  return intl.Locale.parse(Platform.localeName);
}

String getPlatformLanguage() {
  return getPlatformLocale().languageCode;
}