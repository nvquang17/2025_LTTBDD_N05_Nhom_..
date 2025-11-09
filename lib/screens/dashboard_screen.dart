import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/in_memory_store.dart';
import '../widgets/health_card.dart';
import 'add_record_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    InMemoryStore.initSampleData();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final records = InMemoryStore.getLastDays(7);
    final latest = records.isNotEmpty ? records.last : null;

    final weightStr = latest != null && latest.weight != null
        ? '${latest.weight!.toStringAsFixed(1)} kg'
        : loc.translate('no_data');
    final waterStr = latest != null && latest.waterLiters != null
        ? '${(latest.waterLiters! * 1000).toInt()} ml'
        : loc.translate('no_data');
    final sleepStr = latest != null && latest.sleepHours != null
        ? '${latest.sleepHours} h'
        : loc.translate('no_data');

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('home'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.translate('home'),
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            HealthCard(title: loc.translate('weight'), value: weightStr),
            HealthCard(title: loc.translate('water'), value: waterStr),
            HealthCard(title: loc.translate('sleep'), value: sleepStr),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddRecordScreen()),
          );
          if (result == true) {
            setState(() {}); // Cập nhật lại dữ liệu mới
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
