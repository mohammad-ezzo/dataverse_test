import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rentready_test/constants.dart';
import 'package:rentready_test/features/accounts/data/data_sources/accounts_api.dart';
import 'package:rentready_test/features/accounts/data/repositories/accounts_repo_impl.dart';
import 'package:rentready_test/features/accounts/domain/repositories/account_repo.dart';
import 'package:rentready_test/features/accounts/domain/usecases/get_accounts_by_filter.dart';
import 'package:rentready_test/features/accounts/presentation/search/bloc/account_search_bloc.dart';

import 'core/util/network/network.dart';
import 'core/util/util.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  initRootLogger();

  sl.registerSingletonAsync<Dio>(() async {
    final dio = Dio(BaseOptions(
        baseUrl: BaseUrl,
        validateStatus: (s) {
          return s! < 300;
        },
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "charset": "utf-8",
          "Accept-Charset": "utf-8",
          "OData-MaxVersion": 4.0,
          "OData-Version": 4.0,
          "If-None-Match": "null",
        },
        responseType: ResponseType.json));

    dio.interceptors.add(LoggerInterceptor(
      logger,
      request: true,
      requestBody: true,
      error: true,
      responseBody: true,
      responseHeader: false,
      requestHeader: true,
    ));
    return dio;
  });
  await sl.isReady<Dio>();

  sl.registerSingleton<AccountsApi>(AccountsApi(sl()));
  sl.registerSingleton<AccountRepository>(AccountRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetAccountsByFilter(sl()));
  sl.registerFactory(() => AccountSearchBloc());
  return;
}
