import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' show Value;

import '../data/database.dart';
import '../data/alarm_repository.dart';
import '../settings/app_settings.dart';
import '../theme/app_theme.dart';
import '../utils/repeat_formatter.dart';
import '../utils/time_formatter.dart';
import 'widgets/day_selector.dart';
import 'widgets/dismiss_method_selector.dart';

class AlarmEditScreen extends StatefulWidget {
  final Alarm? existing;

  const AlarmEditScreen({super.key, this.existing});

  @override
  State<AlarmEditScreen> createState() => _AlarmEditScreenState();
}

class _AlarmEditScreenState extends State<AlarmEditScreen> {
  late int _minuteOfDay;
  late int _repeatMask;
  late TextEditingController _labelController;
  late DismissType _dismissType;
  int? _barcodeId;
  String? _barcodeLabel;
  late int _stepTarget;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    final now = DateTime.now();
    _minuteOfDay = existing?.triggerMinuteOfDay ?? (now.hour * 60 + now.minute);
    _repeatMask = existing?.repeatDaysMask ?? 0;
    _labelController = TextEditingController(text: existing?.label ?? '');
    _dismissType = existing?.dismissType ?? DismissType.none;
    _barcodeId = existing?.barcodeId;
    _barcodeLabel = existing?.barcodeId == null ? null : 'Registered barcode';
    _stepTarget = existing?.stepTarget ?? 50;
  }

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final settings = context.read<AppSettings>();
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: _minuteOfDay ~/ 60,
        minute: _minuteOfDay % 60,
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: settings.use24HourTime,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _minuteOfDay = picked.hour * 60 + picked.minute);
    }
  }

  Future<void> _handleScanBarcode() async {
    final value = await scanBarcodeValue(context);
    if (value == null || !mounted) return;

    final repository = context.read<AlarmRepository>();
    final id = await repository.getOrCreateBarcode(value);
    setState(() {
      _barcodeId = id;
      _barcodeLabel = value;
    });
  }

  Future<void> _save() async {
    final repository = context.read<AlarmRepository>();
    final companion = AlarmsCompanion(
      triggerMinuteOfDay: Value(_minuteOfDay),
      repeatDaysMask: Value(_repeatMask),
      label: Value(_labelController.text),
      dismissType: Value(_dismissType),
      barcodeId: Value(_dismissType == DismissType.barcode ? _barcodeId : null),
      stepTarget: Value(_dismissType == DismissType.steps ? _stepTarget : null),
    );

    if (widget.existing != null) {
      await repository.updateAlarmFields(widget.existing!.id, companion);
    } else {
      await repository.insertAlarm(companion);
    }

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();

    return Scaffold(
      backgroundColor: AppColors.fog,
      appBar: AppBar(
        backgroundColor: AppColors.fog,
        elevation: 0,
        title: Text(
          widget.existing == null ? 'New alarm' : 'Edit alarm',
          style: AppTypography.body(color: AppColors.ink, size: 16, weight: FontWeight.w500),
        ),
        actions: [
          TextButton(
            onPressed: _save,
            child: Text('Save', style: AppTypography.body(color: AppColors.moss, size: 15, weight: FontWeight.w500)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickTime,
                child: Text(
                  formatMinuteOfDay(
                    _minuteOfDay,
                    use24HourTime: settings.use24HourTime,
                  ),
                  style: AppTypography.display(color: AppColors.ink, size: 56),
                ),
              ),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _labelController,
              style: AppTypography.body(color: AppColors.ink),
              decoration: InputDecoration(
                hintText: 'Label',
                hintStyle: AppTypography.body(color: AppColors.slate),
                border: InputBorder.none,
              ),
            ),
            const Divider(color: Color(0xFFD3D2C9), height: 24),
            Text('Repeat', style: AppTypography.body(color: AppColors.slate, size: 12)),
            const SizedBox(height: 4),
            Text(
              formatRepeatSummary(_repeatMask),
              style: AppTypography.body(
                color: _repeatMask == 0 ? AppColors.ink : AppColors.moss,
                size: 14,
                weight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            DaySelector(
              selectedMask: _repeatMask,
              onChanged: (mask) => setState(() => _repeatMask = mask),
            ),
            const SizedBox(height: 28),
            Text('Dismiss method', style: AppTypography.body(color: AppColors.slate, size: 12)),
            const SizedBox(height: 10),
            DismissMethodSelector(
              selected: _dismissType,
              onChanged: (type) => setState(() => _dismissType = type),
              barcodeLabel: _barcodeLabel,
              onScanBarcode: _handleScanBarcode,
              stepTarget: _stepTarget,
              onStepTargetChanged: (value) => setState(() => _stepTarget = value),
            ),
          ],
        ),
      ),
    );
  }
}
