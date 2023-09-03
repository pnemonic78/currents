import 'package:cached_network_image/cached_network_image.dart';
import 'package:currentsapi_model/prefs/theme.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';
import 'package:currentsapi_settings/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:language_picker/language_picker.dart';
import 'package:language_picker/languages.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _controller = Get.put<SettingsController>(SettingsController());

  final themeLabels = <AppThemeMode, String>{
    AppThemeMode.dark: 'Dark',
    AppThemeMode.light: 'Light',
    AppThemeMode.system: 'System Default',
  };

  static const _photoSize = 150.0;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Account'),
            tiles: <SettingsTile>[
              SettingsTile(
                title: Text(_controller.user.value.displayName ?? ""),
                value: _profileImage(context, _controller.user.value),
                onPressed: _controller.onProfilePressed,
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.delete),
                title: const Text('Clear Data'),
                onPressed: _confirmClearProfile,
              ),
            ],
          ),
          SettingsSection(
            title: const Text('General'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                value: Text(
                  Language.fromIsoCode(_controller.user.value.language).name,
                ),
                onPressed: _pickLanguage,
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.palette),
                title: const Text('Theme'),
                value: Text(themeLabels[_controller.user.value.theme] ?? ""),
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
                value: Text(_controller.packageInfo.value.version),
                onPressed: _showAbout,
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.bug_report),
                title: const Text('Issues'),
                value: const Text("Report a problem, or request a feature"),
                onPressed: _controller.onIssuePressed,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageItem(Language language) => Text(language.name);

  void _pickLanguage(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => LanguagePickerDialog(
        title: const Text('Select Language'),
        isSearchable: true,
        onValuePicked: (Language language) => _controller.updateLanguage(language),
        itemBuilder: _buildLanguageItem,
      ),
    );
  }

  void _pickTheme(BuildContext context) async {
    final prefs = _controller.user.value;

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
                  child: RadioListTile<AppThemeMode>(
                    title: Text(themeLabels[AppThemeMode.system]!),
                    value: AppThemeMode.system,
                    groupValue: prefs.theme,
                    onChanged: (AppThemeMode? value) => Get.back(result: value),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.dark_mode),
                Expanded(
                  child: RadioListTile<AppThemeMode>(
                    title: Text(themeLabels[AppThemeMode.dark]!),
                    value: AppThemeMode.dark,
                    groupValue: prefs.theme,
                    onChanged: (AppThemeMode? value) => Get.back(result: value),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.light_mode),
                Expanded(
                  child: RadioListTile<AppThemeMode>(
                    title: Text(themeLabels[AppThemeMode.light]!),
                    value: AppThemeMode.light,
                    groupValue: prefs.theme,
                    onChanged: (AppThemeMode? value) => Get.back(result: value),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    if (option != null) {
      _controller.updateTheme(option);
    }
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

  void _confirmClearProfile(BuildContext context) async {
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
      _controller.clearProfile();
    }
  }

  void _showAbout(BuildContext context) async {
    final theme = Theme.of(context);

    showAboutDialog(
      context: context,
      applicationVersion: _controller.packageInfo.value.version,
      //TODO applicationIcon: const AppIconImage(),
      children: [
        InkWell(
            onTap: _controller.onGitHubPressed,
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
}
