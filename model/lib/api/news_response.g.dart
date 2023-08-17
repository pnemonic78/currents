// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsResponse _$NewsResponseFromJson(Map<String, dynamic> json) => NewsResponse(
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']) ?? Status.error,
      news: (json['news'] == null)
          ? const []
          : (json['news'] as List<dynamic>)
              .nonNulls
              .map((e) => News.fromJson(e as Map<String, dynamic>)!)
              .toList(),
    );

const _$StatusEnumMap = {
  Status.ok: 'ok',
  Status.error: 'error',
};
