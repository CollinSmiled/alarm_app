import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../settings/app_settings.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fog,
      appBar: AppBar(
        backgroundColor: AppColors.fog,
        elevation: 0,
        title: Text(
          'Settings',
          style: AppTypography.display(color: AppColors.ink, size: 20),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const _SettingsRow(
            icon: Icons.volume_up_outlined,
            label: 'Default alarm sound',
          ),
          const _SettingsRow(icon: Icons.vibration, label: 'Vibration'),
          _TimeFormatRow(),
          const _SettingsRow(icon: Icons.info_outline, label: 'About'),
        ],
      ),
    );
  }
}

class _TimeFormatRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD3D2C9), width: 0.5),
      ),
      child: Row(
        children: [
          const Icon(Icons.schedule, size: 20, color: AppColors.slate),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '24-hour time',
                  style: AppTypography.body(color: AppColors.ink, size: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  settings.use24HourTime ? '17:12' : '5:12 PM',
                  style: AppTypography.mono(color: AppColors.slate, size: 11),
                ),
              ],
            ),
          ),
          Switch(
            value: settings.use24HourTime,
            onChanged: (value) {
              settings.setUse24HourTime(value);
            },
          ),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SettingsRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD3D2C9), width: 0.5),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.slate),
          const SizedBox(width: 12),
          Text(
            label,
            style: AppTypography.body(color: AppColors.ink, size: 14),
          ),
        ],
      ),
    );
  }
}
