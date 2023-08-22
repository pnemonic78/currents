// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_prefs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) =>
    UserPreferences()
      ..favorites =
          (json['favorites'] as List<dynamic>).map((e) => e as String).toList()
      ..language = json['language'] as String
      ..theme = $enumDecode(_$ThemeEnumMap, json['theme']);

Map<String, dynamic> _$UserPreferencesToJson(UserPreferences instance) =>
    <String, dynamic>{
      'favorites': instance.favorites,
      'language': instance.language,
      'theme': _$ThemeEnumMap[instance.theme]!,
    };

const _$ThemeEnumMap = {
  Theme.system: 'system',
  Theme.dark: 'dark',
  Theme.light: 'light',
};
