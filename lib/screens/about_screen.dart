import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('about'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.translate('about'),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Icon(Icons.person, size: 20),
                SizedBox(width: 8),
                Text('Developer: Nguyễn Văn Quang'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.badge, size: 20),
                SizedBox(width: 8),
                Text('MSSV: 21012087'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.description, size: 20),
                SizedBox(width: 8),
                Text('Project: Health Tracker - demo app'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.link, size: 20),
                SizedBox(width: 8),
                Text('GitHub: https://github.com/nvquang17/2025_LTTBDD_N05_Nhom_..'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.email, size: 20),
                SizedBox(width: 8),
                Text('Email: 21012087@st.phenikaa-uni.edu.vn'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
