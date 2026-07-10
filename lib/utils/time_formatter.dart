String formatMinuteOfDay(int minuteOfDay, {required bool use24HourTime}) {
  final hour = minuteOfDay ~/ 60;
  final minute = minuteOfDay % 60;
  final minuteText = minute.toString().padLeft(2, '0');

  if (use24HourTime) {
    return '$hour:$minuteText';
  }

  final period = hour < 12 ? 'AM' : 'PM';
  final hourOfPeriod = hour % 12 == 0 ? 12 : hour % 12;

  return '$hourOfPeriod:$minuteText $period';
}
