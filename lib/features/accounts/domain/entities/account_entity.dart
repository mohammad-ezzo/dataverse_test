import 'package:json_annotation/json_annotation.dart';

part 'account_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AccountEntity {
  final String accountid;
  final String? accountnumber;
  final String name;

  AccountEntity(
      {required this.name,
      required this.accountid,
      required this.accountnumber});

  factory AccountEntity.fromJson(json) => _$AccountEntityFromJson(json);
  toJson() => _$AccountEntityToJson(this);

  static List<AccountEntity> fromJsonList(List json) {
    return json.map((e) => AccountEntity.fromJson(e)).toList();
  }
}
