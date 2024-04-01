part of 'wordle_bloc.dart';

sealed class WordleState extends Equatable {}

final class WordleInitial extends WordleState {
  @override
  List<Object?> get props => [];
}

final class WordleGenerated extends WordleState {
  final String generatedWord;

  WordleGenerated(this.generatedWord);
  @override
  List<Object?> get props => [generatedWord];
}

final class WordleSuccess extends WordleState {
  @override
  List<Object?> get props => [];
}

final class WordleError extends WordleState {
  final String error;

  WordleError(this.error);
  @override
  List<Object?> get props => [error];
}

final class UpdateKeySuccess extends WordleState {
  final List<Letter> pressedKeys;
  UpdateKeySuccess({this.pressedKeys = const []});

  @override
  List<Object?> get props => [pressedKeys];
}
