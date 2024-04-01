import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lt_challenge/features/search/data/datasource/remote_datasource.dart';
import 'package:lt_challenge/features/search/data/repository/search_repository_impl.dart';
import 'package:lt_challenge/features/search/domain/entities/search.dart';
import 'package:lt_challenge/features/search/domain/repository/search_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchDataSource extends Mock implements SearchDataSource {}

void main() {
  late SearchDataSource mockDataSource;
  late SearchRepository searchRepository;

  const query = 'query';
  SearchResult tResult = (SearchResult(nextPageToken: 'nextPageToken', items: [
    Item(
      publishTime: 'publishedTime',
      publishedAt: 'PublishedAt',
      title: 'title',
      thumbnail: 'url',
      videoId: 'videoId',
      description: 'description',
      channelTitle: 'channelTitle',
      liveBroadcastContent: 'none',
    )
  ]));

  setUp(() {
    mockDataSource = MockSearchDataSource();
    searchRepository = SearchRepositoryImpl(mockDataSource);
  });

  void setUpSearchRepoSuccessCall() {
    when(() => mockDataSource.search(query: any(named: 'query')))
        .thenAnswer((_) async => tResult);
  }

  test(
    'Returns [Right<SearchResult>] when called successfully',
    () async {
      setUpSearchRepoSuccessCall();

      final result = await searchRepository.search(query: query);

      expect(result, Right<dynamic, SearchResult>(tResult));
      verify(() => mockDataSource.search(query: query)).called(1);
      verifyNoMoreInteractions(mockDataSource);
    },
  );
}
