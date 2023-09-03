// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_prefs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) =>
    UserPreferences()
      ..favorites = (json['favorites'] as List<dynamic>?)
              ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const []
      ..language = json['language'] as String
      ..theme = $enumDecode(_$ThemeEnumMap, json['theme']);

Map<String, dynamic> _$UserPreferencesToJson(UserPreferences instance) =>
    <String, dynamic>{
      'favorites': instance.favorites.map((e) => e.toJson()),
      'language': instance.language,
      'theme': _$ThemeEnumMap[instance.theme]!,
    };

const _$ThemeEnumMap = {
  AppThemeMode.system: 'system',
  AppThemeMode.dark: 'dark',
  AppThemeMode.light: 'light',
};
