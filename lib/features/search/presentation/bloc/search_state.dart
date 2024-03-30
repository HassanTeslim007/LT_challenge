part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoadingMore extends SearchState {}

final class SearchSuccess extends SearchState {
  final SearchResult result;
 final List<Item> items;

  SearchSuccess(this.result, this.items);
}

final class SearchFailure extends SearchState {
  final String message;

  SearchFailure(this.message);
}
