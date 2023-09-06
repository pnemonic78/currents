import 'package:currentsapi_auth/user/user_controller.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';
import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  final _userController = Get.find<UserController>();

  Rx<UserPreferences> get user => _userController.user;
}
