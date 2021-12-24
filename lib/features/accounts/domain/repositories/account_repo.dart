import 'package:dartz/dartz.dart';
import 'package:rentready_test/core/util/util.dart';
import 'package:rentready_test/features/accounts/domain/entities/base_response.dart';
import 'package:rentready_test/features/accounts/domain/usecases/get_accounts_by_filter.dart';

abstract class AccountRepository {
  Future<Either<Failure, BaseResponse>> getAccountsByFilter({
    Filter? filter,
    String? nextLink,
  });

 
}
