import 'package:flutter_test/flutter_test.dart';
import 'package:lt_challenge/features/Wordle/presentation/bloc/wordle_bloc.dart';
import 'package:lt_challenge/features/wordle/data/entities/letter.dart';

void main() {
  group('Wordle State', () {
    group('Wordle Initial', () {
      test('value equality', () {
        expect(WordleInitial(), WordleInitial());
      });

      test('props are correct', () {
        expect(WordleInitial().props, <Object?>[]);
      });

      test('is a WordleEvent', () {
        expect(WordleInitial(), isA<WordleState>());
      });
    });

    group('Wordle Generated', () {
      const tGeneratedWord = 'TROVE';
      test('value equality', () {
        expect(WordleGenerated(tGeneratedWord), WordleGenerated(tGeneratedWord));
      });

      test('props are correct', () {
        expect(WordleGenerated(tGeneratedWord).props, <Object?>[tGeneratedWord]);
      });

      test('is a WordleState', () {
        expect(WordleGenerated(tGeneratedWord), isA<WordleState>());
      });
    });

    group('Wordle Error', () {
        const tError = 'error';
      test('value equality', () {
        expect(WordleError(tError), WordleError(tError));
      });

      test('props are correct', () {
        expect(WordleError(tError).props, <Object?>[tError]);
      });

      test('is a WordleState', () {
        expect(WordleError(tError), isA<WordleState>());
      });
    });

    group('Wordle Success', () {
      test('value equality', () {
        expect(WordleSuccess(),
            WordleSuccess());
      });

      test('props are correct', () {
        expect(WordleSuccess().props,
            <Object?>[]);
      });

      test('is a WordleState', () {
        expect(WordleSuccess(),
            isA<WordleState>());
      });
    });
  });

  group('UpdateKey', () {
    const tPressedKeys = <Letter>[];
    test('value equality', () {
      expect(UpdateKeySuccess(pressedKeys: tPressedKeys),UpdateKeySuccess(pressedKeys: tPressedKeys));
    });

    test('props are correct', () {
      expect(UpdateKeySuccess(pressedKeys: tPressedKeys).props, <Object?>[tPressedKeys]);
    });

    test('is a WordleState', () {
      expect(UpdateKeySuccess(pressedKeys: tPressedKeys), isA<WordleState>());
    });
  });
}
