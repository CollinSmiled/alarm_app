import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../data/database.dart';
import '../../theme/app_theme.dart';

class DismissMethodSelector extends StatelessWidget {
  final DismissType selected;
  final ValueChanged<DismissType> onChanged;
  final String? barcodeLabel;
  final VoidCallback onScanBarcode;
  final int stepTarget;
  final ValueChanged<int> onStepTargetChanged;

  const DismissMethodSelector({
    super.key,
    required this.selected,
    required this.onChanged,
    required this.barcodeLabel,
    required this.onScanBarcode,
    required this.stepTarget,
    required this.onStepTargetChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: DismissType.values.map((type) {
            final active = selected == type;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => onChanged(type),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: active ? AppColors.ink : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: active
                        ? null
                        : Border.all(color: AppColors.slate, width: 0.5),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _iconFor(type),
                        size: 16,
                        color: active ? AppColors.fog : AppColors.slate,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _labelFor(type),
                        style: AppTypography.body(
                          color: active ? AppColors.fog : AppColors.slate,
                          size: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        if (selected == DismissType.barcode) ...[
          const SizedBox(height: 16),
          _BarcodeRow(label: barcodeLabel, onScan: onScanBarcode),
        ],
        if (selected == DismissType.steps) ...[
          const SizedBox(height: 16),
          _StepTargetRow(value: stepTarget, onChanged: onStepTargetChanged),
        ],
      ],
    );
  }

  IconData _iconFor(DismissType type) {
    switch (type) {
      case DismissType.none:
        return Icons.touch_app_outlined;
      case DismissType.barcode:
        return Icons.qr_code_2;
      case DismissType.steps:
        return Icons.directions_walk;
    }
  }

  String _labelFor(DismissType type) {
    switch (type) {
      case DismissType.none:
        return 'Tap';
      case DismissType.barcode:
        return 'Barcode';
      case DismissType.steps:
        return 'Steps';
    }
  }
}

class _BarcodeRow extends StatelessWidget {
  final String? label;
  final VoidCallback onScan;

  const _BarcodeRow({required this.label, required this.onScan});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onScan,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFD3D2C9), width: 0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label ?? 'No barcode registered',
              style: AppTypography.body(
                color: label == null ? AppColors.slate : AppColors.ink,
                size: 13,
              ),
            ),
            Text(
              label == null ? 'Scan' : 'Rescan',
              style: AppTypography.mono(color: AppColors.moss, size: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepTargetRow extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const _StepTargetRow({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD3D2C9), width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Steps required', style: AppTypography.body(color: AppColors.ink, size: 13)),
          Row(
            children: [
              IconButton(
                onPressed: value > 10 ? () => onChanged(value - 10) : null,
                icon: const Icon(Icons.remove_circle_outline, size: 20, color: AppColors.slate),
              ),
              Text(
                '$value',
                style: AppTypography.mono(color: AppColors.moss, size: 15),
              ),
              IconButton(
                onPressed: () => onChanged(value + 10),
                icon: const Icon(Icons.add_circle_outline, size: 20, color: AppColors.slate),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<String?> scanBarcodeValue(BuildContext context) {
  return Navigator.of(context).push<String>(
    MaterialPageRoute(builder: (_) => const _BarcodeScanPage()),
  );
}

class _BarcodeScanPage extends StatelessWidget {
  const _BarcodeScanPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.char,
      appBar: AppBar(
        backgroundColor: AppColors.char,
        foregroundColor: const Color(0xFFF2F2EF),
        title: const Text('Scan barcode'),
      ),
      body: MobileScanner(
        onDetect: (capture) {
          final barcode = capture.barcodes.firstOrNull;
          final value = barcode?.rawValue;
          if (value != null) {
            Navigator.of(context).pop(value);
          }
        },
      ),
    );
  }
}