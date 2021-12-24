import 'package:bloc/bloc.dart';

import 'package:rentready_test/features/accounts/domain/entities/account_entity.dart';
import 'package:rentready_test/features/accounts/domain/usecases/get_accounts_by_filter.dart';

import '../../../../../injections.dart';

part 'account_search_event.dart';
part 'account_search_state.dart';

class AccountSearchBloc extends Bloc<AccountSearchEvent, AccountSearchState> {
  AccountSearchBloc() : super(AccountSearchInitial()) {
    on<GetSearchResult>(_onGetSearchResults);
    on<GetMoreSearchResult>(_onGetMoreSearchResults);
  }
  String? nextLink;
  void _onGetSearchResults(
      GetSearchResult event, Emitter<AccountSearchState> emit) async {
    emit(LoadingResults());

    final result = await sl<GetAccountsByFilter>().call(
        GetAccountsByFilterParams(
            filter: Filter(
                query: event.query,
                isActive: event.isActive,
                address: event.address)));

    result.fold((l) {
      emit(ErrorInSearch(l.errorMessage));
    }, (r) {
      nextLink = r.nextLink;
      emit(ResultsReady(r.value, r.nextLink == null));
    });
  }

  void _onGetMoreSearchResults(
      GetMoreSearchResult event, Emitter<AccountSearchState> emit) async {
    if (state is ResultsReady && !(state as ResultsReady).hasRechedMax) {
      final result = await sl<GetAccountsByFilter>()
          .call(GetAccountsByFilterParams(nextLink: nextLink));

      result.fold((l) {
        emit(ErrorInSearch(l.errorMessage));
      }, (r) {
        nextLink = r.nextLink;
        emit(ResultsReady(
            (state as ResultsReady).accounts + r.value, r.nextLink != null));
      });
    }
  }
}
