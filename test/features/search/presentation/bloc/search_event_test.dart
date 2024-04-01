import 'package:flutter_test/flutter_test.dart';
import 'package:lt_challenge/features/search/presentation/bloc/search_bloc.dart';

void main() {
  group(
    'SearchEvent',
    () {
      group('Search', () {
        const query = 'test query';
        test('value equality', () {
          expect(Search(query), Search(query));
        });

        test('props are correct', () {
          expect(Search(query).props, <Object?>[query]);
        });

        test('is a searchEvent', () {
          expect(Search(query), isA<SearchEvent>());
        });
      });

      group('Load More', () {
        const query = 'test query';
        const nextPageToken = 'page token';
        test('value equality', () {
          expect(
              LoadMore(query, nextPageToken), LoadMore(query, nextPageToken));
        });

        test('props are correct', () {
          expect(LoadMore(query, nextPageToken).props,
              <Object?>[query, nextPageToken]);
        });

         test('is a searchEvent', () {
          expect(LoadMore(query, nextPageToken), isA<SearchEvent>());
        });
      });
    },
  );
}
