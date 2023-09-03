import 'package:currentsapi_news/news/news_arguments.dart';
import 'package:currentsapi_news/news/news_article.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsArticleScreen extends StatefulWidget {
  const NewsArticleScreen({super.key});

  @override
  State<NewsArticleScreen> createState() => _NewsArticleScreenState();
}

class _NewsArticleScreenState extends State<NewsArticleScreen> {
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as NewsArguments;
    final article = args.news;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(article.title),
      ),
      body: NewsArticlePage(article: article),
    );
  }
}
