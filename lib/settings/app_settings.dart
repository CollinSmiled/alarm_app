import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  static const _use24HourTimeKey = 'use24HourTime';

  final SharedPreferences _preferences;
  bool _use24HourTime;

  AppSettings._(this._preferences, this._use24HourTime);

  static Future<AppSettings> load() async {
    final preferences = await SharedPreferences.getInstance();
    return AppSettings._(
      preferences,
      preferences.getBool(_use24HourTimeKey) ?? true,
    );
  }

  bool get use24HourTime => _use24HourTime;

  Future<void> setUse24HourTime(bool value) async {
    if (_use24HourTime == value) return;

    _use24HourTime = value;
    notifyListeners();
    await _preferences.setBool(_use24HourTimeKey, value);
  }
}
