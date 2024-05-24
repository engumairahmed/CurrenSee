import 'dart:convert';

import 'package:currensee/models/rss_model.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class RssService {
  final String url = 'http://localhost/phpapi/currensee/rssfeed.php';

  Future<List<RssItem>> fetchRssItems() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        final items = jsonData.map((item) => RssItem.fromJson(item)).toList();
        return items;
      } else {
        throw Exception('Failed to load RSS feed');
      }
    } catch (e) {
      throw Exception('Failed to load RSS feed: $e');
    }
  }
}