// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_db.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsCollection _$NewsCollectionFromJson(Map<String, dynamic> json) {
  return NewsCollection(news: const [])
    ..news = (json['news'] as List<dynamic>)
        .map((e) => Article.fromJson(e as Map<String, dynamic>))
        .toList()
    ..timestamp = DateTime.parse(json['timestamp'] as String);
}

Map<String, dynamic> _$NewsCollectionToJson(NewsCollection instance) =>
    <String, dynamic>{
      'news': instance.news.map((e) => e.toJson()).toList(),
      'timestamp': instance.timestamp.toIso8601String(),
    };
