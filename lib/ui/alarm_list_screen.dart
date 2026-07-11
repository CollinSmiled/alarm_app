import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/database.dart';
import '../data/alarm_repository.dart';
import '../settings/app_settings.dart';
import '../theme/app_theme.dart';
import '../utils/repeat_formatter.dart';
import '../utils/time_formatter.dart';
import 'alarm_edit_screen.dart';
import 'widgets/day_selector.dart';
import 'widgets/page_header.dart';

class AlarmListScreen extends StatefulWidget {
  const AlarmListScreen({super.key});

  @override
  State<AlarmListScreen> createState() => _AlarmListScreenState();
}

class _AlarmListScreenState extends State<AlarmListScreen> {
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _refreshTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repository = context.read<AlarmRepository>();

    return Scaffold(
      backgroundColor: AppColors.fog,
      body: StreamBuilder<List<Alarm>>(
        stream: repository.watchAllAlarms(),
        builder: (context, snapshot) {
          final alarms = snapshot.data ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                bottom: false,
                child: const PageHeader(title: 'Alarms'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Text(
                  _nextAlarmText(alarms),
                  style: AppTypography.body(color: AppColors.slate, size: 13),
                ),
              ),
              Expanded(
                child: alarms.isEmpty
                    ? Center(
                        child: Text(
                          'No alarms yet. Tap + to add one.',
                          style: AppTypography.body(color: AppColors.slate),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 2, 16, 16),
                        itemCount: alarms.length,
                        itemBuilder: (context, index) {
                          final alarm = alarms[index];
                          return GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => AlarmEditScreen(existing: alarm),
                              ),
                            ),
                            child: _AlarmCard(
                              alarm: alarm,
                              onToggle: (value) =>
                                  repository.setAlarmEnabled(alarm.id, value),
                            ),
                          );
                        },
                      ),
              ),
            ],
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

  String _nextAlarmText(List<Alarm> alarms) {
    final next = _nextAlarmDateTime(alarms);
    if (next == null) return 'No enabled alarms';

    final now = DateTime.now();
    final seconds = next.difference(now).inSeconds;
    final minutes = seconds <= 0 ? 0 : (seconds + 59) ~/ 60;

    if (minutes == 0) return 'Next alarm in less than a minute';

    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;

    if (hours == 0) return 'Next alarm in ${remainingMinutes}m';
    if (remainingMinutes == 0) return 'Next alarm in ${hours}h';

    return 'Next alarm in ${hours}h ${remainingMinutes}m';
  }

  DateTime? _nextAlarmDateTime(List<Alarm> alarms) {
    final now = DateTime.now();
    DateTime? next;

    for (final alarm in alarms.where((alarm) => alarm.isEnabled)) {
      final candidate = _nextOccurrence(now, alarm);
      if (candidate == null) continue;

      if (next == null || candidate.isBefore(next)) {
        next = candidate;
      }
    }

    return next;
  }

  DateTime? _nextOccurrence(DateTime now, Alarm alarm) {
    final hour = alarm.triggerMinuteOfDay ~/ 60;
    final minute = alarm.triggerMinuteOfDay % 60;

    if (alarm.repeatDaysMask == 0) {
      final today = DateTime(now.year, now.month, now.day, hour, minute);
      if (today.isAfter(now)) return today;

      final tomorrow = now.add(const Duration(days: 1));
      return DateTime(
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
        hour,
        minute,
      );
    }

    for (var offset = 0; offset <= 7; offset++) {
      final day = now.add(Duration(days: offset));
      final dayIndex = day.weekday - 1;
      final repeatsOnDay = (alarm.repeatDaysMask & (1 << dayIndex)) != 0;
      if (!repeatsOnDay) continue;

      final candidate = DateTime(
        day.year,
        day.month,
        day.day,
        hour,
        minute,
      );

      if (candidate.isAfter(now)) return candidate;
    }

    return null;
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
                  SizedBox(
                    height: 18,
                    child: alarm.label.isEmpty
                        ? null
                        : Text(
                            alarm.label,
                            style: AppTypography.body(
                              color: activeColor,
                              size: 13,
                            ),
                          ),
                  ),
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
                alarm.repeatDaysMask == 0
                    ? _OnceTag(activeColor: activeColor)
                    : DaySelector(
                        selectedMask: alarm.repeatDaysMask,
                        onChanged: (_) {},
                        readOnly: true,
                      ),
                _DismissMethodTag(dismissType: alarm.dismissType, stepTarget: alarm.stepTarget),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

class _OnceTag extends StatelessWidget {
  final Color activeColor;

  const _OnceTag({required this.activeColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      formatRepeatSummary(0),
      style: AppTypography.body(
        color: activeColor,
        size: 12,
        weight: FontWeight.w500,
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
