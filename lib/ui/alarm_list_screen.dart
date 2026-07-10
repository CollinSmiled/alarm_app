import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/database.dart';
import '../data/alarm_repository.dart';
import '../settings/app_settings.dart';
import '../theme/app_theme.dart';
import '../utils/time_formatter.dart';
import 'alarm_edit_screen.dart';
import 'widgets/day_selector.dart';

class AlarmListScreen extends StatelessWidget {
  const AlarmListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = context.read<AlarmRepository>();

    return Scaffold(
      backgroundColor: AppColors.fog,
      appBar: AppBar(
        backgroundColor: AppColors.fog,
        elevation: 0,
        title: Text('Alarms', style: AppTypography.display(color: AppColors.ink, size: 20)),
      ),
      body: StreamBuilder<List<Alarm>>(
        stream: repository.watchAllAlarms(),
        builder: (context, snapshot) {
          final alarms = snapshot.data ?? [];

          if (alarms.isEmpty) {
            return Center(
              child: Text('No alarms yet. Tap + to add one.', style: AppTypography.body(color: AppColors.slate)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: alarms.length,
            itemBuilder: (context, index) {
              final alarm = alarms[index];
              return GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => AlarmEditScreen(existing: alarm)),
                ),
                child: _AlarmCard(
                  alarm: alarm,
                  onToggle: (value) => repository.setAlarmEnabled(alarm.id, value),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.ink,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const AlarmEditScreen()),
        ),
        child: const Icon(Icons.add, color: AppColors.fog),
      ),
    );
  }
}

class _AlarmCard extends StatelessWidget {
  final Alarm alarm;
  final ValueChanged<bool> onToggle;

  const _AlarmCard({required this.alarm, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final activeColor = alarm.isEnabled ? AppColors.ink : AppColors.slate;
    final settings = context.watch<AppSettings>();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD3D2C9), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatMinuteOfDay(
                      alarm.triggerMinuteOfDay,
                      use24HourTime: settings.use24HourTime,
                    ),
                    style: AppTypography.display(color: activeColor, size: 34),
                  ),
                  const SizedBox(height: 4),
                  Text(alarm.label.isEmpty ? 'No label' : alarm.label, style: AppTypography.body(color: activeColor, size: 13)),
                ],
              ),
              Switch(value: alarm.isEnabled, onChanged: onToggle),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.only(top: 12),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFD3D2C9), width: 0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DaySelector(selectedMask: alarm.repeatDaysMask, onChanged: (_) {}, readOnly: true),
                _DismissMethodTag(dismissType: alarm.dismissType, stepTarget: alarm.stepTarget),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

class _DismissMethodTag extends StatelessWidget {
  final DismissType dismissType;
  final int? stepTarget;

  const _DismissMethodTag({required this.dismissType, this.stepTarget});

  @override
  Widget build(BuildContext context) {
    switch (dismissType) {
      case DismissType.barcode:
        return Row(
          children: [
            const Icon(Icons.qr_code_2, size: 16, color: AppColors.slate),
            const SizedBox(width: 4),
            Text('Barcode', style: AppTypography.body(color: AppColors.slate, size: 11)),
          ],
        );
      case DismissType.steps:
        return Row(
          children: [
            const Icon(Icons.directions_walk, size: 16, color: AppColors.moss),
            const SizedBox(width: 4),
            Text('${stepTarget ?? 0} steps', style: AppTypography.body(color: AppColors.moss, size: 11)),
          ],
        );
      case DismissType.none:
        return const SizedBox.shrink();
    }
  }
}
