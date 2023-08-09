// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) => News(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      author: json['author'] as String?,
      image: json['image'] as String?,
      language: json['language'] as String? ?? "en",
      category: (json['category'] == null)
          ? const []
          : (json['category'] as List<dynamic>)
              .nonNulls
              .map((e) => e as String)
              .toList(),
      published: DateTime.parse(json['published'] as String),
    );
