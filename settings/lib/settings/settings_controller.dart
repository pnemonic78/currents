import 'package:currentsapi_auth/user/user_controller.dart';
import 'package:currentsapi_core/data/repo.dart';
import 'package:currentsapi_core/net/net_ext.dart';
import 'package:currentsapi_model/api/language.dart';
import 'package:currentsapi_model/db/filters_db.dart';
import 'package:currentsapi_model/prefs/theme.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';
import 'package:currentsapi_settings/settings/settings_arguments.dart';
import 'package:currentsapi_settings/settings/settings_ext.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsController extends GetxController {
  static const _urlGithub = "https://github.com/pnemonic78/currents";
  static const _emailGithub = "pnemonic@gmail.com";

  final _userController = Get.find<UserController>();
  final _repo = Get.find<CurrentsRepository>();

  Rx<UserPreferences> get user => _userController.user;

  final packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  ).obs;

  final filters = FiltersCollection().obs;

  @override
  void onInit() async {
    packageInfo.value = await PackageInfo.fromPlatform();
    filters.value = await _repo.getFilters();
    super.onInit();
  }

  void onGitHubPressed() {
    _gotoGitHub();
  }

  void _gotoGitHub() async {
    const urlString = _urlGithub;
    final url = Uri.parse(urlString);
    launchUrl(url);
  }

  void onIssuePressed(BuildContext context) {
    _sendIssue();
  }

  void _sendIssue() async {
    final uri = Uri(
      scheme: "mailto",
      path: _emailGithub,
      query: encodeQueryParameters(<String, String>{
        'subject': packageInfo.value.appName,
      }),
    );
    launchUrl(uri);
  }

  void updateTheme(AppThemeMode themeMode) async {
    applyTheme(themeMode);

    final user = _userController.user.value;
    final prefs = user.copy(theme: themeMode);
    _userController.setUserPreferences(prefs);
  }

  void onProfilePressed(BuildContext context) {
    _showProfile();
  }

  void _showProfile() async {
    final args = Get.arguments as SettingsArguments;
    Get.toNamed(args.routeProfile);
  }

  void clearProfile() async {
    _userController.setUserPreferences(null);
  }

  void updateLanguage(Language language) {
    final user = _userController.user.value;
    final prefs = user.copy(language: language.id);
    _userController.setUserPreferences(prefs);
  }
}
