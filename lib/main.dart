import 'package:alarm_app/debug/alarm_spike_test_screen.dart';
import 'package:alarm/alarm.dart' as alarm_plugin;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/database.dart';
import 'data/alarm_repository.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await alarm_plugin.Alarm.init();

  final database = AppDatabase();
  final repository = AlarmRepository(database);

  runApp(AlarmApp(repository: repository));
}

class AlarmApp extends StatelessWidget {
  final AlarmRepository repository;

  const AlarmApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Provider<AlarmRepository>.value(
      value: repository,
      child: MaterialApp(
        title: 'Alarm',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.restTheme,
        home: const AlarmSpikeTestScreen(),
      ),
    );
  }
}
