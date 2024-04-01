import 'package:flutter/foundation.dart';
import 'package:lt_challenge/features/search/domain/entities/search.dart';

class SearchResultModel extends SearchResult {
  SearchResultModel({required super.items, required super.nextPageToken});

  SearchResultModel.empty() {
    items = [];
    nextPageToken = 'PageToken';
  }

  SearchResultModel.fromJson(Map<String, dynamic> json) {
    nextPageToken = json['nextPageToken'];
    if (json['items'] != null) {
      items = <Item>[];
      json['items'].forEach((v) {
        items!.add(Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nextPageToken'] = nextPageToken;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() =>
      'SearchResultModel(nextPageToken: $nextPageToken, items: $items)';

  @override
  bool operator ==(covariant SearchResult other) {
    if (identical(this, other)) return true;

    return other.nextPageToken == nextPageToken &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode => nextPageToken.hashCode ^ items.hashCode;
}
