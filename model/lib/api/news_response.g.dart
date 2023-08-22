// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsResponse _$NewsResponseFromJson(Map<String, dynamic> json) => NewsResponse(
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']) ?? Status.ok,
      news: (json['news'] as List<dynamic>?)
              ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

const _$StatusEnumMap = {
  Status.ok: 'ok',
  Status.error: 'error',
};
