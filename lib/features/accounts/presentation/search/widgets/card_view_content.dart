import 'package:flutter/material.dart';
import 'package:rentready_test/core/util/SizeConfig.dart';
import 'package:rentready_test/features/accounts/domain/entities/account_entity.dart';

class CardViewContent extends StatelessWidget {
  final bool hasReachedMax;
  final List<AccountEntity> accounts;
  final ScrollController scrollController;
  const CardViewContent({
    Key? key,
    required this.hasReachedMax,
    required this.accounts,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: accounts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final account = accounts[index];
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: SizeConfig.h(50),
                  backgroundImage: const AssetImage("assets/user.png"),
                ),
                SizedBox(
                  height: SizeConfig.h(10),
                ),
                Text(
                  account.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  account.accountnumber ?? "",
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        });
  }
}
