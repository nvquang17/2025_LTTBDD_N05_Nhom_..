import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/notification_service.dart';

class SettingsScreen extends StatefulWidget {
  final void Function(Locale) onChangeLanguage;
  const SettingsScreen({super.key, required this.onChangeLanguage});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isReminderOn = false;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final current = Localizations.localeOf(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('settings'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(loc.translate('change_language')),
              subtitle: Text(current.languageCode == 'vi' ? 'Tiếng Việt' : 'English'),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => widget.onChangeLanguage(const Locale('vi')),
                  child: const Text('Tiếng Việt'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => widget.onChangeLanguage(const Locale('en')),
                  child: const Text('English'),
                ),
              ],
            ),
            const Divider(height: 32),
            SwitchListTile(
              title: const Text('Nhắc nhở uống nước'),
              subtitle: const Text('Nhắc uống nước 💧'),
              value: _isReminderOn,
              onChanged: (value) {
                setState(() {
                  _isReminderOn = value;
                });
                if (value) {
                  NotificationService.startWaterReminder();
                } else {
                  NotificationService.stopWaterReminder();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
