// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountEntity _$AccountEntityFromJson(Map<String, dynamic> json) =>
    AccountEntity(
      name: json['name'] as String,
      accountid: json['accountid'] as String,
      accountnumber: json['accountnumber'] as String?,
    );

Map<String, dynamic> _$AccountEntityToJson(AccountEntity instance) =>
    <String, dynamic>{
      'accountid': instance.accountid,
      'name': instance.name,
    };
