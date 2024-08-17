import 'package:flutter/material.dart';
import 'package:myapp/explore/article.dart';

class DetailPage extends StatelessWidget {
  final Article article;

  const DetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.source.name ?? 'Article Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageSection(
              imageUrl: article.urlToImage,
              placeholderText:
                  article.urlToImage == null ? article.source.name : null,
            ),
            TitleSection(
                title: article.title ?? '',
                subtitle: article.publishedAt ?? ''),
            TextSection(description: article.description ?? ''),
            const ButtonSection(),
          ],
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final Article article;

  const MyCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image.network(
          //   article.urlToImage ?? '',
          //   height: 200,
          //   width: double.infinity,
          //   fit: BoxFit.cover,
          //   errorBuilder: (context, error, stackTrace) =>
          //       const Center(child: Icon(Icons.error)),
          // ),
          _buildImageOrSource(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title ?? 'No Title',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  formatDate(article.publishedAt) ?? 'No Date',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  article.description?.substring(0,100) ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite_outline),
                      onPressed: () {
                        // Add like functionality
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.bookmark_outline),
                      onPressed: () {
                        // Add save functionality
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.share_outlined),
                      onPressed: () {
                        // Add share functionality
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageOrSource() {
    if (article.urlToImage != null && article.urlToImage!.isNotEmpty) {
      return Stack(
        alignment: Alignment.bottomRight,
        children: [
          Image.network(
            article.urlToImage!,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Center(child: Icon(Icons.error)),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                article.source.name ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Container(
        height: 200,
        color: Colors.grey, // Placeholder color
        child: Center(
          child: Text(
            article.source.name ?? 'Unknown Source',
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  String? formatDate(String? dateString) {
    if (dateString == null) return null;
    DateTime? dateTime = DateTime.tryParse(dateString);
    if (dateTime == null) return null;
    return '${dateTime.day}-${dateTime.month}-${dateTime.year}';
  }
}

class ImageSection extends StatelessWidget {
  final String? imageUrl;
  final String? placeholderText;

  const ImageSection({super.key, this.imageUrl, this.placeholderText});

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return Image.network(imageUrl!);
    } else if (placeholderText != null) {
      return Container(
        height: 200, // Adjust height as needed
        color: Colors.grey[300],
        alignment: Alignment.center,
        child: Text(
          placeholderText!,
          style: const TextStyle(fontSize: 18),
        ),
      );
    } else {
      return const SizedBox.shrink(); // Or any other default behavior
    }
  }
}

class TitleSection extends StatelessWidget {
  final String title;
  final String subtitle;

  const TitleSection({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}

class TextSection extends StatelessWidget {
  final String description;

  const TextSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        description,
        style: const TextStyle(fontSize: 16.0),
        textAlign: TextAlign.justify,
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ButtonWithText(
            icon: Icons.favorite_outline, label: 'Like', onPressed: () {}),
        ButtonWithText(
            icon: Icons.bookmark_outline, label: 'Save', onPressed: () {}),
        ButtonWithText(
            icon: Icons.share_outlined, label: 'Share', onPressed: () {}),
      ],
    );
  }
}

class ButtonWithText extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const ButtonWithText(
      {super.key,
      required this.icon,
      required this.label,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
        ),
        Text(label),
      ],
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: (_isFavorited
          ? const Icon(Icons.favorite)
          : const Icon(Icons.favorite_outline)),
      color: Colors.red,
      onPressed: _toggleFavorite,
    );
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }
}
