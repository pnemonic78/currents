// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesResponse _$CategoriesResponseFromJson(Map<String, dynamic> json) =>
    CategoriesResponse(
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']) ?? Status.ok,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

const _$StatusEnumMap = {
  Status.ok: 'ok',
  Status.error: 'error',
};
