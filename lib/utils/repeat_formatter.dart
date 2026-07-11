const _dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

String formatRepeatSummary(int repeatDaysMask) {
  if (repeatDaysMask == 0) return 'Once';

  final selectedDays = <String>[];

  for (var i = 0; i < _dayNames.length; i++) {
    if ((repeatDaysMask & (1 << i)) != 0) {
      selectedDays.add(_dayNames[i]);
    }
  }

  if (selectedDays.length == 7) return 'Every day';

  return 'Every ${selectedDays.join(', ')}';
}
