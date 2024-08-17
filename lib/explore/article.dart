class Article {
  final String? title;
  final String? description;
  final String? urlToImage;
  final String? publishedAt;
  final Source source;

  Article({
    this.title,
    this.description,
    this.urlToImage,
    this.publishedAt,
    required this.source,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      description: json['description'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      source: Source.fromJson(json['source']),
    );
  }
}

class Source {
  final String? id;
  final String? name;

  Source({
    this.id,
    this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name'] ?? "Unknown Source",
    );
  }
}