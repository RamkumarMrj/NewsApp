import 'package:flutter/material.dart';
import 'package:myapp/explore/article.dart';

class NewsSearchDelegate extends SearchDelegate {
  final List<Article> articles;

  NewsSearchDelegate(this.articles);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = articles.where((article) => article.title!.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final article = results[index];
        return ListTile(
          title: Text(article.title!),
          subtitle: Text(article.source.name!),
          onTap: () {
            // Handle article tap
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = articles.where((article) => article.title!.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final article = suggestions[index];
        return ListTile(
          title: Text(article.title!),
          subtitle: Text(article.source.name!),
          onTap: () {
            query = article.title!;
            showResults(context);
          },
        );
      },
    );
  }
}
