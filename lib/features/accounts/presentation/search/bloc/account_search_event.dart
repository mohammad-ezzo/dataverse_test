part of 'account_search_bloc.dart';

abstract class AccountSearchEvent {
  const AccountSearchEvent();
}

class GetSearchResult extends AccountSearchEvent {
  final String query;
  final String? address;
  final bool isActive;

  GetSearchResult(
    this.query,
    this.isActive,
    this.address,
  );
}

class GetMoreSearchResult extends AccountSearchEvent {
  
}
