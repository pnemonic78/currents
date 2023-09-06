import 'package:currentsapi_search/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchForm extends StatefulWidget {
  const SearchForm({super.key});

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _controller = Get.put<SearchFormController>(SearchFormController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Form(
      child: Column(
        children: [
          _buildCategories(context),
          _buildLanguages(context),
          _buildRegions(context),
          _buildDates(context),
        ],
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    final List<String> categories = _controller.categories;

    return DropdownButtonFormField(
      items: categories
          .map(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
      onChanged: _controller.onCategoryChanged,
    );
  }

  Widget _buildLanguages(BuildContext context) {
    return Container();
  }

  Widget _buildRegions(BuildContext context) {
    return Container();
  }

  Widget _buildDates(BuildContext context) {
    return Row();
  }
}
