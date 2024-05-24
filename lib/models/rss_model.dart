class RssItem {
  final String title;
  final String link;
  final String pubDate;
  final String? thumbnailUrl;

  RssItem({
    required this.title,
    required this.link,
    required this.pubDate,
    this.thumbnailUrl,
  });  

  static RssItem fromJson(Map<String, dynamic> json) {
    return RssItem(
      title: json['title'],
      link: json['link'],
      pubDate: json['pubDate'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}