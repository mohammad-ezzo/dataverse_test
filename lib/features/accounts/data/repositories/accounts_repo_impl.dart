import 'package:rentready_test/core/util/util.dart';
import 'package:rentready_test/features/accounts/data/data_sources/accounts_api.dart';
import 'package:rentready_test/features/accounts/domain/entities/account_entity.dart';

import 'package:dartz/dartz.dart';
import 'package:rentready_test/features/accounts/domain/entities/base_response.dart';
import 'package:rentready_test/features/accounts/domain/repositories/account_repo.dart';
import 'package:rentready_test/features/accounts/domain/usecases/get_accounts_by_filter.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountsApi accountsApi;

  AccountRepositoryImpl(
    this.accountsApi,
  );



  @override
  Future<Either<Failure, BaseResponse>> getAccountsByFilter({
    Filter? filter,
    String? nextLink,
  }) async {
    try {
      final accounts = await accountsApi.getAccountsByFilter(filter, nextLink);
      return Right(accounts);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
