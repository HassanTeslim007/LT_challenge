import 'package:flutter_test/flutter_test.dart';
import 'package:lt_challenge/features/search/domain/entities/search.dart';
import 'package:lt_challenge/features/search/presentation/bloc/search_bloc.dart';

void main() {
  group('Search State', () {
    group('Search Initial', () {
      test('value equality', () {
        expect(SearchInitial(), SearchInitial());
      });

      test('props are correct', () {
        expect(SearchInitial().props, <Object?>[]);
      });

      test('is a searchEvent', () {
        expect(SearchInitial(), isA<SearchState>());
      });
    });

    group('Search Loading', () {
      test('value equality', () {
        expect(SearchLoading(), SearchLoading());
      });

      test('props are correct', () {
        expect(SearchLoading().props, <Object?>[]);
      });

      test('is a searchState', () {
        expect(SearchLoading(), isA<SearchState>());
      });
    });

    group('Search Loading More', () {
      test('value equality', () {
        expect(SearchLoadingMore(), SearchLoadingMore());
      });

      test('props are correct', () {
        expect(SearchLoadingMore().props, <Object?>[]);
      });

      test('is a searchState', () {
        expect(SearchLoadingMore(), isA<SearchState>());
      });
    });

    group('Search Success', () {
      final tSearchResult = SearchResult();
      test('value equality', () {
        expect(SearchSuccess(tSearchResult, tSearchResult.items ?? []),
            SearchSuccess(tSearchResult, tSearchResult.items ?? []));
      });

      test('props are correct', () {
        expect(SearchSuccess(tSearchResult, const []).props,
            <Object?>[tSearchResult, const []]);
      });

      test('is a searchState', () {
        expect(SearchSuccess(tSearchResult, tSearchResult.items ?? []),
            isA<SearchState>());
      });
    });
  });

  group('Search Failure', () {
    const tMessage = 'Error Message';
    test('value equality', () {
      expect(SearchFailure(tMessage), SearchFailure(tMessage));
    });

    test('props are correct', () {
      expect(SearchFailure(tMessage).props, <Object?>[tMessage]);
    });

    test('is a searchState', () {
      expect(SearchFailure(tMessage), isA<SearchState>());
    });
  });
}
