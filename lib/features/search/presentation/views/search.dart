import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lt_challenge/core/shared/loader.dart';
import 'package:lt_challenge/core/utils/utils.dart';
import 'package:lt_challenge/features/search/domain/entities/search.dart';
import 'package:lt_challenge/features/search/presentation/bloc/search_bloc.dart';
import 'package:lt_challenge/features/search/presentation/widgets/search_tile.dart';

class SearchVideos extends StatefulWidget {
  const SearchVideos({super.key});

  @override
  State<SearchVideos> createState() => _SearchVideosState();
}

class _SearchVideosState extends State<SearchVideos> {
  final ScrollController scrollController = ScrollController();
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  String? newPageToken;
  String? searchQuery;
  List<Item>? items;

  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        showSnackBar(
          context,
          message: 'Coonnected',
          success: true
        );
      },
    );
  
    scrollController.addListener(
      () {
        onScroll();
      },
    );
  }

  void onScroll() {
    // Check if user has scrolled to the bottom of the list
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      // Fetch next page of data
      context
          .read<SearchBloc>()
          .add(LoadMore(searchQuery ?? '', newPageToken ?? ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<SearchBloc, SearchState>(
          listener: (context, state) {
            if (state is SearchSuccess) {
              newPageToken = state.result.nextPageToken;
              items = state.items;
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  onSubmitted: (query) {
                    searchQuery = query;
                    context.read<SearchBloc>().add(Search(query.trim()));
                  },
                  decoration: const InputDecoration(
                      suffix: Icon(Icons.close),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search)),
                ),
                if (state is SearchInitial ||
                    state is SearchLoading ||
                    state is SearchFailure)
                  const Spacer(),
                if (state is SearchInitial) const Text('Search Videos'),
                if (state is SearchLoading) const Loader(),
                if (state is SearchFailure) Text(state.message),
                if (state is SearchSuccess || state is SearchLoadingMore)
                  Expanded(
                      child: ListView.builder(
                    controller: scrollController,
                    itemCount: items?.length ?? 0,
                    itemBuilder: (context, index) => Column(
                      children: [
                        SearchTile(item: items![index]),
                      ],
                    ),
                  )),
                if (state is SearchInitial ||
                    state is SearchLoading ||
                    state is SearchFailure)
                  const Spacer(),
                const SizedBox(
                  height: 10,
                ),
                if (state is SearchLoadingMore) const Loader(),
              ],
            );
          },
        ),
      )),
    );
  }
}
