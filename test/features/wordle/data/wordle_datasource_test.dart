import 'package:flutter_test/flutter_test.dart';
import 'package:lt_challenge/features/wordle/data/wordle_datasource.dart';
import 'package:mocktail/mocktail.dart';

class MockWordleDataSource with Mock implements WordleDataSource {}

void main() {
  late WordleDataSource dataSource;

  setUp(() {
    dataSource =
        WordleDataSource(fiveLetterWords: ['apple', 'today', 'trove', 'funny']);
  });

  group('MockWordleDataSource', () {
    test('generateWord returns a random uppercase five-letter word', () async {
      final word = await dataSource.generateWord();

      expect(word.length, 5);
      expect(word, equals(word.toUpperCase()));
    });

    test('doesWordExist returns true for a valid word', () async {
      const word = 'apple';

      final exists = await dataSource.doesWordExist(word);

      expect(exists, isTrue);
    });

    test('doesWordExist returns false for a non-existent word', () async {
      const word = 'zzzzz';

      final exists = await dataSource.doesWordExist(word);

      expect(exists, isFalse);
    });

    test('checkWord returns true for correct guess', () async {
      const generatedWord = 'HELLO';
      const guessedWord = 'HELLO';

      final isCorrect = await dataSource.checkWord(
          guessedWord: guessedWord, generatedWord: generatedWord);

      expect(isCorrect, isTrue);
    });

    test('checkWord returns false for incorrect guess', () async {
      const generatedWord = 'WORLD';
      const guessedWord = 'GUESS';

      final isCorrect = await dataSource.checkWord(
          guessedWord: guessedWord, generatedWord: generatedWord);

      expect(isCorrect, isFalse);
    });
  });
}
