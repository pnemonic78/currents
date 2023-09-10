import 'package:currentsapi_core/ui/locale_ext.dart';
import 'package:currentsapi_model/api/category.dart' as cac;
import 'package:currentsapi_model/api/language.dart' as cal;
import 'package:currentsapi_model/api/region.dart';
import 'package:currentsapi_model/api/search_request.dart';
import 'package:currentsapi_search/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class SearchForm extends StatefulWidget {
  const SearchForm({super.key, this.onSearchPressed});

  final ValueChanged<SearchRequest>? onSearchPressed;

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _controller = Get.put<SearchFormController>(SearchFormController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildKeywords(context, _controller.form.value.keywords),
              const SizedBox(height: 8.0),
              Obx(() =>
                  _buildCategories(context, _controller.form.value.category)),
              const SizedBox(height: 8.0),
              Obx(() =>
                  _buildLanguages(context, _controller.form.value.language)),
              const SizedBox(height: 8.0),
              Obx(() => _buildRegions(context, _controller.form.value.country)),
              const SizedBox(height: 8.0),
              _buildDates(
                context,
                _controller.form.value.startDate,
                _controller.form.value.endDate,
              ),
              const SizedBox(height: 8.0),
              _buildSubmitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeywords(BuildContext context, String? keywordsSelected) {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.key),
        hintText: "Search for text",
        labelText: "Keywords",
      ),
      maxLines: 2,
      initialValue: keywordsSelected ?? "",
      onSaved: _controller.onKeywordsChanged,
    );
  }

  Widget _buildCategories(BuildContext context, String? categoryCodeSelected) {
    final List<cac.Category> categories = [
          cac.Category(id: "", name: "(All)")
        ] +
        (_controller.categories
            .map((e) => (e, _getCategoryName(context, e)))
            .where((p) => p.$2 != null)
            .map((p) => cac.Category(id: p.$1, name: p.$2!))
            .toList()
          ..sort((a, b) => a.name.compareTo(b.name)));
    final categorySelected =
        categories.firstWhereOrNull((e) => e.id == categoryCodeSelected);

    return DropdownButtonFormField<cac.Category>(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.category),
      ),
      hint: const Text("Select a Category"),
      items: categories
          .map((e) =>
              DropdownMenuItem<cac.Category>(value: e, child: Text(e.name)))
          .toList(),
      onChanged: _controller.onCategoryChanged,
      value: categorySelected,
    );
  }

  Widget _buildLanguages(BuildContext context, String? languageCodeSelected) {
    final List<String> languageCodes = _controller.languages;
    final List<cal.Language> languages = languageCodes
        .map((e) => (e, getLanguageName(context, e)))
        .where((p) => p.$2 != null)
        .map((p) => cal.Language(id: p.$1, name: p.$2!))
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    final languageSelected =
        languages.firstWhereOrNull((e) => e.id == languageCodeSelected);

    return DropdownButtonFormField<cal.Language>(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.language),
      ),
      hint: const Text("Select a Language"),
      items: languages
          .map((e) =>
              DropdownMenuItem<cal.Language>(value: e, child: Text(e.name)))
          .toList(),
      onChanged: _controller.onLanguageChanged,
      value: languageSelected,
    );
  }

  Widget _buildRegions(BuildContext context, String? regionCodeSelected) {
    final List<String> regionCodes = _controller.regions;
    final List<Region> regions = [Region(id: "", name: "(All)")] +
        (regionCodes
            .map((e) => (e, getRegionName(context, e)))
            .where((p) => p.$2 != null)
            .map((p) => Region(id: p.$1, name: p.$2!))
            .toList()
          ..sort((a, b) => a.name.compareTo(b.name)));
    final regionSelected =
        regions.firstWhereOrNull((e) => e.id == regionCodeSelected);

    return DropdownButtonFormField<Region>(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.location_pin),
      ),
      hint: const Text("Select a Region"),
      items: regions
          .map((e) => DropdownMenuItem<Region>(value: e, child: Text(e.name)))
          .toList(),
      onChanged: _controller.onRegionChanged,
      value: regionSelected,
    );
  }

  Widget _buildDates(
    BuildContext context,
    DateTime? startDateSelected,
    DateTime? endDateSelected,
  ) {
    String? label = _formatDates(startDateSelected, endDateSelected);

    return OutlinedButton.icon(
      onPressed: () => _pickDates(context, startDateSelected, endDateSelected),
      icon: const Icon(Icons.date_range),
      label: Text(label ?? "Start and End Dates"),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: ElevatedButton.icon(
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
            _controller.onSearch(widget.onSearchPressed);
          }
        },
        icon: const Icon(Icons.search),
        label: const Text('Search'),
      ),
    );
  }

  String? _formatDate(DateTime? date) {
    return (date != null) ? intl.DateFormat.yMMMMd().format(date) : null;
  }

  String? _formatDates(DateTime? firstDate, DateTime? lastDate) {
    String? first = _formatDate(firstDate) ?? "";
    String? last = _formatDate(lastDate) ?? "";
    if (first.isNotEmpty) {
      if (last.isNotEmpty) {
        return "$first - $last";
      }
      return first;
    }
    if (last.isNotEmpty) {
      return last;
    }
    return null;
  }

  void _pickDates(
    BuildContext context,
    DateTime? firstDateDelected,
    DateTime? lastDateSelected,
  ) async {
    final now = DateTime.now();

    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: firstDateDelected ?? now,
        end: lastDateSelected ?? now,
      ),
      firstDate: now.subtract(const Duration(days: 366)),
      lastDate: now,
      currentDate: now,
    );
    if (picked != null) {
      final startDate =
          picked.start.copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);
      final endDate = picked.end
          .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999);
      setState(() {
        _controller.onStartDateChanged(startDate);
        _controller.onEndDateChanged(endDate);
      });
    }
  }

  String? _getCategoryName(BuildContext context, String categoryCode) {
    return (categoryCode.toLowerCase() == categoryCode)
        ? categoryCode.capitalize
        : categoryCode;
  }
}
