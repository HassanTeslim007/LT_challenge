part of 'wordle_bloc.dart';

sealed class WordleEvent {}

final class PressKeyEvent extends WordleEvent {
  final String key;
  PressKeyEvent(this.key);
}

final class GenerateRandomWordEvent extends WordleEvent {}

final class PlayAgainEvent extends WordleEvent {}

final class CheckWordEvent extends WordleEvent {
  // final String generatedWord;
  final String guessedWord;

  CheckWordEvent(this.guessedWord);
}

final class UpdateKeysEvent extends WordleEvent {
  final String guessedWord;

  UpdateKeysEvent(this.guessedWord);
}


