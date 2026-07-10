import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' show Value;

import '../data/database.dart';
import '../data/alarm_repository.dart';
import '../theme/app_theme.dart';

const _dayLetters = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

class AlarmListScreen extends StatelessWidget {
  const AlarmListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = context.read<AlarmRepository>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Alarms', style: AppTypography.display(color: AppColors.ink, size: 20)),
        backgroundColor: AppColors.fog,
        elevation: 0,
      ),
      body: StreamBuilder<List<Alarm>>(
        stream: repository.watchAllAlarms(),
        builder: (context, snapshot) {
          final alarms = snapshot.data ?? [];

          if (alarms.isEmpty) {
            return Center(
              child: Text(
                'No alarms yet. Tap + to add one.',
                style: AppTypography.body(color: AppColors.slate),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: alarms.length,
            itemBuilder: (context, index) {
              final alarm = alarms[index];
              return _AlarmCard(
                alarm: alarm,
                onToggle: (value) => repository.setAlarmEnabled(alarm.id, value),
              );
            },
          );
        },
      ),
      backgroundColor: AppColors.fog,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.ink,
        onPressed: () {
          final now = DateTime.now();
          final testMinute = ((now.hour * 60) + now.minute + 1) % 1440;

          repository.insertAlarm(
            AlarmsCompanion.insert(
              triggerMinuteOfDay: testMinute,
              label: const Value('Test alarm'),
            ),
          );
        },
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
    // Desaturate everything when the alarm is off — "off" should be
    // unambiguous at a glance, not just a smaller toggle state.
    final activeColor = alarm.isEnabled ? AppColors.ink : AppColors.slate;

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
                    _formatTime(alarm.triggerMinuteOfDay),
                    style: AppTypography.display(color: activeColor, size: 34),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    alarm.label.isEmpty ? 'No label' : alarm.label,
                    style: AppTypography.body(color: activeColor, size: 13),
                  ),
                ],
              ),
              Switch(
                value: alarm.isEnabled,
                onChanged: onToggle,
              ),
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
                Row(
                  children: List.generate(7, (i) {
                    final isActiveDay = (alarm.repeatDaysMask & (1 << i)) != 0;
                    return Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: _DayChip(letter: _dayLetters[i], active: isActiveDay),
                    );
                  }),
                ),
                _DismissMethodTag(dismissType: alarm.dismissType, stepTarget: alarm.stepTarget),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int minuteOfDay) {
    final hours = minuteOfDay ~/ 60;
    final minutes = (minuteOfDay % 60).toString().padLeft(2, '0');
    return '$hours:$minutes';
  }
}

class _DayChip extends StatelessWidget {
  final String letter;
  final bool active;

  const _DayChip({required this.letter, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? AppColors.ink : Colors.transparent,
        border: active ? null : Border.all(color: AppColors.slate, width: 0.5),
      ),
      child: Center(
        child: Text(
          letter,
          style: AppTypography.mono(
            color: active ? AppColors.fog : AppColors.slate,
            size: 10,
          ),
        ),
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
            Text(
              '${stepTarget ?? 0} steps',
              style: AppTypography.body(color: AppColors.moss, size: 11),
            ),
          ],
        );
      case DismissType.none:
        return const SizedBox.shrink();
    }
  }
}
