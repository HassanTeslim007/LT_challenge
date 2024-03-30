part of 'wordle_bloc.dart';

sealed class WordleState {}

final class WordleInitial extends WordleState {}

final class WordleGenerated extends WordleState {
  final String generatedWord;

  WordleGenerated(this.generatedWord);
}

final class WordleSuccess extends WordleState {}

final class WordleError extends WordleState {
  final String error;

  WordleError(this.error);
}

final class UpdateKeySuccess extends WordleState {
  final List<Letter> pressedKeys;
  UpdateKeySuccess({this.pressedKeys = const []});
}
