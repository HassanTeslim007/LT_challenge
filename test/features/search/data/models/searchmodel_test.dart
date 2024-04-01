import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lt_challenge/features/search/data/models/searchmodel.dart';
import 'package:lt_challenge/features/search/domain/entities/search.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tModel = SearchResultModel(nextPageToken: 'nextPageToken', items: [
    Item(
        channelId: 'channelId',
        publishTime: "2021-07-10T15:00:10Z",
        publishedAt: "2021-07-10T15:00:10Z",
        description: "Test Description",
        thumbnail: "https://example.com/thumbnail.jpg",
        channelTitle: "Test Channel",
        liveBroadcastContent: "none",
        videoId: "videoId",
        title: "Test Video")
  ]);
  test('Should be a sub-class of the [SearchResult] entity', () {
    expect(tModel, isA<SearchResult>());
  });

  final tJson = fixture('search_result.json');
  final tMap = jsonDecode(tJson) as Map<String, dynamic>;

  group('Serialization', () {
    test('should return a [SearchResultModel] with correct data', () {
      final result = SearchResultModel.fromJson(tMap);

      expect(result, isA<SearchResult>());
      expect(result, tModel);
    });

    test('should return a [Json] with correct data', () {
      final result = tModel.toJson();

      expect(result, isA<Map<String, dynamic>>());
      expect(result, {
        "nextPageToken": 'nextPageToken',
        "items": [
          {
            "channelId": 'channelId',
            "publishTime": "2021-07-10T15:00:10Z",
            "publishedAt": "2021-07-10T15:00:10Z",
            "description": "Test Description",
            "url": "https://example.com/thumbnail.jpg",
            "channelTitle": "Test Channel",
            "liveBroadcastContent": "none",
            "videoId": "videoId",
            "title": "Test Video"
          }
        ]
      });
    });
  });

  group('equality', () {
    test('should show that objects are equal', () {
      expect(tModel, equals(tModel));
    });
  });
}
