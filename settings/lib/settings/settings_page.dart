import 'package:cached_network_image/cached_network_image.dart';
import 'package:currentsapi_core/data/repo_simple.dart';
import 'package:currentsapi_core/net/net_ext.dart';
import 'package:currentsapi_model/prefs/theme.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:language_picker/language_picker.dart';
import 'package:language_picker/languages.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import 'settings_arguments.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _repo = CurrentsRepositorySimple();
  UserPreferences _userPreferences = UserPreferences();
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
  final themeLabels = <AppTheme, String>{
    AppTheme.dark: 'Dark',
    AppTheme.light: 'Light',
    AppTheme.system: 'System Default',
  };

  static const _photoSize = 150.0;
  static const _urlGithub = "https://github.com/pnemonic78/currents";
  static const _emailGithub = "pnemonic@gmail.com";

  @override
  void initState() {
    super.initState();

    _repo
        .getUserPreferences()
        .then((prefs) => setState(() => _userPreferences = prefs));
    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    final prefs = _userPreferences;

    final language = Language.fromIsoCode(prefs.language);

    return SettingsList(
      sections: [
        SettingsSection(
          title: const Text('Account'),
          tiles: <SettingsTile>[
            SettingsTile(
              title: Text(prefs.displayName ?? ""),
              value: _profileImage(context, prefs),
              onPressed: _showProfile,
            ),
            SettingsTile.navigation(
              leading: const Icon(Icons.delete),
              title: const Text('Clear Data'),
              onPressed: _clearProfile,
            ),
          ],
        ),
        SettingsSection(
          title: const Text('General'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              value: Text(language.name),
              onPressed: _pickLanguage,
            ),
            SettingsTile.navigation(
              leading: const Icon(Icons.palette),
              title: const Text('Theme'),
              value: Text(themeLabels[prefs.theme] ?? ""),
              onPressed: _pickTheme,
            ),
          ],
        ),
        SettingsSection(
          title: const Text('About'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(Icons.info),
              title: const Text('Version'),
              value: Text(_packageInfo.version),
              onPressed: _showAbout,
            ),
            SettingsTile.navigation(
              leading: const Icon(Icons.bug_report),
              title: const Text('Issues'),
              value: const Text("Report a problem, or request a feature"),
              onPressed: _sendIssue,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLanguageItem(Language language) => Text(language.name);

  void _pickLanguage(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => LanguagePickerDialog(
        title: const Text('Select Language'),
        isSearchable: true,
        onValuePicked: (Language language) => _updateLanguage(language),
        itemBuilder: _buildLanguageItem,
      ),
    );
  }

  void _updateLanguage(Language language) {
    setState(() {
      final prefs = _userPreferences;
      prefs.language = language.isoCode;
      _repo.setUserPreferences(prefs);
    });
  }

  void _pickTheme(BuildContext context) async {
    final prefs = _userPreferences;

    final option = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.palette_outlined),
                Expanded(
                  child: RadioListTile<AppTheme>(
                    title: Text(themeLabels[AppTheme.system]!),
                    value: AppTheme.system,
                    groupValue: prefs.theme,
                    onChanged: (AppTheme? value) => Get.back(result: value),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.dark_mode),
                Expanded(
                  child: RadioListTile<AppTheme>(
                    title: Text(themeLabels[AppTheme.dark]!),
                    value: AppTheme.dark,
                    groupValue: prefs.theme,
                    onChanged: (AppTheme? value) => Get.back(result: value),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.light_mode),
                Expanded(
                  child: RadioListTile<AppTheme>(
                    title: Text(themeLabels[AppTheme.light]!),
                    value: AppTheme.light,
                    groupValue: prefs.theme,
                    onChanged: (AppTheme? value) => Get.back(result: value),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    if (option != null) {
      setState(() {
        _updateTheme(prefs, option);
      });
    }
  }

  void _updateTheme(UserPreferences userPreferences, AppTheme theme) async {
    userPreferences.theme = theme;
    _repo.setUserPreferences(userPreferences);
    //TODO refresh app
  }

  Widget _profileImage(BuildContext context, UserPreferences preferences) {
    return ClipOval(
      child: (preferences.photoURL?.isNotEmpty ?? false)
          ? CachedNetworkImage(
              imageUrl: preferences.photoURL ?? "",
              placeholder: (context, url) =>
                  const Icon(Icons.face, size: _photoSize),
              width: _photoSize,
              height: _photoSize,
              fit: BoxFit.cover,
            )
          : const Icon(Icons.face, size: _photoSize),
    );
  }

  void _showProfile(BuildContext context) async {
    final args =
        ModalRoute.of(context)!.settings.arguments as SettingsArguments;
    Get.toNamed(args.routeProfile);
  }

  void _clearProfile(BuildContext context) async {
    final confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear App Data'),
        content:
            const Text("Are you sure that you want to delete your app data?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text("OK"),
          ),
        ],
      ),
    );
    if (confirm) {
      _clearProfileYes();
    }
  }

  void _clearProfileYes() async {
    //TODO delete the user's db
    _repo.setUserPreferences(null);
  }

  void _showAbout(BuildContext context) async {
    final theme = Theme.of(context);

    showAboutDialog(
      context: context,
      applicationVersion: _packageInfo.version,
      //TODO applicationIcon: const AppIconImage(),
      children: [
        InkWell(
            onTap: _gotoHome,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "GitHub",
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: Colors.blue,
                ),
              ),
            )),
      ],
    );
  }

  void _gotoHome() async {
    const urlString = _urlGithub;
    final url = Uri.parse(urlString);
    launchUrl(url);
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  void _sendIssue(BuildContext context) async {
    final uri = Uri(
      scheme: "mailto",
      path: _emailGithub,
      query: encodeQueryParameters(<String, String>{
        'subject': _packageInfo.appName,
      }),
    );
    launchUrl(uri);
  }
}
