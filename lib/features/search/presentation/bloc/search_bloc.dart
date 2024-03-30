import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lt_challenge/features/search/domain/entities/search.dart';
import 'package:lt_challenge/features/search/domain/repository/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository _searchRepository;

  List<Item> currentItems = [];

  SearchBloc({required SearchRepository searchRepository})
      : _searchRepository = searchRepository,
        super(SearchInitial()) {
    on<Search>((event, emit) async {
      emit(SearchLoading());
      final res = await _searchRepository.search(query: event.query);
      res.fold((failure) => emit(SearchFailure(failure.message)), (r) {
        log(r.toString());
        currentItems = r.items ?? [];
        emit(SearchSuccess(r, r.items ?? []));
      });
    });

    on<LoadMore>((event, emit) async {
      emit(SearchLoadingMore());
      final res = await _searchRepository.search(
          query: event.query, nextPageToken: event.nextPageToken);

      res.fold((failure) => emit(SearchFailure(failure.message)), (r) {
        currentItems.addAll(r.items ?? []);
        emit(SearchSuccess(r, currentItems));
      });
    });
  }
}
