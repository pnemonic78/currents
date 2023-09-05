// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters_db.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FiltersCollection _$FiltersCollectionFromJson(Map<String, dynamic> json) =>
    FiltersCollection(
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      languages: (json['languages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const ["en"],
      regions: (json['regions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [Region.regionInternational],
    )..timestamp = DateTime.parse(json['timestamp'] as String);

Map<String, dynamic> _$FiltersCollectionToJson(FiltersCollection instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'languages': instance.languages,
      'regions': instance.regions,
      'timestamp': instance.timestamp.toIso8601String(),
    };
