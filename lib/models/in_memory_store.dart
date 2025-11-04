import 'health_record.dart';

class InMemoryStore {
  static final List<HealthRecord> records = [];

  static void initSampleData() {
    records.clear();
    final now = DateTime.now();
    for (int i = 6; i >= 0; i--) {
      final d = now.subtract(Duration(days: i));
      records.add(HealthRecord(date: d, weight: 65 + (i % 3) * 0.3, waterLiters: 1.5 + (i % 4) * 0.25, sleepHours: 6 + (i % 2) * 1.0));
    }
  }

  static List<HealthRecord> getLastDays(int n) {
    final list = List<HealthRecord>.from(records);
    list.sort((a, b) => a.date.compareTo(b.date));
    if (n >= list.length) return list;
    return list.sublist(list.length - n);
  }

  static void addOrReplace(HealthRecord r) {
    final dayKey = r.date.toIso8601String().split('T')[0];
    for (int i = 0; i < records.length; i++) {
      final existingDay = records[i].date.toIso8601String().split('T')[0];
      if (existingDay == dayKey) {
        records[i] = r;
        return;
      }
    }
    records.add(r);
  }
}
