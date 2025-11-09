import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/health_record.dart';
import '../models/in_memory_store.dart';
import '../l10n/app_localizations.dart';

class AddRecordScreen extends StatefulWidget {
  const AddRecordScreen({super.key});

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  final _weightCtrl = TextEditingController();
  final _waterCtrl = TextEditingController();
  final _sleepCtrl = TextEditingController();

  @override
  void dispose() {
    _weightCtrl.dispose();
    _waterCtrl.dispose();
    _sleepCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final weight = _weightCtrl.text.isEmpty ? null : double.parse(_weightCtrl.text);
    final water = _waterCtrl.text.isEmpty ? null : double.parse(_waterCtrl.text) / 1000.0;
    final sleep = _sleepCtrl.text.isEmpty ? null : double.parse(_sleepCtrl.text);
    final record = HealthRecord(date: _date, weight: weight, waterLiters: water, sleepHours: sleep);
    InMemoryStore.addOrReplace(record);
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('add_record'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ListTile(
                title: Text(loc.translate('date')),
                subtitle: Text(DateFormat('yyyy-MM-dd').format(_date)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final pick = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2000), lastDate: DateTime.now());
                  if (pick != null) setState(() => _date = pick);
                },
              ),
              TextFormField(controller: _weightCtrl, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: InputDecoration(labelText: '${loc.translate('weight')} (kg)'), validator: (v) => v != null && v.isNotEmpty && double.tryParse(v) == null ? 'Enter a valid number' : null),
              TextFormField(controller: _waterCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: '${loc.translate('water')} (ml)'), validator: (v) => v != null && v.isNotEmpty && double.tryParse(v) == null ? 'Enter a valid integer' : null),
              TextFormField(controller: _sleepCtrl, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: InputDecoration(labelText: '${loc.translate('sleep')} (hours)'), validator: (v) => v != null && v.isNotEmpty && double.tryParse(v) == null ? 'Enter a valid number' : null),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _save, child: Text(loc.translate('save'))),
            ],
          ),
        ),
      ),
    );
  }
}
