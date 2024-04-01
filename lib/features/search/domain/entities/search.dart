// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class SearchResult {
  String? nextPageToken;
  List<Item>? items;

  SearchResult({this.nextPageToken, this.items});

  @override
  bool operator ==(covariant SearchResult other) {
    if (identical(this, other)) return true;

    return other.nextPageToken == nextPageToken &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode => nextPageToken.hashCode ^ items.hashCode;
}

class Item {
  String? publishedAt;
  String? channelId;
  String? title;
  String? description;
  String? thumbnail;
  String? channelTitle;
  String? liveBroadcastContent;
  String? publishTime;
  String? videoId;

  Item(
      {this.publishedAt,
      this.channelId,
      this.title,
      this.description,
      this.thumbnail,
      this.channelTitle,
      this.liveBroadcastContent,
      this.publishTime,
      this.videoId});

  Item.fromJson(Map<String, dynamic> json) {
    publishedAt = json['snippet']['publishedAt'];
    channelId = json['snippet']['channelId'];
    title = json['snippet']['title'];
    description = json['snippet']['description'];
    thumbnail = json['snippet']['thumbnails']['high']['url'];
    channelTitle = json['snippet']['channelTitle'];
    liveBroadcastContent = json['snippet']['liveBroadcastContent'];
    publishTime = json['snippet']['publishTime'];
    videoId = json['id']['videoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['publishedAt'] = publishedAt;
    data['channelId'] = channelId;
    data['title'] = title;
    data['description'] = description;
    data['url'] = thumbnail;
    data['channelTitle'] = channelTitle;
    data['liveBroadcastContent'] = liveBroadcastContent;
    data['publishTime'] = publishTime;
    data['videoId'] = videoId;
    return data;
  }

  @override
  String toString() {
    return 'Items(publishedAt: $publishedAt, channelId: $channelId, title: $title, description: $description, url: $thumbnail, channelTitle: $channelTitle, liveBroadcastContent: $liveBroadcastContent, publishTime: $publishTime, videoId: $videoId)';
  }

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;

    return other.publishedAt == publishedAt &&
        other.channelId == channelId &&
        other.title == title &&
        other.description == description &&
        other.thumbnail == thumbnail &&
        other.channelTitle == channelTitle &&
        other.liveBroadcastContent == liveBroadcastContent &&
        other.publishTime == publishTime &&
        other.videoId == videoId;
  }

  @override
  int get hashCode {
    return publishedAt.hashCode ^
        channelId.hashCode ^
        title.hashCode ^
        description.hashCode ^
        thumbnail.hashCode ^
        channelTitle.hashCode ^
        liveBroadcastContent.hashCode ^
        publishTime.hashCode ^
        videoId.hashCode;
  }
}
