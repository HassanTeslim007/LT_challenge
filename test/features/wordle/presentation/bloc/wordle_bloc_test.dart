import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lt_challenge/features/Wordle/presentation/bloc/wordle_bloc.dart';
import 'package:lt_challenge/features/wordle/data/wordle_datasource.dart';
import 'package:mocktail/mocktail.dart';

class MockWordleDataSource with Mock implements WordleDataSource {}

void main() {
  late MockWordleDataSource mockWordleDataSource;
  late WordleBloc wordleBloc;
  setUp(() {
    mockWordleDataSource = MockWordleDataSource();
    wordleBloc = WordleBloc(mockWordleDataSource);
  });
  Future<WordleBloc> initializeBloc() async {
    return wordleBloc;
  }

  group(
    'wordle_bloc_test',
    () {
      test(
        'proper initialization',
        () async {
          expect(initializeBloc, returnsNormally);
        },
      );

      test(
        'correct initial state',
        () async {
          expect(wordleBloc.state, equals(WordleInitial()));
        },
      );

      group('adding events', () {
        const query = 'query';
        var tResult = 'trove';
        const tErrorMessage = 'Word unavailable, try another word';
        blocTest(
          'emits [WordleGenerated]state if event call is successful',
          build: () => WordleBloc(mockWordleDataSource),
          act: (bloc) {
            when(() => mockWordleDataSource.generateWord())
                .thenAnswer((_) async => tResult);
            bloc.add(
              GenerateRandomWordEvent(),
            );
          },
          expect: () => [
            WordleGenerated(tResult),
          ],
        );

        blocTest(
          'emits [WordleSuccess] state if event call is successful',
          build: () => WordleBloc(mockWordleDataSource),
          act: (bloc) {
            when(() => mockWordleDataSource.doesWordExist(
                  any(),
                )).thenAnswer((_) async => true);
            bloc.add(
              CheckWordEvent(query),
            );
          },
          expect: () => [WordleSuccess()],
        );

        blocTest(
          'emits [WordleFailure] states if event call fails',
          build: () => WordleBloc(mockWordleDataSource),
          act: (bloc) {
            when(() => mockWordleDataSource.doesWordExist(any()))
                .thenAnswer((_) async => false);
            bloc.add(CheckWordEvent(query));
          },
          expect: () => [WordleError(tErrorMessage)],
        );
      });
    },
  );
}
