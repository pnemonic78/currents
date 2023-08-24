import 'package:currentsapi_model/api/news.dart';
import 'package:flutter/material.dart';

import 'latest_news.dart';

class LatestNewsScreen extends StatefulWidget {
  const LatestNewsScreen({super.key, this.onTap});

  final ValueChanged<Article>? onTap;

  @override
  State<LatestNewsScreen> createState() => _LatestNewsScreenState();
}

class _LatestNewsScreenState extends State<LatestNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Latest News"),
      ),
      body: LatestNews(onTap: widget.onTap),
    );
  }
}
