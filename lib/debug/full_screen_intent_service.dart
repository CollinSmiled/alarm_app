import 'package:flutter/services.dart';

class FullScreenIntentService {
  static const _channel = MethodChannel('alarm_app/full_screen_intent');

  Future<bool> canUseFullScreenIntent() async {
    final result = await _channel.invokeMethod<bool>('canUseFullScreenIntent');
    return result ?? false;
  }

  Future<void> openFullScreenIntentSettings() {
    return _channel.invokeMethod<void>('openFullScreenIntentSettings');
  }
}
