part of 'search_bloc.dart';

@immutable
sealed class SearchEvent extends Equatable{}

final class Search extends SearchEvent {
  final String query;

  Search(this.query);
  
  @override
  List<Object?> get props => [query];
}

final class LoadMore extends SearchEvent {
  final String query;
  final String nextPageToken;

  LoadMore(this.query, this.nextPageToken);
  
  @override
  List<Object?> get props => [query, nextPageToken];
}
