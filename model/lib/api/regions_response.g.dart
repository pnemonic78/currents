// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegionsResponse _$RegionsResponseFromJson(Map<String, dynamic> json) =>
    RegionsResponse(
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']) ?? Status.ok,
      regions: (json['regions'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
    );

const _$StatusEnumMap = {
  Status.ok: 'ok',
  Status.error: 'error',
};
