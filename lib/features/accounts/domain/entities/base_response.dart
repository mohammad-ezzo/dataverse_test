import 'package:json_annotation/json_annotation.dart';
import 'package:rentready_test/features/accounts/domain/entities/account_entity.dart';

part 'base_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BaseResponse {
  final List<AccountEntity> value;
  @JsonKey(name: "@odata.nextLink")
  final String? nextLink;
  BaseResponse({required this.value, this.nextLink});

  factory BaseResponse.fromJson(json) => _$BaseResponseFromJson(json);
  toJson() => _$BaseResponseToJson(this);

  static List<BaseResponse> fromJsonList(List json) {
    return json.map((e) => BaseResponse.fromJson(e)).toList();
  }
}
