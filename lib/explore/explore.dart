import 'package:flutter/material.dart';
import 'package:myapp/explore/article.dart';
import 'news_details.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=f471c84e766247bf81ea62006861eee0');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          articles = (jsonData['articles'] as List)
              .map((articleJson) => Article.fromJson(articleJson))
              .toList();
        });
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(article: articles[index]),
              ),
            );
          },
          child: MyCard(article: articles[index]),
        );
      },
    );
  }
}
