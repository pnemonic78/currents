// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'languages_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguagesResponse _$LanguagesResponseFromJson(Map<String, dynamic> json) =>
    LanguagesResponse(
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']) ?? Status.ok,
      languages: (json['languages'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
    );

const _$StatusEnumMap = {
  Status.ok: 'ok',
  Status.error: 'error',
};
