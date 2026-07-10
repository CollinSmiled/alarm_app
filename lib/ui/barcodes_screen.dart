import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/alarm_repository.dart';
import '../data/database.dart';
import '../theme/app_theme.dart';
import 'widgets/dismiss_method_selector.dart';

class BarcodesScreen extends StatelessWidget {
  const BarcodesScreen({super.key});

  Future<void> _scanNew(BuildContext context) async {
    final value = await scanBarcodeValue(context);
    if (value == null || !context.mounted) return;

    await context.read<AlarmRepository>().getOrCreateBarcode(value);
  }

  Future<void> _rename(BuildContext context, Barcode barcode) async {
    final controller = TextEditingController(text: barcode.label);
    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFFF5F5F1),
        title: Text(
          'Rename barcode',
          style: AppTypography.body(
            color: AppColors.ink,
            size: 16,
            weight: FontWeight.w500,
          ),
        ),
        content: TextField(
          controller: controller,
          style: AppTypography.body(color: AppColors.ink),
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    controller.dispose();

    if (result == null || !context.mounted) return;

    await context.read<AlarmRepository>().renameBarcode(
          barcode.id,
          result.trim(),
        );
  }

  Future<void> _delete(BuildContext context, Barcode barcode) async {
    try {
      await context.read<AlarmRepository>().deleteBarcode(barcode.id);
    } catch (_) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'This barcode is still used by an alarm.',
            style: AppTypography.body(color: AppColors.fog),
          ),
          backgroundColor: AppColors.ink,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final repository = context.read<AlarmRepository>();

    return Scaffold(
      backgroundColor: AppColors.fog,
      appBar: AppBar(
        backgroundColor: AppColors.fog,
        elevation: 0,
        title: Text(
          'Barcodes',
          style: AppTypography.display(color: AppColors.ink, size: 20),
        ),
      ),
      body: StreamBuilder<List<Barcode>>(
        stream: repository.watchAllBarcodes(),
        builder: (context, snapshot) {
          final barcodes = snapshot.data ?? [];

          if (barcodes.isEmpty) {
            return Center(
              child: Text(
                'No barcodes registered yet.',
                style: AppTypography.body(color: AppColors.slate),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: barcodes.length,
            itemBuilder: (context, index) {
              final barcode = barcodes[index];
              final label = barcode.label.isEmpty ? barcode.value : barcode.label;

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFD3D2C9),
                    width: 0.5,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.qr_code_2,
                      size: 20,
                      color: AppColors.steel,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: AppTypography.body(
                              color: AppColors.ink,
                              size: 14,
                            ),
                          ),
                          Text(
                            barcode.value,
                            style: AppTypography.mono(
                              color: AppColors.slate,
                              size: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.edit_outlined,
                        size: 18,
                        color: AppColors.slate,
                      ),
                      onPressed: () => _rename(context, barcode),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        size: 18,
                        color: AppColors.slate,
                      ),
                      onPressed: () => _delete(context, barcode),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.steel,
        onPressed: () => _scanNew(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
