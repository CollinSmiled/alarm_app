import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

/// How an alarm is dismissed.
enum DismissType { none, barcode, steps }

@DataClassName('Alarm')
class Alarms extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get triggerMinuteOfDay => integer()();

  IntColumn get repeatDaysMask => integer().withDefault(const Constant(0))();

  TextColumn get label => text().withDefault(const Constant(''))();

  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();

  IntColumn get dismissType =>
      intEnum<DismissType>().withDefault(const Constant(0))();

  IntColumn get barcodeId =>
      integer().nullable().references(Barcodes, #id)();

  IntColumn get stepTarget => integer().nullable()();

  TextColumn get soundId => text().withDefault(const Constant('default'))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('Barcode')
class Barcodes extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get value => text().unique()();

  TextColumn get label => text().withDefault(const Constant(''))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('DismissEvent')
class DismissHistory extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get alarmId => integer().references(Alarms, #id)();

  DateTimeColumn get firedAt => dateTime()();

  DateTimeColumn get dismissedAt => dateTime().nullable()();

  IntColumn get methodUsed =>
      intEnum<DismissType>().withDefault(const Constant(0))();
}

@DriftDatabase(tables: [Alarms, Barcodes, DismissHistory])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'alarm_app_db');
}