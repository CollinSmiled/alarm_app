import 'package:drift/drift.dart';
import 'database.dart';

class AlarmRepository {
  final AppDatabase _db;

  AlarmRepository(this._db);

  Stream<List<Alarm>> watchAllAlarms() {
    return (_db.select(_db.alarms)
          ..orderBy([(a) => OrderingTerm(expression: a.triggerMinuteOfDay)]))
        .watch();
  }

  /// Insert a new alarm
  Future<int> insertAlarm(AlarmsCompanion alarm) {
    return _db.into(_db.alarms).insert(alarm);
  }

  /// Update an existing alarm
  Future<bool> updateAlarm(Alarm alarm) {
    return _db.update(_db.alarms).replace(alarm);
  }

  Future<int> updateAlarmFields(int id, AlarmsCompanion alarm) {
    return (_db.update(_db.alarms)..where((a) => a.id.equals(id)))
        .write(alarm);
  }

  /// Delete an alarm by id
  Future<int> deleteAlarm(int id) {
    return (_db.delete(_db.alarms)..where((a) => a.id.equals(id))).go();
  }

  /// Toggle enabled/disabled\
  Future<void> setAlarmEnabled(int id, bool isEnabled) {
    return (_db.update(_db.alarms)..where((a) => a.id.equals(id)))
        .write(AlarmsCompanion(isEnabled: Value(isEnabled)));
  }

  // Barcodes

  Future<int> insertBarcode(BarcodesCompanion barcode) {
    return _db.into(_db.barcodes).insert(barcode);
  }

  Future<Barcode?> findBarcodeByValue(String value) {
    return (_db.select(_db.barcodes)..where((b) => b.value.equals(value)))
        .getSingleOrNull();
  }

  Future<int> getOrCreateBarcode(String value, {String label = ''}) async {
    final existing = await findBarcodeByValue(value);
    if (existing != null) return existing.id;

    return insertBarcode(
      BarcodesCompanion.insert(
        value: value,
        label: Value(label.isEmpty ? value : label),
      ),
    );
  }

  Future<void> renameBarcode(int id, String label) {
    return (_db.update(_db.barcodes)..where((b) => b.id.equals(id)))
        .write(BarcodesCompanion(label: Value(label)));
  }

  Future<int> deleteBarcode(int id) {
    return (_db.delete(_db.barcodes)..where((b) => b.id.equals(id))).go();
  }

  Stream<List<Barcode>> watchAllBarcodes() {
    return _db.select(_db.barcodes).watch();
  }

  // -Dismiss History

  Future<int> logDismissEvent(DismissHistoryCompanion event) {
    return _db.into(_db.dismissHistory).insert(event);
  }
}
