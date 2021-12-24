import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentready_test/core/util/SizeConfig.dart';

import 'package:rentready_test/core/util/util.dart';
import 'package:rentready_test/features/accounts/domain/entities/account_entity.dart';
import 'package:rentready_test/features/accounts/presentation/search/bloc/account_search_bloc.dart';
import 'package:rentready_test/features/accounts/presentation/search/widgets/card_view_content.dart';
import 'package:rentready_test/features/accounts/presentation/search/widgets/filter_sheet.dart';
import 'package:rentready_test/features/accounts/presentation/search/widgets/list_view_content.dart';
import 'package:rentready_test/features/accounts/presentation/search/widgets/text_input.dart';

import '../../../../../injections.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final AccountSearchBloc bloc;
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchTextController = TextEditingController();
  final Debouncer debouncer = Debouncer();
  bool isActive = true;
  String? address;
  bool isGridView = false;
  @override
  void initState() {
    super.initState();
    bloc = sl<AccountSearchBloc>();
    searchTextController.addListener(sumbitSearch);
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    debouncer.run(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      if (maxScroll - currentScroll <= 50) {
        bloc.add(GetMoreSearchResult());
      }
    });
  }

  sumbitSearch() {
    debouncer.run(() {
      if (searchTextController.text.isNotEmpty) {
        bloc.add(GetSearchResult(searchTextController.text, isActive, address));
      }
    });
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [buildSearchBar(), Expanded(child: buildContent())],
        ),
      ),
    );
  }

  Widget buildContent() {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is LoadingResults) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ErrorInSearch) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is ResultsReady) {
          if (state.accounts.isEmpty) {
            return const Center(
              child: Text("No Result.."),
            );
          }
          if (isGridView) {
            return CardViewContent(
              scrollController: scrollController,
              accounts: state.accounts,
              hasReachedMax: state.hasRechedMax,
            );
          }
          return ListViewContent(
            scrollController: scrollController,
            accounts: state.accounts,
            hasReachedMax: state.hasRechedMax,
          );
        }
        return const Center(
          child: Text("Type something to search.."),
        );
      },
    );
  }

  Widget buildSearchBar() {
    return Container(
      height: SizeConfig.h(75),
      color: Colors.blueGrey,
      child: Row(
        children: [
          SizedBox(
            width: SizeConfig.w(5),
          ),
          Expanded(
              child: TextFormField(
            decoration: buildTextInputDedcor(),
            style: const TextStyle(color: Colors.white),
            controller: searchTextController,
          )),
          SizedBox(
            width: SizeConfig.w(5),
          ),
          GestureDetector(
            onTap: () {
              showFilterSheet(context, isActive, address).then((value) {
                if (value != null) {
                  setState(() {
                    isActive = value["isActive"];
                    address = value["address"];
                  });
                  bloc.add(GetSearchResult(
                      searchTextController.text, isActive, address));
                }
              });
            },
            child: Row(
              children: const [
                Icon(
                  Icons.filter_alt_outlined,
                  color: Colors.white,
                ),
                Text(
                  "Filter",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isGridView = false;
                    });
                  },
                  icon: Icon(Icons.list,
                      color: isGridView ? Colors.grey : Colors.white)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      isGridView = true;
                    });
                  },
                  icon: Icon(Icons.grid_view_rounded,
                      color: isGridView ? Colors.white : Colors.grey)),
            ],
          )
        ],
      ),
    );
  }
}
