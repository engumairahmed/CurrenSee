import 'package:currensee/models/rss_model.dart';
import 'package:currensee/rss_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<RssItem>> futureRssItems;

  @override
  void initState() {
    super.initState();
    futureRssItems = RssService().fetchRssItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latest News'),
      ),
      body: FutureBuilder<List<RssItem>>(
        future: futureRssItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            return NewsList(rssItems: snapshot.data!);
          }
        },
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  final List<RssItem> rssItems;

  const NewsList({Key? key, required this.rssItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rssItems.length,
      itemBuilder: (context, index) {
        final item = rssItems[index];
        return ListTile(
          title: Text(item.title),
          subtitle: Text(item.pubDate),
          leading: item.thumbnailUrl != null ? Image.network(item.thumbnailUrl!) : null,
          onTap: () {
            _launchURL(context, item.link);
          },
        );
      },
    );
  }

  void _launchURL(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Could not launch $url'),
      ));
    }
  }
}
