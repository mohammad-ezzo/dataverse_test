import 'package:flutter/material.dart';
import 'package:rentready_test/features/accounts/domain/entities/account_entity.dart';

class ListViewContent extends StatelessWidget {
  final bool hasReachedMax;
  final List<AccountEntity> accounts;
  const ListViewContent({
    Key? key,
    required this.scrollController,
    required this.accounts,
    required this.hasReachedMax,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: scrollController,
        itemCount: hasReachedMax ? accounts.length : accounts.length + 1,
        itemBuilder: (context, index) {
          if (index >= accounts.length) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final account = accounts[index];
          return ListTile(
            title: Text(account.name),
            subtitle: Text(account.accountnumber ?? ""),
          );
        });
  }
}
