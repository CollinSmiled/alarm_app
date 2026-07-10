// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $BarcodesTable extends Barcodes with TableInfo<$BarcodesTable, Barcode> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BarcodesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, value, label, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'barcodes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Barcode> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Barcode map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Barcode(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BarcodesTable createAlias(String alias) {
    return $BarcodesTable(attachedDatabase, alias);
  }
}

class Barcode extends DataClass implements Insertable<Barcode> {
  final int id;
  final String value;
  final String label;
  final DateTime createdAt;
  const Barcode({
    required this.id,
    required this.value,
    required this.label,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['value'] = Variable<String>(value);
    map['label'] = Variable<String>(label);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BarcodesCompanion toCompanion(bool nullToAbsent) {
    return BarcodesCompanion(
      id: Value(id),
      value: Value(value),
      label: Value(label),
      createdAt: Value(createdAt),
    );
  }

  factory Barcode.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Barcode(
      id: serializer.fromJson<int>(json['id']),
      value: serializer.fromJson<String>(json['value']),
      label: serializer.fromJson<String>(json['label']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'value': serializer.toJson<String>(value),
      'label': serializer.toJson<String>(label),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Barcode copyWith({
    int? id,
    String? value,
    String? label,
    DateTime? createdAt,
  }) => Barcode(
    id: id ?? this.id,
    value: value ?? this.value,
    label: label ?? this.label,
    createdAt: createdAt ?? this.createdAt,
  );
  Barcode copyWithCompanion(BarcodesCompanion data) {
    return Barcode(
      id: data.id.present ? data.id.value : this.id,
      value: data.value.present ? data.value.value : this.value,
      label: data.label.present ? data.label.value : this.label,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Barcode(')
          ..write('id: $id, ')
          ..write('value: $value, ')
          ..write('label: $label, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, value, label, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Barcode &&
          other.id == this.id &&
          other.value == this.value &&
          other.label == this.label &&
          other.createdAt == this.createdAt);
}

class BarcodesCompanion extends UpdateCompanion<Barcode> {
  final Value<int> id;
  final Value<String> value;
  final Value<String> label;
  final Value<DateTime> createdAt;
  const BarcodesCompanion({
    this.id = const Value.absent(),
    this.value = const Value.absent(),
    this.label = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BarcodesCompanion.insert({
    this.id = const Value.absent(),
    required String value,
    this.label = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : value = Value(value);
  static Insertable<Barcode> custom({
    Expression<int>? id,
    Expression<String>? value,
    Expression<String>? label,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (value != null) 'value': value,
      if (label != null) 'label': label,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BarcodesCompanion copyWith({
    Value<int>? id,
    Value<String>? value,
    Value<String>? label,
    Value<DateTime>? createdAt,
  }) {
    return BarcodesCompanion(
      id: id ?? this.id,
      value: value ?? this.value,
      label: label ?? this.label,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BarcodesCompanion(')
          ..write('id: $id, ')
          ..write('value: $value, ')
          ..write('label: $label, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AlarmsTable extends Alarms with TableInfo<$AlarmsTable, Alarm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlarmsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _triggerMinuteOfDayMeta =
      const VerificationMeta('triggerMinuteOfDay');
  @override
  late final GeneratedColumn<int> triggerMinuteOfDay = GeneratedColumn<int>(
    'trigger_minute_of_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repeatDaysMaskMeta = const VerificationMeta(
    'repeatDaysMask',
  );
  @override
  late final GeneratedColumn<int> repeatDaysMask = GeneratedColumn<int>(
    'repeat_days_mask',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  late final GeneratedColumnWithTypeConverter<DismissType, int> dismissType =
      GeneratedColumn<int>(
        'dismiss_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<DismissType>($AlarmsTable.$converterdismissType);
  static const VerificationMeta _barcodeIdMeta = const VerificationMeta(
    'barcodeId',
  );
  @override
  late final GeneratedColumn<int> barcodeId = GeneratedColumn<int>(
    'barcode_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES barcodes (id)',
    ),
  );
  static const VerificationMeta _stepTargetMeta = const VerificationMeta(
    'stepTarget',
  );
  @override
  late final GeneratedColumn<int> stepTarget = GeneratedColumn<int>(
    'step_target',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _soundIdMeta = const VerificationMeta(
    'soundId',
  );
  @override
  late final GeneratedColumn<String> soundId = GeneratedColumn<String>(
    'sound_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('default'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    triggerMinuteOfDay,
    repeatDaysMask,
    label,
    isEnabled,
    dismissType,
    barcodeId,
    stepTarget,
    soundId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alarms';
  @override
  VerificationContext validateIntegrity(
    Insertable<Alarm> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('trigger_minute_of_day')) {
      context.handle(
        _triggerMinuteOfDayMeta,
        triggerMinuteOfDay.isAcceptableOrUnknown(
          data['trigger_minute_of_day']!,
          _triggerMinuteOfDayMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_triggerMinuteOfDayMeta);
    }
    if (data.containsKey('repeat_days_mask')) {
      context.handle(
        _repeatDaysMaskMeta,
        repeatDaysMask.isAcceptableOrUnknown(
          data['repeat_days_mask']!,
          _repeatDaysMaskMeta,
        ),
      );
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('barcode_id')) {
      context.handle(
        _barcodeIdMeta,
        barcodeId.isAcceptableOrUnknown(data['barcode_id']!, _barcodeIdMeta),
      );
    }
    if (data.containsKey('step_target')) {
      context.handle(
        _stepTargetMeta,
        stepTarget.isAcceptableOrUnknown(data['step_target']!, _stepTargetMeta),
      );
    }
    if (data.containsKey('sound_id')) {
      context.handle(
        _soundIdMeta,
        soundId.isAcceptableOrUnknown(data['sound_id']!, _soundIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Alarm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Alarm(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      triggerMinuteOfDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trigger_minute_of_day'],
      )!,
      repeatDaysMask: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repeat_days_mask'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      dismissType: $AlarmsTable.$converterdismissType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}dismiss_type'],
        )!,
      ),
      barcodeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}barcode_id'],
      ),
      stepTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}step_target'],
      ),
      soundId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sound_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AlarmsTable createAlias(String alias) {
    return $AlarmsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DismissType, int, int> $converterdismissType =
      const EnumIndexConverter<DismissType>(DismissType.values);
}

class Alarm extends DataClass implements Insertable<Alarm> {
  final int id;
  final int triggerMinuteOfDay;
  final int repeatDaysMask;
  final String label;
  final bool isEnabled;
  final DismissType dismissType;
  final int? barcodeId;
  final int? stepTarget;
  final String soundId;
  final DateTime createdAt;
  const Alarm({
    required this.id,
    required this.triggerMinuteOfDay,
    required this.repeatDaysMask,
    required this.label,
    required this.isEnabled,
    required this.dismissType,
    this.barcodeId,
    this.stepTarget,
    required this.soundId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['trigger_minute_of_day'] = Variable<int>(triggerMinuteOfDay);
    map['repeat_days_mask'] = Variable<int>(repeatDaysMask);
    map['label'] = Variable<String>(label);
    map['is_enabled'] = Variable<bool>(isEnabled);
    {
      map['dismiss_type'] = Variable<int>(
        $AlarmsTable.$converterdismissType.toSql(dismissType),
      );
    }
    if (!nullToAbsent || barcodeId != null) {
      map['barcode_id'] = Variable<int>(barcodeId);
    }
    if (!nullToAbsent || stepTarget != null) {
      map['step_target'] = Variable<int>(stepTarget);
    }
    map['sound_id'] = Variable<String>(soundId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AlarmsCompanion toCompanion(bool nullToAbsent) {
    return AlarmsCompanion(
      id: Value(id),
      triggerMinuteOfDay: Value(triggerMinuteOfDay),
      repeatDaysMask: Value(repeatDaysMask),
      label: Value(label),
      isEnabled: Value(isEnabled),
      dismissType: Value(dismissType),
      barcodeId: barcodeId == null && nullToAbsent
          ? const Value.absent()
          : Value(barcodeId),
      stepTarget: stepTarget == null && nullToAbsent
          ? const Value.absent()
          : Value(stepTarget),
      soundId: Value(soundId),
      createdAt: Value(createdAt),
    );
  }

  factory Alarm.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Alarm(
      id: serializer.fromJson<int>(json['id']),
      triggerMinuteOfDay: serializer.fromJson<int>(json['triggerMinuteOfDay']),
      repeatDaysMask: serializer.fromJson<int>(json['repeatDaysMask']),
      label: serializer.fromJson<String>(json['label']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      dismissType: $AlarmsTable.$converterdismissType.fromJson(
        serializer.fromJson<int>(json['dismissType']),
      ),
      barcodeId: serializer.fromJson<int?>(json['barcodeId']),
      stepTarget: serializer.fromJson<int?>(json['stepTarget']),
      soundId: serializer.fromJson<String>(json['soundId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'triggerMinuteOfDay': serializer.toJson<int>(triggerMinuteOfDay),
      'repeatDaysMask': serializer.toJson<int>(repeatDaysMask),
      'label': serializer.toJson<String>(label),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'dismissType': serializer.toJson<int>(
        $AlarmsTable.$converterdismissType.toJson(dismissType),
      ),
      'barcodeId': serializer.toJson<int?>(barcodeId),
      'stepTarget': serializer.toJson<int?>(stepTarget),
      'soundId': serializer.toJson<String>(soundId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Alarm copyWith({
    int? id,
    int? triggerMinuteOfDay,
    int? repeatDaysMask,
    String? label,
    bool? isEnabled,
    DismissType? dismissType,
    Value<int?> barcodeId = const Value.absent(),
    Value<int?> stepTarget = const Value.absent(),
    String? soundId,
    DateTime? createdAt,
  }) => Alarm(
    id: id ?? this.id,
    triggerMinuteOfDay: triggerMinuteOfDay ?? this.triggerMinuteOfDay,
    repeatDaysMask: repeatDaysMask ?? this.repeatDaysMask,
    label: label ?? this.label,
    isEnabled: isEnabled ?? this.isEnabled,
    dismissType: dismissType ?? this.dismissType,
    barcodeId: barcodeId.present ? barcodeId.value : this.barcodeId,
    stepTarget: stepTarget.present ? stepTarget.value : this.stepTarget,
    soundId: soundId ?? this.soundId,
    createdAt: createdAt ?? this.createdAt,
  );
  Alarm copyWithCompanion(AlarmsCompanion data) {
    return Alarm(
      id: data.id.present ? data.id.value : this.id,
      triggerMinuteOfDay: data.triggerMinuteOfDay.present
          ? data.triggerMinuteOfDay.value
          : this.triggerMinuteOfDay,
      repeatDaysMask: data.repeatDaysMask.present
          ? data.repeatDaysMask.value
          : this.repeatDaysMask,
      label: data.label.present ? data.label.value : this.label,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      dismissType: data.dismissType.present
          ? data.dismissType.value
          : this.dismissType,
      barcodeId: data.barcodeId.present ? data.barcodeId.value : this.barcodeId,
      stepTarget: data.stepTarget.present
          ? data.stepTarget.value
          : this.stepTarget,
      soundId: data.soundId.present ? data.soundId.value : this.soundId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Alarm(')
          ..write('id: $id, ')
          ..write('triggerMinuteOfDay: $triggerMinuteOfDay, ')
          ..write('repeatDaysMask: $repeatDaysMask, ')
          ..write('label: $label, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('dismissType: $dismissType, ')
          ..write('barcodeId: $barcodeId, ')
          ..write('stepTarget: $stepTarget, ')
          ..write('soundId: $soundId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    triggerMinuteOfDay,
    repeatDaysMask,
    label,
    isEnabled,
    dismissType,
    barcodeId,
    stepTarget,
    soundId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Alarm &&
          other.id == this.id &&
          other.triggerMinuteOfDay == this.triggerMinuteOfDay &&
          other.repeatDaysMask == this.repeatDaysMask &&
          other.label == this.label &&
          other.isEnabled == this.isEnabled &&
          other.dismissType == this.dismissType &&
          other.barcodeId == this.barcodeId &&
          other.stepTarget == this.stepTarget &&
          other.soundId == this.soundId &&
          other.createdAt == this.createdAt);
}

class AlarmsCompanion extends UpdateCompanion<Alarm> {
  final Value<int> id;
  final Value<int> triggerMinuteOfDay;
  final Value<int> repeatDaysMask;
  final Value<String> label;
  final Value<bool> isEnabled;
  final Value<DismissType> dismissType;
  final Value<int?> barcodeId;
  final Value<int?> stepTarget;
  final Value<String> soundId;
  final Value<DateTime> createdAt;
  const AlarmsCompanion({
    this.id = const Value.absent(),
    this.triggerMinuteOfDay = const Value.absent(),
    this.repeatDaysMask = const Value.absent(),
    this.label = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.dismissType = const Value.absent(),
    this.barcodeId = const Value.absent(),
    this.stepTarget = const Value.absent(),
    this.soundId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AlarmsCompanion.insert({
    this.id = const Value.absent(),
    required int triggerMinuteOfDay,
    this.repeatDaysMask = const Value.absent(),
    this.label = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.dismissType = const Value.absent(),
    this.barcodeId = const Value.absent(),
    this.stepTarget = const Value.absent(),
    this.soundId = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : triggerMinuteOfDay = Value(triggerMinuteOfDay);
  static Insertable<Alarm> custom({
    Expression<int>? id,
    Expression<int>? triggerMinuteOfDay,
    Expression<int>? repeatDaysMask,
    Expression<String>? label,
    Expression<bool>? isEnabled,
    Expression<int>? dismissType,
    Expression<int>? barcodeId,
    Expression<int>? stepTarget,
    Expression<String>? soundId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (triggerMinuteOfDay != null)
        'trigger_minute_of_day': triggerMinuteOfDay,
      if (repeatDaysMask != null) 'repeat_days_mask': repeatDaysMask,
      if (label != null) 'label': label,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (dismissType != null) 'dismiss_type': dismissType,
      if (barcodeId != null) 'barcode_id': barcodeId,
      if (stepTarget != null) 'step_target': stepTarget,
      if (soundId != null) 'sound_id': soundId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AlarmsCompanion copyWith({
    Value<int>? id,
    Value<int>? triggerMinuteOfDay,
    Value<int>? repeatDaysMask,
    Value<String>? label,
    Value<bool>? isEnabled,
    Value<DismissType>? dismissType,
    Value<int?>? barcodeId,
    Value<int?>? stepTarget,
    Value<String>? soundId,
    Value<DateTime>? createdAt,
  }) {
    return AlarmsCompanion(
      id: id ?? this.id,
      triggerMinuteOfDay: triggerMinuteOfDay ?? this.triggerMinuteOfDay,
      repeatDaysMask: repeatDaysMask ?? this.repeatDaysMask,
      label: label ?? this.label,
      isEnabled: isEnabled ?? this.isEnabled,
      dismissType: dismissType ?? this.dismissType,
      barcodeId: barcodeId ?? this.barcodeId,
      stepTarget: stepTarget ?? this.stepTarget,
      soundId: soundId ?? this.soundId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (triggerMinuteOfDay.present) {
      map['trigger_minute_of_day'] = Variable<int>(triggerMinuteOfDay.value);
    }
    if (repeatDaysMask.present) {
      map['repeat_days_mask'] = Variable<int>(repeatDaysMask.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (dismissType.present) {
      map['dismiss_type'] = Variable<int>(
        $AlarmsTable.$converterdismissType.toSql(dismissType.value),
      );
    }
    if (barcodeId.present) {
      map['barcode_id'] = Variable<int>(barcodeId.value);
    }
    if (stepTarget.present) {
      map['step_target'] = Variable<int>(stepTarget.value);
    }
    if (soundId.present) {
      map['sound_id'] = Variable<String>(soundId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlarmsCompanion(')
          ..write('id: $id, ')
          ..write('triggerMinuteOfDay: $triggerMinuteOfDay, ')
          ..write('repeatDaysMask: $repeatDaysMask, ')
          ..write('label: $label, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('dismissType: $dismissType, ')
          ..write('barcodeId: $barcodeId, ')
          ..write('stepTarget: $stepTarget, ')
          ..write('soundId: $soundId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DismissHistoryTable extends DismissHistory
    with TableInfo<$DismissHistoryTable, DismissEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DismissHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _alarmIdMeta = const VerificationMeta(
    'alarmId',
  );
  @override
  late final GeneratedColumn<int> alarmId = GeneratedColumn<int>(
    'alarm_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES alarms (id)',
    ),
  );
  static const VerificationMeta _firedAtMeta = const VerificationMeta(
    'firedAt',
  );
  @override
  late final GeneratedColumn<DateTime> firedAt = GeneratedColumn<DateTime>(
    'fired_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dismissedAtMeta = const VerificationMeta(
    'dismissedAt',
  );
  @override
  late final GeneratedColumn<DateTime> dismissedAt = GeneratedColumn<DateTime>(
    'dismissed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<DismissType, int> methodUsed =
      GeneratedColumn<int>(
        'method_used',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<DismissType>($DismissHistoryTable.$convertermethodUsed);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    alarmId,
    firedAt,
    dismissedAt,
    methodUsed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dismiss_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<DismissEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('alarm_id')) {
      context.handle(
        _alarmIdMeta,
        alarmId.isAcceptableOrUnknown(data['alarm_id']!, _alarmIdMeta),
      );
    } else if (isInserting) {
      context.missing(_alarmIdMeta);
    }
    if (data.containsKey('fired_at')) {
      context.handle(
        _firedAtMeta,
        firedAt.isAcceptableOrUnknown(data['fired_at']!, _firedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_firedAtMeta);
    }
    if (data.containsKey('dismissed_at')) {
      context.handle(
        _dismissedAtMeta,
        dismissedAt.isAcceptableOrUnknown(
          data['dismissed_at']!,
          _dismissedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DismissEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DismissEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      alarmId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}alarm_id'],
      )!,
      firedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fired_at'],
      )!,
      dismissedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dismissed_at'],
      ),
      methodUsed: $DismissHistoryTable.$convertermethodUsed.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}method_used'],
        )!,
      ),
    );
  }

  @override
  $DismissHistoryTable createAlias(String alias) {
    return $DismissHistoryTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DismissType, int, int> $convertermethodUsed =
      const EnumIndexConverter<DismissType>(DismissType.values);
}

class DismissEvent extends DataClass implements Insertable<DismissEvent> {
  final int id;
  final int alarmId;
  final DateTime firedAt;
  final DateTime? dismissedAt;
  final DismissType methodUsed;
  const DismissEvent({
    required this.id,
    required this.alarmId,
    required this.firedAt,
    this.dismissedAt,
    required this.methodUsed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['alarm_id'] = Variable<int>(alarmId);
    map['fired_at'] = Variable<DateTime>(firedAt);
    if (!nullToAbsent || dismissedAt != null) {
      map['dismissed_at'] = Variable<DateTime>(dismissedAt);
    }
    {
      map['method_used'] = Variable<int>(
        $DismissHistoryTable.$convertermethodUsed.toSql(methodUsed),
      );
    }
    return map;
  }

  DismissHistoryCompanion toCompanion(bool nullToAbsent) {
    return DismissHistoryCompanion(
      id: Value(id),
      alarmId: Value(alarmId),
      firedAt: Value(firedAt),
      dismissedAt: dismissedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(dismissedAt),
      methodUsed: Value(methodUsed),
    );
  }

  factory DismissEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DismissEvent(
      id: serializer.fromJson<int>(json['id']),
      alarmId: serializer.fromJson<int>(json['alarmId']),
      firedAt: serializer.fromJson<DateTime>(json['firedAt']),
      dismissedAt: serializer.fromJson<DateTime?>(json['dismissedAt']),
      methodUsed: $DismissHistoryTable.$convertermethodUsed.fromJson(
        serializer.fromJson<int>(json['methodUsed']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'alarmId': serializer.toJson<int>(alarmId),
      'firedAt': serializer.toJson<DateTime>(firedAt),
      'dismissedAt': serializer.toJson<DateTime?>(dismissedAt),
      'methodUsed': serializer.toJson<int>(
        $DismissHistoryTable.$convertermethodUsed.toJson(methodUsed),
      ),
    };
  }

  DismissEvent copyWith({
    int? id,
    int? alarmId,
    DateTime? firedAt,
    Value<DateTime?> dismissedAt = const Value.absent(),
    DismissType? methodUsed,
  }) => DismissEvent(
    id: id ?? this.id,
    alarmId: alarmId ?? this.alarmId,
    firedAt: firedAt ?? this.firedAt,
    dismissedAt: dismissedAt.present ? dismissedAt.value : this.dismissedAt,
    methodUsed: methodUsed ?? this.methodUsed,
  );
  DismissEvent copyWithCompanion(DismissHistoryCompanion data) {
    return DismissEvent(
      id: data.id.present ? data.id.value : this.id,
      alarmId: data.alarmId.present ? data.alarmId.value : this.alarmId,
      firedAt: data.firedAt.present ? data.firedAt.value : this.firedAt,
      dismissedAt: data.dismissedAt.present
          ? data.dismissedAt.value
          : this.dismissedAt,
      methodUsed: data.methodUsed.present
          ? data.methodUsed.value
          : this.methodUsed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DismissEvent(')
          ..write('id: $id, ')
          ..write('alarmId: $alarmId, ')
          ..write('firedAt: $firedAt, ')
          ..write('dismissedAt: $dismissedAt, ')
          ..write('methodUsed: $methodUsed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, alarmId, firedAt, dismissedAt, methodUsed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DismissEvent &&
          other.id == this.id &&
          other.alarmId == this.alarmId &&
          other.firedAt == this.firedAt &&
          other.dismissedAt == this.dismissedAt &&
          other.methodUsed == this.methodUsed);
}

class DismissHistoryCompanion extends UpdateCompanion<DismissEvent> {
  final Value<int> id;
  final Value<int> alarmId;
  final Value<DateTime> firedAt;
  final Value<DateTime?> dismissedAt;
  final Value<DismissType> methodUsed;
  const DismissHistoryCompanion({
    this.id = const Value.absent(),
    this.alarmId = const Value.absent(),
    this.firedAt = const Value.absent(),
    this.dismissedAt = const Value.absent(),
    this.methodUsed = const Value.absent(),
  });
  DismissHistoryCompanion.insert({
    this.id = const Value.absent(),
    required int alarmId,
    required DateTime firedAt,
    this.dismissedAt = const Value.absent(),
    this.methodUsed = const Value.absent(),
  }) : alarmId = Value(alarmId),
       firedAt = Value(firedAt);
  static Insertable<DismissEvent> custom({
    Expression<int>? id,
    Expression<int>? alarmId,
    Expression<DateTime>? firedAt,
    Expression<DateTime>? dismissedAt,
    Expression<int>? methodUsed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (alarmId != null) 'alarm_id': alarmId,
      if (firedAt != null) 'fired_at': firedAt,
      if (dismissedAt != null) 'dismissed_at': dismissedAt,
      if (methodUsed != null) 'method_used': methodUsed,
    });
  }

  DismissHistoryCompanion copyWith({
    Value<int>? id,
    Value<int>? alarmId,
    Value<DateTime>? firedAt,
    Value<DateTime?>? dismissedAt,
    Value<DismissType>? methodUsed,
  }) {
    return DismissHistoryCompanion(
      id: id ?? this.id,
      alarmId: alarmId ?? this.alarmId,
      firedAt: firedAt ?? this.firedAt,
      dismissedAt: dismissedAt ?? this.dismissedAt,
      methodUsed: methodUsed ?? this.methodUsed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (alarmId.present) {
      map['alarm_id'] = Variable<int>(alarmId.value);
    }
    if (firedAt.present) {
      map['fired_at'] = Variable<DateTime>(firedAt.value);
    }
    if (dismissedAt.present) {
      map['dismissed_at'] = Variable<DateTime>(dismissedAt.value);
    }
    if (methodUsed.present) {
      map['method_used'] = Variable<int>(
        $DismissHistoryTable.$convertermethodUsed.toSql(methodUsed.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DismissHistoryCompanion(')
          ..write('id: $id, ')
          ..write('alarmId: $alarmId, ')
          ..write('firedAt: $firedAt, ')
          ..write('dismissedAt: $dismissedAt, ')
          ..write('methodUsed: $methodUsed')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BarcodesTable barcodes = $BarcodesTable(this);
  late final $AlarmsTable alarms = $AlarmsTable(this);
  late final $DismissHistoryTable dismissHistory = $DismissHistoryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    barcodes,
    alarms,
    dismissHistory,
  ];
}

typedef $$BarcodesTableCreateCompanionBuilder =
    BarcodesCompanion Function({
      Value<int> id,
      required String value,
      Value<String> label,
      Value<DateTime> createdAt,
    });
typedef $$BarcodesTableUpdateCompanionBuilder =
    BarcodesCompanion Function({
      Value<int> id,
      Value<String> value,
      Value<String> label,
      Value<DateTime> createdAt,
    });

final class $$BarcodesTableReferences
    extends BaseReferences<_$AppDatabase, $BarcodesTable, Barcode> {
  $$BarcodesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AlarmsTable, List<Alarm>> _alarmsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.alarms,
    aliasName: $_aliasNameGenerator(db.barcodes.id, db.alarms.barcodeId),
  );

  $$AlarmsTableProcessedTableManager get alarmsRefs {
    final manager = $$AlarmsTableTableManager(
      $_db,
      $_db.alarms,
    ).filter((f) => f.barcodeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_alarmsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BarcodesTableFilterComposer
    extends Composer<_$AppDatabase, $BarcodesTable> {
  $$BarcodesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> alarmsRefs(
    Expression<bool> Function($$AlarmsTableFilterComposer f) f,
  ) {
    final $$AlarmsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.alarms,
      getReferencedColumn: (t) => t.barcodeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlarmsTableFilterComposer(
            $db: $db,
            $table: $db.alarms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BarcodesTableOrderingComposer
    extends Composer<_$AppDatabase, $BarcodesTable> {
  $$BarcodesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BarcodesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BarcodesTable> {
  $$BarcodesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> alarmsRefs<T extends Object>(
    Expression<T> Function($$AlarmsTableAnnotationComposer a) f,
  ) {
    final $$AlarmsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.alarms,
      getReferencedColumn: (t) => t.barcodeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlarmsTableAnnotationComposer(
            $db: $db,
            $table: $db.alarms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BarcodesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BarcodesTable,
          Barcode,
          $$BarcodesTableFilterComposer,
          $$BarcodesTableOrderingComposer,
          $$BarcodesTableAnnotationComposer,
          $$BarcodesTableCreateCompanionBuilder,
          $$BarcodesTableUpdateCompanionBuilder,
          (Barcode, $$BarcodesTableReferences),
          Barcode,
          PrefetchHooks Function({bool alarmsRefs})
        > {
  $$BarcodesTableTableManager(_$AppDatabase db, $BarcodesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BarcodesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BarcodesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BarcodesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BarcodesCompanion(
                id: id,
                value: value,
                label: label,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String value,
                Value<String> label = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BarcodesCompanion.insert(
                id: id,
                value: value,
                label: label,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BarcodesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({alarmsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (alarmsRefs) db.alarms],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (alarmsRefs)
                    await $_getPrefetchedData<Barcode, $BarcodesTable, Alarm>(
                      currentTable: table,
                      referencedTable: $$BarcodesTableReferences
                          ._alarmsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$BarcodesTableReferences(db, table, p0).alarmsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.barcodeId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BarcodesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BarcodesTable,
      Barcode,
      $$BarcodesTableFilterComposer,
      $$BarcodesTableOrderingComposer,
      $$BarcodesTableAnnotationComposer,
      $$BarcodesTableCreateCompanionBuilder,
      $$BarcodesTableUpdateCompanionBuilder,
      (Barcode, $$BarcodesTableReferences),
      Barcode,
      PrefetchHooks Function({bool alarmsRefs})
    >;
typedef $$AlarmsTableCreateCompanionBuilder =
    AlarmsCompanion Function({
      Value<int> id,
      required int triggerMinuteOfDay,
      Value<int> repeatDaysMask,
      Value<String> label,
      Value<bool> isEnabled,
      Value<DismissType> dismissType,
      Value<int?> barcodeId,
      Value<int?> stepTarget,
      Value<String> soundId,
      Value<DateTime> createdAt,
    });
typedef $$AlarmsTableUpdateCompanionBuilder =
    AlarmsCompanion Function({
      Value<int> id,
      Value<int> triggerMinuteOfDay,
      Value<int> repeatDaysMask,
      Value<String> label,
      Value<bool> isEnabled,
      Value<DismissType> dismissType,
      Value<int?> barcodeId,
      Value<int?> stepTarget,
      Value<String> soundId,
      Value<DateTime> createdAt,
    });

final class $$AlarmsTableReferences
    extends BaseReferences<_$AppDatabase, $AlarmsTable, Alarm> {
  $$AlarmsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BarcodesTable _barcodeIdTable(_$AppDatabase db) => db.barcodes
      .createAlias($_aliasNameGenerator(db.alarms.barcodeId, db.barcodes.id));

  $$BarcodesTableProcessedTableManager? get barcodeId {
    final $_column = $_itemColumn<int>('barcode_id');
    if ($_column == null) return null;
    final manager = $$BarcodesTableTableManager(
      $_db,
      $_db.barcodes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_barcodeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DismissHistoryTable, List<DismissEvent>>
  _dismissHistoryRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.dismissHistory,
    aliasName: $_aliasNameGenerator(db.alarms.id, db.dismissHistory.alarmId),
  );

  $$DismissHistoryTableProcessedTableManager get dismissHistoryRefs {
    final manager = $$DismissHistoryTableTableManager(
      $_db,
      $_db.dismissHistory,
    ).filter((f) => f.alarmId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_dismissHistoryRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AlarmsTableFilterComposer
    extends Composer<_$AppDatabase, $AlarmsTable> {
  $$AlarmsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get triggerMinuteOfDay => $composableBuilder(
    column: $table.triggerMinuteOfDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repeatDaysMask => $composableBuilder(
    column: $table.repeatDaysMask,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DismissType, DismissType, int>
  get dismissType => $composableBuilder(
    column: $table.dismissType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get stepTarget => $composableBuilder(
    column: $table.stepTarget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get soundId => $composableBuilder(
    column: $table.soundId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BarcodesTableFilterComposer get barcodeId {
    final $$BarcodesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.barcodeId,
      referencedTable: $db.barcodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BarcodesTableFilterComposer(
            $db: $db,
            $table: $db.barcodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> dismissHistoryRefs(
    Expression<bool> Function($$DismissHistoryTableFilterComposer f) f,
  ) {
    final $$DismissHistoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dismissHistory,
      getReferencedColumn: (t) => t.alarmId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DismissHistoryTableFilterComposer(
            $db: $db,
            $table: $db.dismissHistory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AlarmsTableOrderingComposer
    extends Composer<_$AppDatabase, $AlarmsTable> {
  $$AlarmsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get triggerMinuteOfDay => $composableBuilder(
    column: $table.triggerMinuteOfDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repeatDaysMask => $composableBuilder(
    column: $table.repeatDaysMask,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dismissType => $composableBuilder(
    column: $table.dismissType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stepTarget => $composableBuilder(
    column: $table.stepTarget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get soundId => $composableBuilder(
    column: $table.soundId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BarcodesTableOrderingComposer get barcodeId {
    final $$BarcodesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.barcodeId,
      referencedTable: $db.barcodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BarcodesTableOrderingComposer(
            $db: $db,
            $table: $db.barcodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AlarmsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AlarmsTable> {
  $$AlarmsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get triggerMinuteOfDay => $composableBuilder(
    column: $table.triggerMinuteOfDay,
    builder: (column) => column,
  );

  GeneratedColumn<int> get repeatDaysMask => $composableBuilder(
    column: $table.repeatDaysMask,
    builder: (column) => column,
  );

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DismissType, int> get dismissType =>
      $composableBuilder(
        column: $table.dismissType,
        builder: (column) => column,
      );

  GeneratedColumn<int> get stepTarget => $composableBuilder(
    column: $table.stepTarget,
    builder: (column) => column,
  );

  GeneratedColumn<String> get soundId =>
      $composableBuilder(column: $table.soundId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$BarcodesTableAnnotationComposer get barcodeId {
    final $$BarcodesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.barcodeId,
      referencedTable: $db.barcodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BarcodesTableAnnotationComposer(
            $db: $db,
            $table: $db.barcodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> dismissHistoryRefs<T extends Object>(
    Expression<T> Function($$DismissHistoryTableAnnotationComposer a) f,
  ) {
    final $$DismissHistoryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dismissHistory,
      getReferencedColumn: (t) => t.alarmId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DismissHistoryTableAnnotationComposer(
            $db: $db,
            $table: $db.dismissHistory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AlarmsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AlarmsTable,
          Alarm,
          $$AlarmsTableFilterComposer,
          $$AlarmsTableOrderingComposer,
          $$AlarmsTableAnnotationComposer,
          $$AlarmsTableCreateCompanionBuilder,
          $$AlarmsTableUpdateCompanionBuilder,
          (Alarm, $$AlarmsTableReferences),
          Alarm,
          PrefetchHooks Function({bool barcodeId, bool dismissHistoryRefs})
        > {
  $$AlarmsTableTableManager(_$AppDatabase db, $AlarmsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlarmsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlarmsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlarmsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> triggerMinuteOfDay = const Value.absent(),
                Value<int> repeatDaysMask = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<DismissType> dismissType = const Value.absent(),
                Value<int?> barcodeId = const Value.absent(),
                Value<int?> stepTarget = const Value.absent(),
                Value<String> soundId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AlarmsCompanion(
                id: id,
                triggerMinuteOfDay: triggerMinuteOfDay,
                repeatDaysMask: repeatDaysMask,
                label: label,
                isEnabled: isEnabled,
                dismissType: dismissType,
                barcodeId: barcodeId,
                stepTarget: stepTarget,
                soundId: soundId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int triggerMinuteOfDay,
                Value<int> repeatDaysMask = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<DismissType> dismissType = const Value.absent(),
                Value<int?> barcodeId = const Value.absent(),
                Value<int?> stepTarget = const Value.absent(),
                Value<String> soundId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AlarmsCompanion.insert(
                id: id,
                triggerMinuteOfDay: triggerMinuteOfDay,
                repeatDaysMask: repeatDaysMask,
                label: label,
                isEnabled: isEnabled,
                dismissType: dismissType,
                barcodeId: barcodeId,
                stepTarget: stepTarget,
                soundId: soundId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$AlarmsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({barcodeId = false, dismissHistoryRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (dismissHistoryRefs) db.dismissHistory,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (barcodeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.barcodeId,
                                    referencedTable: $$AlarmsTableReferences
                                        ._barcodeIdTable(db),
                                    referencedColumn: $$AlarmsTableReferences
                                        ._barcodeIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (dismissHistoryRefs)
                        await $_getPrefetchedData<
                          Alarm,
                          $AlarmsTable,
                          DismissEvent
                        >(
                          currentTable: table,
                          referencedTable: $$AlarmsTableReferences
                              ._dismissHistoryRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AlarmsTableReferences(
                                db,
                                table,
                                p0,
                              ).dismissHistoryRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.alarmId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AlarmsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AlarmsTable,
      Alarm,
      $$AlarmsTableFilterComposer,
      $$AlarmsTableOrderingComposer,
      $$AlarmsTableAnnotationComposer,
      $$AlarmsTableCreateCompanionBuilder,
      $$AlarmsTableUpdateCompanionBuilder,
      (Alarm, $$AlarmsTableReferences),
      Alarm,
      PrefetchHooks Function({bool barcodeId, bool dismissHistoryRefs})
    >;
typedef $$DismissHistoryTableCreateCompanionBuilder =
    DismissHistoryCompanion Function({
      Value<int> id,
      required int alarmId,
      required DateTime firedAt,
      Value<DateTime?> dismissedAt,
      Value<DismissType> methodUsed,
    });
typedef $$DismissHistoryTableUpdateCompanionBuilder =
    DismissHistoryCompanion Function({
      Value<int> id,
      Value<int> alarmId,
      Value<DateTime> firedAt,
      Value<DateTime?> dismissedAt,
      Value<DismissType> methodUsed,
    });

final class $$DismissHistoryTableReferences
    extends BaseReferences<_$AppDatabase, $DismissHistoryTable, DismissEvent> {
  $$DismissHistoryTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AlarmsTable _alarmIdTable(_$AppDatabase db) => db.alarms.createAlias(
    $_aliasNameGenerator(db.dismissHistory.alarmId, db.alarms.id),
  );

  $$AlarmsTableProcessedTableManager get alarmId {
    final $_column = $_itemColumn<int>('alarm_id')!;

    final manager = $$AlarmsTableTableManager(
      $_db,
      $_db.alarms,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_alarmIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DismissHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $DismissHistoryTable> {
  $$DismissHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get firedAt => $composableBuilder(
    column: $table.firedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dismissedAt => $composableBuilder(
    column: $table.dismissedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DismissType, DismissType, int>
  get methodUsed => $composableBuilder(
    column: $table.methodUsed,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$AlarmsTableFilterComposer get alarmId {
    final $$AlarmsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.alarmId,
      referencedTable: $db.alarms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlarmsTableFilterComposer(
            $db: $db,
            $table: $db.alarms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DismissHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $DismissHistoryTable> {
  $$DismissHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get firedAt => $composableBuilder(
    column: $table.firedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dismissedAt => $composableBuilder(
    column: $table.dismissedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get methodUsed => $composableBuilder(
    column: $table.methodUsed,
    builder: (column) => ColumnOrderings(column),
  );

  $$AlarmsTableOrderingComposer get alarmId {
    final $$AlarmsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.alarmId,
      referencedTable: $db.alarms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlarmsTableOrderingComposer(
            $db: $db,
            $table: $db.alarms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DismissHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $DismissHistoryTable> {
  $$DismissHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get firedAt =>
      $composableBuilder(column: $table.firedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get dismissedAt => $composableBuilder(
    column: $table.dismissedAt,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<DismissType, int> get methodUsed =>
      $composableBuilder(
        column: $table.methodUsed,
        builder: (column) => column,
      );

  $$AlarmsTableAnnotationComposer get alarmId {
    final $$AlarmsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.alarmId,
      referencedTable: $db.alarms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlarmsTableAnnotationComposer(
            $db: $db,
            $table: $db.alarms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DismissHistoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DismissHistoryTable,
          DismissEvent,
          $$DismissHistoryTableFilterComposer,
          $$DismissHistoryTableOrderingComposer,
          $$DismissHistoryTableAnnotationComposer,
          $$DismissHistoryTableCreateCompanionBuilder,
          $$DismissHistoryTableUpdateCompanionBuilder,
          (DismissEvent, $$DismissHistoryTableReferences),
          DismissEvent,
          PrefetchHooks Function({bool alarmId})
        > {
  $$DismissHistoryTableTableManager(
    _$AppDatabase db,
    $DismissHistoryTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DismissHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DismissHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DismissHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> alarmId = const Value.absent(),
                Value<DateTime> firedAt = const Value.absent(),
                Value<DateTime?> dismissedAt = const Value.absent(),
                Value<DismissType> methodUsed = const Value.absent(),
              }) => DismissHistoryCompanion(
                id: id,
                alarmId: alarmId,
                firedAt: firedAt,
                dismissedAt: dismissedAt,
                methodUsed: methodUsed,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int alarmId,
                required DateTime firedAt,
                Value<DateTime?> dismissedAt = const Value.absent(),
                Value<DismissType> methodUsed = const Value.absent(),
              }) => DismissHistoryCompanion.insert(
                id: id,
                alarmId: alarmId,
                firedAt: firedAt,
                dismissedAt: dismissedAt,
                methodUsed: methodUsed,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DismissHistoryTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({alarmId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (alarmId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.alarmId,
                                referencedTable: $$DismissHistoryTableReferences
                                    ._alarmIdTable(db),
                                referencedColumn:
                                    $$DismissHistoryTableReferences
                                        ._alarmIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DismissHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DismissHistoryTable,
      DismissEvent,
      $$DismissHistoryTableFilterComposer,
      $$DismissHistoryTableOrderingComposer,
      $$DismissHistoryTableAnnotationComposer,
      $$DismissHistoryTableCreateCompanionBuilder,
      $$DismissHistoryTableUpdateCompanionBuilder,
      (DismissEvent, $$DismissHistoryTableReferences),
      DismissEvent,
      PrefetchHooks Function({bool alarmId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BarcodesTableTableManager get barcodes =>
      $$BarcodesTableTableManager(_db, _db.barcodes);
  $$AlarmsTableTableManager get alarms =>
      $$AlarmsTableTableManager(_db, _db.alarms);
  $$DismissHistoryTableTableManager get dismissHistory =>
      $$DismissHistoryTableTableManager(_db, _db.dismissHistory);
}
