import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../models/in_memory_store.dart';
import '../l10n/app_localizations.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  List<FlSpot> _generateSpots(List<double?> values) {
    final spots = <FlSpot>[];
    for (var i = 0; i < values.length; i++) {
      if (values[i] != null) {
        spots.add(FlSpot(i.toDouble(), values[i]!));
      }
    }
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final records = InMemoryStore.getLastDays(7);

    if (records.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(loc.translate('statistics'))),
        body: Center(child: Text(loc.translate('no_data'))),
      );
    }

    final dateLabels =
        records.map((r) => DateFormat('dd/MM').format(r.date)).toList();

    final weightData = _generateSpots(records.map((r) => r.weight).toList());
    final waterData = _generateSpots(
        records.map((r) => r.waterLiters != null ? r.waterLiters! * 1000 : null).toList());
    final sleepData = _generateSpots(records.map((r) => r.sleepHours).toList());

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('statistics'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildChartSection(
                  title: loc.translate('weight') + ' (kg)',
                  data: weightData,
                  labels: dateLabels,
                  color: Colors.orange.shade400),
              _buildChartSection(
                  title: loc.translate('water') + ' (ml)',
                  data: waterData,
                  labels: dateLabels,
                  color: Colors.blue.shade400),
              _buildChartSection(
                  title: loc.translate('sleep') + ' (h)',
                  data: sleepData,
                  labels: dateLabels,
                  color: Colors.green.shade400),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChartSection({
    required String title,
    required List<FlSpot> data,
    required List<String> labels,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3))
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: AspectRatio(
            aspectRatio: 1.7,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 2,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < labels.length) {
                          return Text(
                            labels[index],
                            style: const TextStyle(
                                fontSize: 10, color: Colors.black54),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: data,
                    isCurved: true,
                    color: color,
                    barWidth: 4,
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [color.withOpacity(0.3), Colors.transparent],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    dotData: FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
