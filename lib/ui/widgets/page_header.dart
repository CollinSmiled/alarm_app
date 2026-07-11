import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class PageHeader extends StatelessWidget {
  final String title;

  const PageHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
      child: Text(
        title,
        style: AppTypography.display(color: AppColors.ink, size: 24),
      ),
    );
  }
}
