import 'package:flutter/material.dart';

import 'news_arguments.dart';
import 'news_item.dart';

class NewsArticleScreen extends StatefulWidget {
  const NewsArticleScreen({super.key});

  @override
  State<NewsArticleScreen> createState() => _NewsArticleScreenState();
}

class _NewsArticleScreenState extends State<NewsArticleScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as NewsArguments;
    final news = args.news;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(news.title),
      ),
      body: NewsItem(article: news),
    );
  }
}
