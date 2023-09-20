import 'package:currentsapi_auth/user/user_controller.dart';
import 'package:get/get.dart';

import 'my_route.dart';

class MyHomeController extends GetxController {
  final _userController = Get.find<UserController>();
  bool _gotoBusy = false;

  bool get isSignedIn => _userController.isSignedIn.value;

  @override
  void onReady() {
    _userController.listenSignedIn(_onSignedInChanged);
    super.onReady();
  }

  void listenSignedIn(void Function(bool isSignedIn) onSignedInChanged) {
    _userController.listenSignedIn(onSignedInChanged);
  }

  void _gotoNews() async {
    Get.offAllNamed(MyAppRoute.LatestNews);
  }

  void _gotoSignIn() async {
    Get.offAllNamed(MyAppRoute.SignIn);
  }

  void _onSignedInChanged(bool isSignedIn) {
    if (_gotoBusy) return;
    _gotoBusy = true;
    isSignedIn ? _gotoNews() : _gotoSignIn();
    _gotoBusy = false;
  }
}
