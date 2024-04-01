import 'dart:convert';

import 'package:lt_challenge/core/failure/exceptions.dart';
import 'package:lt_challenge/core/utils/secrets.dart';
import 'package:lt_challenge/features/search/data/datasource/remote_datasource.dart';
import 'package:lt_challenge/features/search/data/models/searchmodel.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late SearchDataSourceImpl dataSource;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = SearchDataSourceImpl(mockHttpClient);
  });

  // Helper function to mock successful responses
  void setUpMockHttpClientSuccess() {
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response(
            jsonEncode({
              'nextPageToken': 'nextPageToken',
              'items': [
                {
                  'snippet': {
                    'publishedAt': '2021-07-10T15:00:10Z',
                    'channelId': 'channelId',
                    'title': 'Test Video',
                    'description': 'Test Description',
                    'thumbnails': {
                      'high': {'url': 'https://example.com/thumbnail.jpg'}
                    },
                    'channelTitle': 'Test Channel',
                    'liveBroadcastContent': 'none',
                    'publishTime': '2021-07-10T15:00:10Z',
                  },
                  'id': {'videoId': 'videoId'}
                }
              ],
            }),
            200));
  }

  // Helper function to mock failure responses
  void setUpMockHttpClientFailure() {
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response('Not Found', 404));
  }

  group('search', () {
    const query = 'flutter';

    test('should return SearchResultModel on a successful API call', () async {
      setUpMockHttpClientSuccess();

      final result = await dataSource.search(query: query);

      expect(result, isA<SearchResultModel>());
      expect(result.items, isNotEmpty);

      // Verify that the get method was called on the client with the correct Uri and headers
      verify(() => mockHttpClient.get(
              Uri.https(Secrets.BASE_URL, '/youtube/v3/search', {
                'part': 'snippet',
                'q': query,
                'pageToken': '',
                'maxResults': '5',
                'key': Secrets.API_KEY,
              }),
              headers: {'Accept': 'application/json'}))
          .called(1); // Verify that the method was called exactly once
    });

    test('should throw CustomException on API call failure', () async {
      setUpMockHttpClientFailure();

      final call = dataSource.search;

      // NOTE: Do this only when you throw CustomException in the error bit
      expect(() => call(query: query), throwsA(isA<CustomException>()));

      // Verify the interaction with the mock even on failure
      verify(() => mockHttpClient.get(
              Uri.https(Secrets.BASE_URL, '/youtube/v3/search', {
                'part': 'snippet',
                'q': query,
                'pageToken': '',
                'maxResults': '5',
                'key': Secrets.API_KEY,
              }),
              headers: {'Accept': 'application/json'}))
          .called(1); // Verify that the method was called exactly once
    });
  });
}
