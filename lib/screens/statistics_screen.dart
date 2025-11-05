import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('statistics'))),
      body: const Center(child: Text('Statistics: feature not added')),
    );
  }
}
