import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'alarm_list_screen.dart';
import 'barcodes_screen.dart';
import 'settings_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static const _screens = [
    AlarmListScreen(),
    BarcodesScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fog,
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.fog,
          border: Border(
            top: BorderSide(color: Color(0xFFD3D2C9), width: 0.5),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _NavItem(
                icon: Icons.alarm,
                label: 'Alarms',
                active: _index == 0,
                onTap: () => setState(() => _index = 0),
              ),
              _NavItem(
                icon: Icons.qr_code_2,
                label: 'Barcodes',
                active: _index == 1,
                onTap: () => setState(() => _index = 1),
              ),
              _NavItem(
                icon: Icons.settings_outlined,
                label: 'Settings',
                active: _index == 2,
                onTap: () => setState(() => _index = 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.moss : AppColors.slate;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTypography.body(
              color: color,
              size: 11,
              weight: active ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
