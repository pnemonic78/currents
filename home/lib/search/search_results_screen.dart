import 'package:currentsapi_model/api/search_request.dart';
import 'package:currentsapi_search/search/search_results_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'search_controller.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final _controller = Get.isRegistered<SearchScreenController>()
      ? Get.find<SearchScreenController>()
      : Get.put<SearchScreenController>(SearchScreenController());

  @override
  void initState() {
    _controller.request = Get.arguments as SearchRequest;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Search Results"),
      ),
      body: SearchResultsPage(
        request: _controller.request,
        onArticlePressed: _controller.onArticlePressed,
      ),
    );
  }
}
