

import 'package:flutter/material.dart';
import 'package:alarm/alarm.dart';
import 'package:permission_handler/permission_handler.dart';

class AlarmSpikeTestScreen extends StatelessWidget {
  const AlarmSpikeTestScreen({super.key});

  Future<void> _scheduleTestAlarm(BuildContext context) async {
    // Android 13+ requires notification permission
    final notificationStatus = await Permission.notification.status;
    if (notificationStatus.isDenied) {
      await Permission.notification.request();
    }

    final status = await Permission.scheduleExactAlarm.status;
    if (status.isDenied) {
      await Permission.scheduleExactAlarm.request();
    }

    final alarmTime = DateTime.now().add(const Duration(seconds: 30));

    final scheduled = await Alarm.set(
      alarmSettings: AlarmSettings(
        id: 1,
        dateTime: alarmTime,
        assetAudioPath: 'assets/not_blank.mp3',
        loopAudio: true,
        vibrate: true,
        androidFullScreenIntent: true,

        volumeSettings: const VolumeSettings.fixed(
          volume: 0.8,
          volumeEnforced: true,
        ),
        notificationSettings: const NotificationSettings(
          title: 'Spike test alarm',
          body: 'If you see this from a locked/killed state, it worked.',
          stopButton: 'Stop',
        ),
      ),
    );

    if (!scheduled) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Alarm was not scheduled. Check permissions.')),
        );
      }
      return;
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Alarm set for $alarmTime — lock your phone now.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alarm Spike Test')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'Tap below, then immediately lock your phone (or force-close '
                'the app from recents) for at least 30 seconds. The alarm '
                'should still fire and show a full-screen prompt.',
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () => _scheduleTestAlarm(context),
              child: const Text('Schedule test alarm (30s)'),
            ),
          ],
        ),
      ),
    );
  }
}
