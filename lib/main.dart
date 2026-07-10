import 'package:alarm/alarm.dart' as alarm_plugin;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/database.dart';
import 'data/alarm_repository.dart';
import 'settings/app_settings.dart';
import 'theme/app_theme.dart';
import 'ui/main_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await alarm_plugin.Alarm.init();

  final database = AppDatabase();
  final repository = AlarmRepository(database);
  final settings = await AppSettings.load();

  runApp(AlarmApp(repository: repository, settings: settings));
}

class AlarmApp extends StatelessWidget {
  final AlarmRepository repository;
  final AppSettings settings;

  const AlarmApp({super.key, required this.repository, required this.settings});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AlarmRepository>.value(value: repository),
        ChangeNotifierProvider<AppSettings>.value(value: settings),
      ],
      child: MaterialApp(
        title: 'Alarm',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.restTheme,
        home: const MainShell(),
      ),
    );
  }
}
