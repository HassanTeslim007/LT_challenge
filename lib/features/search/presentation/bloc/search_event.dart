part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

final class Search extends SearchEvent {
  final String query;

  Search(this.query);
}

final class LoadMore extends SearchEvent {
  final String query;
  final String nextPageToken;

  LoadMore(this.query, this.nextPageToken);
}
