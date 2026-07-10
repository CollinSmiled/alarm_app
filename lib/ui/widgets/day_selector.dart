import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

const dayLetters = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

class DaySelector extends StatelessWidget {
  final int selectedMask;
  final ValueChanged<int> onChanged;
  final bool readOnly;

  const DaySelector({
    super.key,
    required this.selectedMask,
    required this.onChanged,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final chipSize = readOnly ? 22.0 : 34.0;
    final rightPadding = readOnly ? 6.0 : 8.0;
    final textSize = readOnly ? 10.0 : 12.0;

    return Row(
      children: List.generate(7, (i) {
        final active = (selectedMask & (1 << i)) != 0;
        return Padding(
          padding: EdgeInsets.only(right: rightPadding),
          child: GestureDetector(
            onTap: readOnly
                ? null
                : () => onChanged(selectedMask ^ (1 << i)),
            child: Container(
              width: chipSize,
              height: chipSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active ? AppColors.ink : Colors.transparent,
                border: active
                    ? null
                    : Border.all(color: AppColors.slate, width: 0.5),
              ),
              child: Center(
                child: Text(
                  dayLetters[i],
                  style: AppTypography.mono(
                    color: active ? AppColors.fog : AppColors.slate,
                    size: textSize,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
