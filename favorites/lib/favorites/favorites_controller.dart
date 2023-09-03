import 'package:currentsapi_auth/user/user_controller.dart';
import 'package:currentsapi_model/api/news.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';
import 'package:get/get.dart';

class FavoritesPageController extends GetxController {
  final _userController = Get.find<UserController>();

  Rx<UserPreferences> get user => _userController.user;

  List<Article> get favorites => user.value.favorites;
}
