// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_prefs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) =>
    UserPreferences()
      ..language = json['language'] as String
      ..theme = $enumDecode(_$AppThemeModeEnumMap, json['theme'])
      ..favorites = (json['favorites'] as List<dynamic>)
          .map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList()
      ..displayName = json['displayName'] as String?
      ..photoURL = json['photoURL'] as String?;

Map<String, dynamic> _$UserPreferencesToJson(UserPreferences instance) =>
    <String, dynamic>{
      'language': instance.language,
      'theme': _$AppThemeModeEnumMap[instance.theme]!,
      'favorites': instance.favorites.map((e) => e.toJson()).toList(),
      'displayName': instance.displayName,
      'photoURL': instance.photoURL,
    };

const _$AppThemeModeEnumMap = {
  AppThemeMode.system: 'system',
  AppThemeMode.light: 'light',
  AppThemeMode.dark: 'dark',
};
