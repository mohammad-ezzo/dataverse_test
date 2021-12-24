import 'package:dio/dio.dart';
import 'package:rentready_test/features/accounts/domain/entities/base_response.dart';
import 'package:rentready_test/core/util/network/dio_error_handler.dart';
import 'package:rentready_test/core/util/util.dart';
import 'package:rentready_test/features/accounts/domain/entities/account_entity.dart';
import 'package:rentready_test/features/accounts/domain/usecases/get_accounts_by_filter.dart';

class AccountsApi {
  final Dio dio;

  AccountsApi(this.dio);
  addTokenToHeader(String accessToken) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, r) {
        options.headers["Authorization"] = "Bearer " + accessToken;

        return r.next(options);
      },
    ));
  }

  Future<BaseResponse> getAccountsByFilter(
    Filter? filter,
    String? nextLink,
  ) async {
    try {
      var response;
      if (filter != null) {
        response = await dio.get(
          "/accounts?\$select=name,accountnumber&\$filter=(contains(name,'${filter.query}') or contains(accountnumber,'${filter.query}')) and statecode eq ${filter.isActive ? 0 : 1} ${filter.address != null && filter.address!.isNotEmpty ? "and address1_stateorprovince eq ${filter.address}" : ""}",
        );
      } else {
        response = await dio.get(nextLink!);
      }

      return BaseResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw ServerException(handleDioError(e));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
