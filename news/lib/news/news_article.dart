import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:currentsapi_model/api/news.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';

import 'news_item.dart';

class NewsArticlePage extends StatefulWidget {
  final Article article;

  const NewsArticlePage({super.key, required this.article});

  @override
  State<NewsArticlePage> createState() => _NewsArticlePageState();
}

class _NewsArticlePageState extends State<NewsArticlePage> {
  static const _imageAspectRatio = NewsItem.imageAspectRatio;

  @override
  Widget build(BuildContext context) {
    final article = widget.article;
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final imageWidth = width;
    final imageHeight = imageWidth / _imageAspectRatio;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final icon = Icon(
      Icons.image,
      color: Colors.grey,
      size: max(imageWidth, imageHeight),
    );

    final List<Widget> categories = article.category
        .map(
          (e) => ActionChip(
            label: Text(e),
            onPressed: () => _filterCategory(e),
          ),
        )
        .toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Text(
              article.author ?? "",
              style: textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
            child: Text(
              article.title ?? "",
              style: textTheme.headlineMedium,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              intl.DateFormat.yMMMMd().format(article.published),
              style: textTheme.bodyMedium,
            ),
          ),
          article.isValidImage
              ? CachedNetworkImage(
                  key: Key(article.id),
                  imageUrl: article.image!,
                  placeholder: (context, url) => icon,
                  width: imageWidth,
                  height: imageHeight,
                  fit: BoxFit.fitWidth,
                )
              : icon,
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
            child: Text(
              article.description,
              style: textTheme.bodyLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
            child: TextButton(
              onPressed: _gotoArticle,
              child: const Text('Source Article'),
            ),
          ),
          (categories.isNotEmpty)
              ? Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: Text(
                    'Categories',
                    style: textTheme.titleMedium,
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Wrap(
              children: categories,
            ),
          ),
        ],
      ),
    );
  }

  void _gotoArticle() async {
    final article = widget.article;
    final urlString = article.url;
    final url = Uri.parse(urlString);
    launchUrl(url);
  }

  void _filterCategory(String category) async {
    //TODO implement me!
  }
}