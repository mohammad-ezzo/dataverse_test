import 'package:dartz/dartz.dart';
import 'package:rentready_test/core/util/util.dart';

import 'package:rentready_test/features/accounts/domain/entities/account_entity.dart';
import 'package:rentready_test/features/accounts/domain/entities/base_response.dart';
import 'package:rentready_test/features/accounts/domain/repositories/account_repo.dart';

class GetAccountsByFilter
    extends UseCase<BaseResponse, GetAccountsByFilterParams> {
  final AccountRepository repository;

  GetAccountsByFilter(
    this.repository,
  );

  @override
  Future<Either<Failure, BaseResponse>> call(
      GetAccountsByFilterParams params) async {
    return await repository.getAccountsByFilter(
        filter: params.filter, nextLink: params.nextLink);
  }
}

class GetAccountsByFilterParams {
  final Filter? filter;
  final String? nextLink;
  GetAccountsByFilterParams({
    this.filter,
    this.nextLink,
  });
}

class Filter {
  final String query;
  final bool isActive;
  final String? address;
  Filter({required this.query, required this.isActive, this.address});
}
