import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  final void Function(Locale) onChangeLanguage;
  const SettingsScreen({super.key, required this.onChangeLanguage});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final current = Localizations.localeOf(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('settings'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text(loc.translate('change_language')),
              subtitle: Text(current.languageCode == 'vi' ? 'Tiếng Việt' : 'English'),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => onChangeLanguage(const Locale('vi')),
                  child: const Text('Tiếng Việt'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => onChangeLanguage(const Locale('en')),
                  child: const Text('English'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
