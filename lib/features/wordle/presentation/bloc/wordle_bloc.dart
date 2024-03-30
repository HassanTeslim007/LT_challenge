import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lt_challenge/features/wordle/data/entities/letter.dart';
import 'package:lt_challenge/features/wordle/data/entities/word.dart';
import 'package:lt_challenge/features/wordle/data/wordle_datasource.dart';

part 'wordle_event.dart';
part 'wordle_state.dart';

class WordleBloc extends Bloc<WordleEvent, WordleState> {
  final WordleDataSource dataSource;
  String randomWord = '';
  List<Word> words = List.generate(
      6, (index) => Word(List.generate(5, (index) => Letter.empty())));
  int currentIndex = 0;
  final List<Letter> pressedKeys = [];
  Word? get currentWord =>
      currentIndex < words.length ? words[currentIndex] : null;
  GameStatus status = GameStatus.playing;
  int wins = 0;
  int losses = 0;
  WordleBloc(this.dataSource) : super(WordleInitial()) {
    on<GenerateRandomWordEvent>((event, emit) async {
      randomWord = await dataSource.generateWord();
      debugPrint('Generated random word:  $randomWord');
      emit(WordleGenerated(randomWord));
    });
    on<CheckWordEvent>((event, emit) async {
      final wordExist = await dataSource.doesWordExist(event.guessedWord);
      if (wordExist == false) {
        emit(WordleError('Word unavailable, try another word'));
      }
      if (wordExist) {
        if (currentIndex == 5) {}

        emit(WordleSuccess());
      }
    });

    on<UpdateKeysEvent>((event, emit) {
      for (var i = 0; i < 5; i++) {
        if (event.guessedWord[i] == randomWord[i]) {
          currentWord!.letters[i] = currentWord!.letters[i].copyWith(
              value: event.guessedWord[i], status: LetterStatus.correct);
          pressedKeys
              .add(Letter(event.guessedWord[i], status: LetterStatus.correct));
        } else if (randomWord.contains(event.guessedWord[i])) {
          currentWord!.letters[i] = currentWord!.letters[i].copyWith(
              value: event.guessedWord[i], status: LetterStatus.inWord);
          pressedKeys
              .add(Letter(event.guessedWord[i], status: LetterStatus.inWord));
        } else {
          currentWord!.letters[i] = currentWord!.letters[i].copyWith(
              value: event.guessedWord[i], status: LetterStatus.wrong);
          pressedKeys
              .add(Letter(event.guessedWord[i], status: LetterStatus.wrong));
        }
      }
      emit(UpdateKeySuccess(pressedKeys: pressedKeys));

      if (currentIndex < 6) {
        currentIndex++;
      }
    });

    on<PlayAgainEvent>((event, emit) async {
      status = GameStatus.starts;
      currentIndex = 0;
      words.clear();
      words = List.generate(
          6, (index) => Word(List.generate(5, (index) => Letter.empty())));
      randomWord = await dataSource.generateWord();
      debugPrint('new random word: $randomWord');
      pressedKeys.clear();
    });
  }
}

enum GameStatus { starts, playing, over }
