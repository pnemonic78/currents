import 'package:currentsapi_auth/user/user_controller.dart';
import 'package:currentsapi_settings/settings/settings_ext.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import 'my_route.dart';

class MyMiddleware extends GetMiddleware {
  final _userController = Get.find<UserController>();

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    _applyPreferences();
    return super.onPageBuildStart(page);
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.
    FlutterNativeSplash.remove();

    return super.onPageCalled(page);
  }

  @override
  RouteSettings? redirect(String? route) {
    if (_userController.isSignedIn.isTrue || (route == MyAppRoute.SignIn)) {
      return null;
    }
    return const RouteSettings(name: MyAppRoute.SignIn);
  }

  void _applyPreferences() async {
    final prefs = _userController.user.value;
    applyTheme(prefs.theme);
  }
}
