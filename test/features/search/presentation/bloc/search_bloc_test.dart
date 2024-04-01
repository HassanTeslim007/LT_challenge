import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lt_challenge/core/failure/failure.dart';
import 'package:lt_challenge/features/search/domain/entities/search.dart';
import 'package:lt_challenge/features/search/domain/repository/search_repository.dart';
import 'package:lt_challenge/features/search/presentation/bloc/search_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchRepository with Mock implements SearchRepository {}

void main() {
  late MockSearchRepository mockSearchRepository;
  late SearchBloc searchBloc;
  setUp(() {
    mockSearchRepository = MockSearchRepository();
    searchBloc = SearchBloc(searchRepository: mockSearchRepository);
  });
  Future<SearchBloc> initializeBloc() async {
    return searchBloc;
  }

  group(
    'search_bloc_test',
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
          expect(searchBloc.state, equals(SearchInitial()));
        },
      );

      group('adding events', () {
        const query = 'query';
        var tResult = SearchResult();
        var tFailure = Failure();
        String? tNextPageToken = tResult.nextPageToken;
        blocTest(
          'emits [SearchLoading] and [SearchSuccess] states if event call is successful',
          build: () => SearchBloc(searchRepository: mockSearchRepository),
          act: (bloc) {
            when(() => mockSearchRepository.search(query: query))
                .thenAnswer((_) async => Right(tResult));
            bloc.add(
              Search(query),
            );
          },
          expect: () => [
            SearchLoading(),
            SearchSuccess(tResult, tResult.items ?? []),
          ],
        );

        blocTest(
          'emits [SearchLoading] and [SearchFailure] states if event call fails',
          build: () => SearchBloc(searchRepository: mockSearchRepository),
          act: (bloc) {
            when(() => mockSearchRepository.search(query: query))
                .thenAnswer((_) async => Left(tFailure));
            bloc.add(
              Search(query),
            );
          },
          expect: () => [SearchLoading(), SearchFailure(tFailure.message)],
        );

        blocTest(
          'emits [SearchLoadingMore] and [SearchSuccess] states if event call is successful',
          build: () => SearchBloc(searchRepository: mockSearchRepository),
          act: (bloc) {
            when(() => mockSearchRepository.search(
                    query: any(named: 'query'), nextPageToken: any(named: 'nextPageToken')))
                .thenAnswer((_) async => Right(tResult));
            bloc.add(
              LoadMore(query, tNextPageToken ?? ''),
            );
          },
          expect: () => [
            SearchLoadingMore(),
            SearchSuccess(tResult, tResult.items ?? []),
          ],
        );

        blocTest(
          'emits [SearchLoadingMore] and [SearchFailure] states if event call fails',
          build: () => SearchBloc(searchRepository: mockSearchRepository),
          act: (bloc) {
            when(() => mockSearchRepository.search(
                     query: any(named: 'query'), nextPageToken: any(named: 'nextPageToken')))
                .thenAnswer((_) async => Left(tFailure));
            bloc.add(
              LoadMore(query, tNextPageToken ?? ''),
            );
          },
          expect: () => [SearchLoadingMore(), SearchFailure(tFailure.message)],
        );
      });
    },
  );
}
