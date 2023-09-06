import 'package:currentsapi_auth/user/user_controller.dart';
import 'package:currentsapi_core/data/repo.dart';
import 'package:currentsapi_model/db/filters_db.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';
import 'package:get/get.dart';

class SearchFormController extends GetxController {
  final _userController = Get.find<UserController>();
  final _repo = Get.find<CurrentsRepository>();

  Rx<UserPreferences> get user => _userController.user;

  Rx<FiltersCollection> filters = FiltersCollection().obs;

  get categories => filters.value.categories;

  get languages => filters.value.languages;

  get regions => filters.value.regions;

  @override
  void onInit() async {
    filters.value = await _repo.getFilters();
    super.onInit();
  }

  void onCategoryChanged(String? value) {}

  void onLanguageChanged(String? value) {}

  void onRegionChanged(String? value) {}

  void onDatesChanged(DateTime? startDate, DateTime? endDate) {}
}
