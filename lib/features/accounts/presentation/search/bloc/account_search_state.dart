part of 'account_search_bloc.dart';

abstract class AccountSearchState {
  const AccountSearchState();
}

class AccountSearchInitial extends AccountSearchState {}

class LoadingResults extends AccountSearchState {}

class ResultsReady extends AccountSearchState {
  final List<AccountEntity> accounts;
  final bool hasRechedMax;
  const ResultsReady(this.accounts, this.hasRechedMax);
}

class ErrorInSearch extends AccountSearchState {
  final String error;
  const ErrorInSearch(this.error);
}
