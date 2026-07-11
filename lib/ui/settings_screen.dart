import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../settings/app_settings.dart';
import '../theme/app_theme.dart';
import 'widgets/page_header.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fog,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SafeArea(
            bottom: false,
            child: PageHeader(title: 'Settings'),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 2, 20, 20),
              children: [
                _SettingsSection(
                  title: 'Alarm',
                  children: const [
                    _SettingsRow(
                      icon: Icons.volume_up_outlined,
                      label: 'Default alarm sound',
                      value: 'Default',
                    ),
                    _SettingsRow(
                      icon: Icons.vibration,
                      label: 'Vibration',
                      value: 'On',
                    ),
                  ],
                ),
                _SettingsSection(
                  title: 'Time',
                  children: [_TimeFormatRow()],
                ),
                const _SettingsSection(
                  title: 'Permissions',
                  children: [
                    _SettingsRow(
                      icon: Icons.camera_alt_outlined,
                      label: 'Camera',
                      value: 'Required for barcode',
                    ),
                    _SettingsRow(
                      icon: Icons.alarm_on_outlined,
                      label: 'Exact alarms',
                      value: 'Required',
                    ),
                    _SettingsRow(
                      icon: Icons.open_in_full_outlined,
                      label: 'Full-screen alerts',
                      value: 'Required',
                    ),
                  ],
                ),
                const _SettingsSection(
                  title: 'About',
                  children: [
                    _SettingsRow(
                      icon: Icons.info_outline,
                      label: 'Version',
                      value: '0.1.0',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 2, bottom: 8),
            child: Text(
              title,
              style: AppTypography.body(
                color: AppColors.slate,
                size: 12,
                weight: FontWeight.w500,
              ),
            ),
          ),
          ...children,
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
  final String? value;

  const _SettingsRow({required this.icon, required this.label, this.value});

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
          Expanded(
            child: Text(
              label,
              style: AppTypography.body(color: AppColors.ink, size: 14),
            ),
          ),
          if (value != null)
            Text(
              value!,
              style: AppTypography.body(color: AppColors.slate, size: 12),
            ),
        ],
      ),
    );
  }
}
