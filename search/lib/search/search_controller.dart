import 'package:currentsapi_auth/user/user_controller.dart';
import 'package:currentsapi_core/data/repo.dart';
import 'package:currentsapi_model/api/language.dart';
import 'package:currentsapi_model/api/region.dart';
import 'package:currentsapi_model/api/search_request.dart';
import 'package:currentsapi_model/db/filters_db.dart';
import 'package:currentsapi_model/db/news_db.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchFormController extends GetxController {
  final _userController = Get.find<UserController>();
  final _repo = Get.find<CurrentsRepository>();

  Rx<UserPreferences> get user => _userController.user;

  Rx<FiltersCollection> filters = FiltersCollection().obs;

  get categories => filters.value.categories;

  get languages => filters.value.languages;

  get regions => filters.value.regions;

  Rx<SearchRequest> form = SearchRequest().obs;

  @override
  void onInit() async {
    final FiltersCollection filters = await _repo.getFilters();
    filters.categories.sort();
    this.filters.value = filters;
    super.onInit();
  }

  void onCategoryChanged(String? value) {
    form.value.category = value;
  }

  void onLanguageChanged(Language? value) {
    form.value.language = value?.id ?? Language.english;
  }

  void onRegionChanged(Region? value) {
    form.value.country = value?.id ?? Region.regionInternational;
  }

  void onStartDateChanged(DateTime? date) {
    form.value.startDate = date;
  }

  void onEndDateChanged(DateTime? date) {
    form.value.endDate = date;
  }

  void onDatesChanged(DateTimeRange dateTimeRange) {
    onStartDateChanged(dateTimeRange.start);
    onEndDateChanged(dateTimeRange.end);
  }

  void onKeywordsChanged(String? keywords) {
    form.value.keywords = keywords;
  }

  void onSearch(Function(SearchRequest)? onSearchPressed) {
    final SearchRequest request = form.value;
    onSearchPressed?.call(request);
  }

  Stream<NewsCollection> getSearchResults({
    required SearchRequest request,
    bool refresh = false,
  }) async* {
    yield* _repo.getSearch(request, refresh: refresh);
  }
}
