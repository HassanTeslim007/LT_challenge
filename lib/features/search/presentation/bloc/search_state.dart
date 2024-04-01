part of 'search_bloc.dart';

@immutable
sealed class SearchState extends Equatable{}

final class SearchInitial extends SearchState {
  @override
  List<Object?> get props => [];
}

final class SearchLoading extends SearchState {
  @override
  List<Object?> get props => [];
}

final class SearchLoadingMore extends SearchState {
  @override
   List<Object?> get props => [];
}

final class SearchSuccess extends SearchState {
  final SearchResult result;
 final List<Item> items;

  SearchSuccess(this.result, this.items);
  
  @override
  List<Object?> get props => [result,items];
}

final class SearchFailure extends SearchState {
  final String message;

  SearchFailure(this.message);
  
  @override
  List<Object?> get props => [message];
}
