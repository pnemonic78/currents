import 'package:currentsapi_auth/user/user_controller.dart';
import 'package:currentsapi_core/data/repo.dart';
import 'package:currentsapi_model/api/category.dart' as cac;
import 'package:currentsapi_model/api/language.dart' as cal;
import 'package:currentsapi_model/api/region.dart';
import 'package:currentsapi_model/api/search_request.dart';
import 'package:currentsapi_model/db/config_doc.dart';
import 'package:currentsapi_model/db/news_db.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchFormController extends GetxController {
  final _userController = Get.find<UserController>();
  final _repo = Get.find<CurrentsRepository>();

  Rx<UserPreferences> get user => _userController.user;

  Rx<ConfigurationDocument> config = ConfigurationDocument().obs;

  List<String> get categories => config.value.categories;

  List<String> get languages => config.value.languages;

  List<String> get regions => config.value.regions;

  Rx<SearchRequest> form = SearchRequest().obs;

  @override
  void onInit() async {
    final ConfigurationDocument config = await _repo.getConfiguration();
    config.categories.sort();
    this.config.value = config;
    super.onInit();
  }

  void onCategoryChanged(cac.Category? value) {
    form.value.category = value?.id;
  }

  void onLanguageChanged(cal.Language? value) {
    form.value.language = value?.id ?? cal.Language.english;
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
