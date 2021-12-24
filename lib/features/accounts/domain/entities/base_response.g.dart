// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse(
    value: (json['value'] as List<dynamic>)
        .map((e) => AccountEntity.fromJson(e))
        .toList(),
    nextLink: json['@odata.nextLink'] as String?);

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
    };
