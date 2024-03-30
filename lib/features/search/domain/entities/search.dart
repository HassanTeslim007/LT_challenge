// ignore_for_file: public_member_api_docs, sort_constructors_first
class SearchResult {
  String? nextPageToken;
  List<Item>? items;

  SearchResult({this.nextPageToken, this.items});

  SearchResult.fromJson(Map<String, dynamic> json) {
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
      'SearchResult(nextPageToken: $nextPageToken, items: $items)';
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
}
