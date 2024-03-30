import 'dart:convert';
import 'dart:developer';

import 'package:lt_challenge/core/failure/exceptions.dart';
import 'package:lt_challenge/core/utils/secrets.dart';
import 'package:lt_challenge/features/search/domain/entities/search.dart';
import 'package:http/http.dart' as http;

abstract interface class SearchDataSource {
  Future<SearchResult> search({required String query, String? nextPageToken});
}

class SearchDataSourceImpl implements SearchDataSource {
  final http.Client client;

  SearchDataSourceImpl(this.client);
  @override
  Future<SearchResult> search(
      {required String query, String? nextPageToken}) async {
    try {
      final response = await client.get(
        //Base URL: 'www.googleapis.com'
          Uri.https(Secrets.BASE_URL, '/youtube/v3/search', {
            'part': 'snippet',
            'q': query,
            'pageToken': nextPageToken ?? '',
            'maxResults': '5',
            'key': Secrets.API_KEY,
          }),
          headers: {'Accept': 'application/json'});
      SearchResult result;
      if (response.statusCode.toString().startsWith('2')) {
        result = SearchResult.fromJson(jsonDecode(response.body));
      } else {
        throw CustomException(
                message: jsonDecode(response.body)['error']['message'])
            .message;
      }
      return result;
    } catch (e) {
      log(e.toString());
      throw CustomException(message: e.toString());
    }
  }
}
