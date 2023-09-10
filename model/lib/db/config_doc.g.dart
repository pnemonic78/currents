// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_doc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigurationDocument _$ConfigurationDocumentFromJson(
        Map<String, dynamic> json) =>
    ConfigurationDocument(
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      languages: (json['languages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [cal.Language.english],
      regions: (json['regions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [Region.regionInternational],
    )
      ..apiKey = json['apiKey'] as String
      ..timestamp = DateTime.parse(json['timestamp'] as String);

Map<String, dynamic> _$ConfigurationDocumentToJson(
        ConfigurationDocument instance) =>
    <String, dynamic>{
      'apiKey': instance.apiKey,
      'categories': instance.categories,
      'languages': instance.languages,
      'regions': instance.regions,
      'timestamp': instance.timestamp.toIso8601String(),
    };
