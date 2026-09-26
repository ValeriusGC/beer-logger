// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ClicksTable extends Clicks with TableInfo<$ClicksTable, ClickRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClicksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clickerIdMeta = const VerificationMeta(
    'clickerId',
  );
  @override
  late final GeneratedColumn<String> clickerId = GeneratedColumn<String>(
    'clicker_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _atUtcMsMeta = const VerificationMeta(
    'atUtcMs',
  );
  @override
  late final GeneratedColumn<int> atUtcMs = GeneratedColumn<int>(
    'at_utc_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _factorMeta = const VerificationMeta('factor');
  @override
  late final GeneratedColumn<double> factor = GeneratedColumn<double>(
    'factor',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, clickerId, atUtcMs, factor];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clicks';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClickRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('clicker_id')) {
      context.handle(
        _clickerIdMeta,
        clickerId.isAcceptableOrUnknown(data['clicker_id']!, _clickerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clickerIdMeta);
    }
    if (data.containsKey('at_utc_ms')) {
      context.handle(
        _atUtcMsMeta,
        atUtcMs.isAcceptableOrUnknown(data['at_utc_ms']!, _atUtcMsMeta),
      );
    } else if (isInserting) {
      context.missing(_atUtcMsMeta);
    }
    if (data.containsKey('factor')) {
      context.handle(
        _factorMeta,
        factor.isAcceptableOrUnknown(data['factor']!, _factorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClickRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClickRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      clickerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clicker_id'],
      )!,
      atUtcMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}at_utc_ms'],
      )!,
      factor: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}factor'],
      )!,
    );
  }

  @override
  $ClicksTable createAlias(String alias) {
    return $ClicksTable(attachedDatabase, alias);
  }
}

class ClickRow extends DataClass implements Insertable<ClickRow> {
  /// UUID v4 строкой.
  final String id;

  /// Ссылка на preset/config clicker.
  final String clickerId;

  /// Момент тапа — UTC, миллисекунды с epoch.
  final int atUtcMs;

  /// Множитель тапа.
  final double factor;
  const ClickRow({
    required this.id,
    required this.clickerId,
    required this.atUtcMs,
    required this.factor,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['clicker_id'] = Variable<String>(clickerId);
    map['at_utc_ms'] = Variable<int>(atUtcMs);
    map['factor'] = Variable<double>(factor);
    return map;
  }

  ClicksCompanion toCompanion(bool nullToAbsent) {
    return ClicksCompanion(
      id: Value(id),
      clickerId: Value(clickerId),
      atUtcMs: Value(atUtcMs),
      factor: Value(factor),
    );
  }

  factory ClickRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClickRow(
      id: serializer.fromJson<String>(json['id']),
      clickerId: serializer.fromJson<String>(json['clickerId']),
      atUtcMs: serializer.fromJson<int>(json['atUtcMs']),
      factor: serializer.fromJson<double>(json['factor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clickerId': serializer.toJson<String>(clickerId),
      'atUtcMs': serializer.toJson<int>(atUtcMs),
      'factor': serializer.toJson<double>(factor),
    };
  }

  ClickRow copyWith({
    String? id,
    String? clickerId,
    int? atUtcMs,
    double? factor,
  }) => ClickRow(
    id: id ?? this.id,
    clickerId: clickerId ?? this.clickerId,
    atUtcMs: atUtcMs ?? this.atUtcMs,
    factor: factor ?? this.factor,
  );
  ClickRow copyWithCompanion(ClicksCompanion data) {
    return ClickRow(
      id: data.id.present ? data.id.value : this.id,
      clickerId: data.clickerId.present ? data.clickerId.value : this.clickerId,
      atUtcMs: data.atUtcMs.present ? data.atUtcMs.value : this.atUtcMs,
      factor: data.factor.present ? data.factor.value : this.factor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClickRow(')
          ..write('id: $id, ')
          ..write('clickerId: $clickerId, ')
          ..write('atUtcMs: $atUtcMs, ')
          ..write('factor: $factor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, clickerId, atUtcMs, factor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClickRow &&
          other.id == this.id &&
          other.clickerId == this.clickerId &&
          other.atUtcMs == this.atUtcMs &&
          other.factor == this.factor);
}

class ClicksCompanion extends UpdateCompanion<ClickRow> {
  final Value<String> id;
  final Value<String> clickerId;
  final Value<int> atUtcMs;
  final Value<double> factor;
  final Value<int> rowid;
  const ClicksCompanion({
    this.id = const Value.absent(),
    this.clickerId = const Value.absent(),
    this.atUtcMs = const Value.absent(),
    this.factor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClicksCompanion.insert({
    required String id,
    required String clickerId,
    required int atUtcMs,
    this.factor = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       clickerId = Value(clickerId),
       atUtcMs = Value(atUtcMs);
  static Insertable<ClickRow> custom({
    Expression<String>? id,
    Expression<String>? clickerId,
    Expression<int>? atUtcMs,
    Expression<double>? factor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clickerId != null) 'clicker_id': clickerId,
      if (atUtcMs != null) 'at_utc_ms': atUtcMs,
      if (factor != null) 'factor': factor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClicksCompanion copyWith({
    Value<String>? id,
    Value<String>? clickerId,
    Value<int>? atUtcMs,
    Value<double>? factor,
    Value<int>? rowid,
  }) {
    return ClicksCompanion(
      id: id ?? this.id,
      clickerId: clickerId ?? this.clickerId,
      atUtcMs: atUtcMs ?? this.atUtcMs,
      factor: factor ?? this.factor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clickerId.present) {
      map['clicker_id'] = Variable<String>(clickerId.value);
    }
    if (atUtcMs.present) {
      map['at_utc_ms'] = Variable<int>(atUtcMs.value);
    }
    if (factor.present) {
      map['factor'] = Variable<double>(factor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClicksCompanion(')
          ..write('id: $id, ')
          ..write('clickerId: $clickerId, ')
          ..write('atUtcMs: $atUtcMs, ')
          ..write('factor: $factor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClickContributionsTable extends ClickContributions
    with TableInfo<$ClickContributionsTable, ClickContributionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClickContributionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _clickIdMeta = const VerificationMeta(
    'clickId',
  );
  @override
  late final GeneratedColumn<String> clickId = GeneratedColumn<String>(
    'click_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clicks (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _signedBaseDeltaMeta = const VerificationMeta(
    'signedBaseDelta',
  );
  @override
  late final GeneratedColumn<double> signedBaseDelta = GeneratedColumn<double>(
    'signed_base_delta',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enteredInIdMeta = const VerificationMeta(
    'enteredInId',
  );
  @override
  late final GeneratedColumn<String> enteredInId = GeneratedColumn<String>(
    'entered_in_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    clickId,
    kind,
    signedBaseDelta,
    enteredInId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'click_contributions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClickContributionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('click_id')) {
      context.handle(
        _clickIdMeta,
        clickId.isAcceptableOrUnknown(data['click_id']!, _clickIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clickIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('signed_base_delta')) {
      context.handle(
        _signedBaseDeltaMeta,
        signedBaseDelta.isAcceptableOrUnknown(
          data['signed_base_delta']!,
          _signedBaseDeltaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_signedBaseDeltaMeta);
    }
    if (data.containsKey('entered_in_id')) {
      context.handle(
        _enteredInIdMeta,
        enteredInId.isAcceptableOrUnknown(
          data['entered_in_id']!,
          _enteredInIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_enteredInIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clickId, kind};
  @override
  ClickContributionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClickContributionRow(
      clickId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}click_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      signedBaseDelta: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}signed_base_delta'],
      )!,
      enteredInId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entered_in_id'],
      )!,
    );
  }

  @override
  $ClickContributionsTable createAlias(String alias) {
    return $ClickContributionsTable(attachedDatabase, alias);
  }
}

class ClickContributionRow extends DataClass
    implements Insertable<ClickContributionRow> {
  final String clickId;

  /// Wire: `volume`, `energy`, `money`, `joy`.
  final String kind;

  /// Факт в базовой единице × знак.
  final double signedBaseDelta;

  /// Wire-id единицы ввода для UI.
  final String enteredInId;
  const ClickContributionRow({
    required this.clickId,
    required this.kind,
    required this.signedBaseDelta,
    required this.enteredInId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['click_id'] = Variable<String>(clickId);
    map['kind'] = Variable<String>(kind);
    map['signed_base_delta'] = Variable<double>(signedBaseDelta);
    map['entered_in_id'] = Variable<String>(enteredInId);
    return map;
  }

  ClickContributionsCompanion toCompanion(bool nullToAbsent) {
    return ClickContributionsCompanion(
      clickId: Value(clickId),
      kind: Value(kind),
      signedBaseDelta: Value(signedBaseDelta),
      enteredInId: Value(enteredInId),
    );
  }

  factory ClickContributionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClickContributionRow(
      clickId: serializer.fromJson<String>(json['clickId']),
      kind: serializer.fromJson<String>(json['kind']),
      signedBaseDelta: serializer.fromJson<double>(json['signedBaseDelta']),
      enteredInId: serializer.fromJson<String>(json['enteredInId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clickId': serializer.toJson<String>(clickId),
      'kind': serializer.toJson<String>(kind),
      'signedBaseDelta': serializer.toJson<double>(signedBaseDelta),
      'enteredInId': serializer.toJson<String>(enteredInId),
    };
  }

  ClickContributionRow copyWith({
    String? clickId,
    String? kind,
    double? signedBaseDelta,
    String? enteredInId,
  }) => ClickContributionRow(
    clickId: clickId ?? this.clickId,
    kind: kind ?? this.kind,
    signedBaseDelta: signedBaseDelta ?? this.signedBaseDelta,
    enteredInId: enteredInId ?? this.enteredInId,
  );
  ClickContributionRow copyWithCompanion(ClickContributionsCompanion data) {
    return ClickContributionRow(
      clickId: data.clickId.present ? data.clickId.value : this.clickId,
      kind: data.kind.present ? data.kind.value : this.kind,
      signedBaseDelta: data.signedBaseDelta.present
          ? data.signedBaseDelta.value
          : this.signedBaseDelta,
      enteredInId: data.enteredInId.present
          ? data.enteredInId.value
          : this.enteredInId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClickContributionRow(')
          ..write('clickId: $clickId, ')
          ..write('kind: $kind, ')
          ..write('signedBaseDelta: $signedBaseDelta, ')
          ..write('enteredInId: $enteredInId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(clickId, kind, signedBaseDelta, enteredInId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClickContributionRow &&
          other.clickId == this.clickId &&
          other.kind == this.kind &&
          other.signedBaseDelta == this.signedBaseDelta &&
          other.enteredInId == this.enteredInId);
}

class ClickContributionsCompanion
    extends UpdateCompanion<ClickContributionRow> {
  final Value<String> clickId;
  final Value<String> kind;
  final Value<double> signedBaseDelta;
  final Value<String> enteredInId;
  final Value<int> rowid;
  const ClickContributionsCompanion({
    this.clickId = const Value.absent(),
    this.kind = const Value.absent(),
    this.signedBaseDelta = const Value.absent(),
    this.enteredInId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClickContributionsCompanion.insert({
    required String clickId,
    required String kind,
    required double signedBaseDelta,
    required String enteredInId,
    this.rowid = const Value.absent(),
  }) : clickId = Value(clickId),
       kind = Value(kind),
       signedBaseDelta = Value(signedBaseDelta),
       enteredInId = Value(enteredInId);
  static Insertable<ClickContributionRow> custom({
    Expression<String>? clickId,
    Expression<String>? kind,
    Expression<double>? signedBaseDelta,
    Expression<String>? enteredInId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clickId != null) 'click_id': clickId,
      if (kind != null) 'kind': kind,
      if (signedBaseDelta != null) 'signed_base_delta': signedBaseDelta,
      if (enteredInId != null) 'entered_in_id': enteredInId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClickContributionsCompanion copyWith({
    Value<String>? clickId,
    Value<String>? kind,
    Value<double>? signedBaseDelta,
    Value<String>? enteredInId,
    Value<int>? rowid,
  }) {
    return ClickContributionsCompanion(
      clickId: clickId ?? this.clickId,
      kind: kind ?? this.kind,
      signedBaseDelta: signedBaseDelta ?? this.signedBaseDelta,
      enteredInId: enteredInId ?? this.enteredInId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clickId.present) {
      map['click_id'] = Variable<String>(clickId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (signedBaseDelta.present) {
      map['signed_base_delta'] = Variable<double>(signedBaseDelta.value);
    }
    if (enteredInId.present) {
      map['entered_in_id'] = Variable<String>(enteredInId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClickContributionsCompanion(')
          ..write('clickId: $clickId, ')
          ..write('kind: $kind, ')
          ..write('signedBaseDelta: $signedBaseDelta, ')
          ..write('enteredInId: $enteredInId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClickerSettingsTable extends ClickerSettings
    with TableInfo<$ClickerSettingsTable, ClickerSettingsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClickerSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _clickerIdMeta = const VerificationMeta(
    'clickerId',
  );
  @override
  late final GeneratedColumn<String> clickerId = GeneratedColumn<String>(
    'clicker_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _volumeEnteredMeta = const VerificationMeta(
    'volumeEntered',
  );
  @override
  late final GeneratedColumn<double> volumeEntered = GeneratedColumn<double>(
    'volume_entered',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _energyEnteredMeta = const VerificationMeta(
    'energyEntered',
  );
  @override
  late final GeneratedColumn<double> energyEntered = GeneratedColumn<double>(
    'energy_entered',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moneyEnteredMeta = const VerificationMeta(
    'moneyEntered',
  );
  @override
  late final GeneratedColumn<double> moneyEntered = GeneratedColumn<double>(
    'money_entered',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _joyEnteredMeta = const VerificationMeta(
    'joyEntered',
  );
  @override
  late final GeneratedColumn<double> joyEntered = GeneratedColumn<double>(
    'joy_entered',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    clickerId,
    volumeEntered,
    energyEntered,
    moneyEntered,
    joyEntered,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clicker_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClickerSettingsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('clicker_id')) {
      context.handle(
        _clickerIdMeta,
        clickerId.isAcceptableOrUnknown(data['clicker_id']!, _clickerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clickerIdMeta);
    }
    if (data.containsKey('volume_entered')) {
      context.handle(
        _volumeEnteredMeta,
        volumeEntered.isAcceptableOrUnknown(
          data['volume_entered']!,
          _volumeEnteredMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_volumeEnteredMeta);
    }
    if (data.containsKey('energy_entered')) {
      context.handle(
        _energyEnteredMeta,
        energyEntered.isAcceptableOrUnknown(
          data['energy_entered']!,
          _energyEnteredMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_energyEnteredMeta);
    }
    if (data.containsKey('money_entered')) {
      context.handle(
        _moneyEnteredMeta,
        moneyEntered.isAcceptableOrUnknown(
          data['money_entered']!,
          _moneyEnteredMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_moneyEnteredMeta);
    }
    if (data.containsKey('joy_entered')) {
      context.handle(
        _joyEnteredMeta,
        joyEntered.isAcceptableOrUnknown(data['joy_entered']!, _joyEnteredMeta),
      );
    } else if (isInserting) {
      context.missing(_joyEnteredMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clickerId};
  @override
  ClickerSettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClickerSettingsRow(
      clickerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clicker_id'],
      )!,
      volumeEntered: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}volume_entered'],
      )!,
      energyEntered: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}energy_entered'],
      )!,
      moneyEntered: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}money_entered'],
      )!,
      joyEntered: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}joy_entered'],
      )!,
    );
  }

  @override
  $ClickerSettingsTable createAlias(String alias) {
    return $ClickerSettingsTable(attachedDatabase, alias);
  }
}

class ClickerSettingsRow extends DataClass
    implements Insertable<ClickerSettingsRow> {
  /// Id пресета, v1 — `clicker-beer`.
  final String clickerId;

  /// Объём в литрах, как на оси пресета.
  final double volumeEntered;

  /// Ккал, как на оси пресета.
  final double energyEntered;

  /// Цена в рублях, величина без знака. Знак оси остаётся minus.
  final double moneyEntered;

  /// Радость в пунктах пресета.
  final double joyEntered;
  const ClickerSettingsRow({
    required this.clickerId,
    required this.volumeEntered,
    required this.energyEntered,
    required this.moneyEntered,
    required this.joyEntered,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['clicker_id'] = Variable<String>(clickerId);
    map['volume_entered'] = Variable<double>(volumeEntered);
    map['energy_entered'] = Variable<double>(energyEntered);
    map['money_entered'] = Variable<double>(moneyEntered);
    map['joy_entered'] = Variable<double>(joyEntered);
    return map;
  }

  ClickerSettingsCompanion toCompanion(bool nullToAbsent) {
    return ClickerSettingsCompanion(
      clickerId: Value(clickerId),
      volumeEntered: Value(volumeEntered),
      energyEntered: Value(energyEntered),
      moneyEntered: Value(moneyEntered),
      joyEntered: Value(joyEntered),
    );
  }

  factory ClickerSettingsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClickerSettingsRow(
      clickerId: serializer.fromJson<String>(json['clickerId']),
      volumeEntered: serializer.fromJson<double>(json['volumeEntered']),
      energyEntered: serializer.fromJson<double>(json['energyEntered']),
      moneyEntered: serializer.fromJson<double>(json['moneyEntered']),
      joyEntered: serializer.fromJson<double>(json['joyEntered']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clickerId': serializer.toJson<String>(clickerId),
      'volumeEntered': serializer.toJson<double>(volumeEntered),
      'energyEntered': serializer.toJson<double>(energyEntered),
      'moneyEntered': serializer.toJson<double>(moneyEntered),
      'joyEntered': serializer.toJson<double>(joyEntered),
    };
  }

  ClickerSettingsRow copyWith({
    String? clickerId,
    double? volumeEntered,
    double? energyEntered,
    double? moneyEntered,
    double? joyEntered,
  }) => ClickerSettingsRow(
    clickerId: clickerId ?? this.clickerId,
    volumeEntered: volumeEntered ?? this.volumeEntered,
    energyEntered: energyEntered ?? this.energyEntered,
    moneyEntered: moneyEntered ?? this.moneyEntered,
    joyEntered: joyEntered ?? this.joyEntered,
  );
  ClickerSettingsRow copyWithCompanion(ClickerSettingsCompanion data) {
    return ClickerSettingsRow(
      clickerId: data.clickerId.present ? data.clickerId.value : this.clickerId,
      volumeEntered: data.volumeEntered.present
          ? data.volumeEntered.value
          : this.volumeEntered,
      energyEntered: data.energyEntered.present
          ? data.energyEntered.value
          : this.energyEntered,
      moneyEntered: data.moneyEntered.present
          ? data.moneyEntered.value
          : this.moneyEntered,
      joyEntered: data.joyEntered.present
          ? data.joyEntered.value
          : this.joyEntered,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClickerSettingsRow(')
          ..write('clickerId: $clickerId, ')
          ..write('volumeEntered: $volumeEntered, ')
          ..write('energyEntered: $energyEntered, ')
          ..write('moneyEntered: $moneyEntered, ')
          ..write('joyEntered: $joyEntered')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    clickerId,
    volumeEntered,
    energyEntered,
    moneyEntered,
    joyEntered,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClickerSettingsRow &&
          other.clickerId == this.clickerId &&
          other.volumeEntered == this.volumeEntered &&
          other.energyEntered == this.energyEntered &&
          other.moneyEntered == this.moneyEntered &&
          other.joyEntered == this.joyEntered);
}

class ClickerSettingsCompanion extends UpdateCompanion<ClickerSettingsRow> {
  final Value<String> clickerId;
  final Value<double> volumeEntered;
  final Value<double> energyEntered;
  final Value<double> moneyEntered;
  final Value<double> joyEntered;
  final Value<int> rowid;
  const ClickerSettingsCompanion({
    this.clickerId = const Value.absent(),
    this.volumeEntered = const Value.absent(),
    this.energyEntered = const Value.absent(),
    this.moneyEntered = const Value.absent(),
    this.joyEntered = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClickerSettingsCompanion.insert({
    required String clickerId,
    required double volumeEntered,
    required double energyEntered,
    required double moneyEntered,
    required double joyEntered,
    this.rowid = const Value.absent(),
  }) : clickerId = Value(clickerId),
       volumeEntered = Value(volumeEntered),
       energyEntered = Value(energyEntered),
       moneyEntered = Value(moneyEntered),
       joyEntered = Value(joyEntered);
  static Insertable<ClickerSettingsRow> custom({
    Expression<String>? clickerId,
    Expression<double>? volumeEntered,
    Expression<double>? energyEntered,
    Expression<double>? moneyEntered,
    Expression<double>? joyEntered,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clickerId != null) 'clicker_id': clickerId,
      if (volumeEntered != null) 'volume_entered': volumeEntered,
      if (energyEntered != null) 'energy_entered': energyEntered,
      if (moneyEntered != null) 'money_entered': moneyEntered,
      if (joyEntered != null) 'joy_entered': joyEntered,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClickerSettingsCompanion copyWith({
    Value<String>? clickerId,
    Value<double>? volumeEntered,
    Value<double>? energyEntered,
    Value<double>? moneyEntered,
    Value<double>? joyEntered,
    Value<int>? rowid,
  }) {
    return ClickerSettingsCompanion(
      clickerId: clickerId ?? this.clickerId,
      volumeEntered: volumeEntered ?? this.volumeEntered,
      energyEntered: energyEntered ?? this.energyEntered,
      moneyEntered: moneyEntered ?? this.moneyEntered,
      joyEntered: joyEntered ?? this.joyEntered,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clickerId.present) {
      map['clicker_id'] = Variable<String>(clickerId.value);
    }
    if (volumeEntered.present) {
      map['volume_entered'] = Variable<double>(volumeEntered.value);
    }
    if (energyEntered.present) {
      map['energy_entered'] = Variable<double>(energyEntered.value);
    }
    if (moneyEntered.present) {
      map['money_entered'] = Variable<double>(moneyEntered.value);
    }
    if (joyEntered.present) {
      map['joy_entered'] = Variable<double>(joyEntered.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClickerSettingsCompanion(')
          ..write('clickerId: $clickerId, ')
          ..write('volumeEntered: $volumeEntered, ')
          ..write('energyEntered: $energyEntered, ')
          ..write('moneyEntered: $moneyEntered, ')
          ..write('joyEntered: $joyEntered, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClicksTable clicks = $ClicksTable(this);
  late final $ClickContributionsTable clickContributions =
      $ClickContributionsTable(this);
  late final $ClickerSettingsTable clickerSettings = $ClickerSettingsTable(
    this,
  );
  late final Index idxClicksAt = Index(
    'idx_clicks_at',
    'CREATE INDEX idx_clicks_at ON clicks (at_utc_ms DESC)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    clicks,
    clickContributions,
    clickerSettings,
    idxClicksAt,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'clicks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('click_contributions', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ClicksTableCreateCompanionBuilder = ClicksCompanion Function({
  required String id,
  required String clickerId,
  required int atUtcMs,
  Value<double> factor,
  Value<int> rowid,
});
typedef $$ClicksTableUpdateCompanionBuilder = ClicksCompanion Function({
  Value<String> id,
  Value<String> clickerId,
  Value<int> atUtcMs,
  Value<double> factor,
  Value<int> rowid,
});

final class $$ClicksTableReferences
    extends BaseReferences<_$AppDatabase, $ClicksTable, ClickRow> {
  $$ClicksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $ClickContributionsTable,
    List<ClickContributionRow>
  >
  _clickContributionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.clickContributions,
        aliasName: 'clicks__id__click_contributions__click_id',
      );

  $$ClickContributionsTableProcessedTableManager get clickContributionsRefs {
    final manager = $$ClickContributionsTableTableManager(
      $_db,
      $_db.clickContributions,
    ).filter((f) => f.clickId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _clickContributionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ClicksTableFilterComposer
    extends Composer<_$AppDatabase, $ClicksTable> {
  $$ClicksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clickerId => $composableBuilder(
    column: $table.clickerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get atUtcMs => $composableBuilder(
    column: $table.atUtcMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get factor => $composableBuilder(
    column: $table.factor,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> clickContributionsRefs(
    Expression<bool> Function($$ClickContributionsTableFilterComposer f) f,
  ) {
    final $$ClickContributionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.clickContributions,
      getReferencedColumn: (t) => t.clickId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClickContributionsTableFilterComposer(
            $db: $db,
            $table: $db.clickContributions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClicksTableOrderingComposer
    extends Composer<_$AppDatabase, $ClicksTable> {
  $$ClicksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clickerId => $composableBuilder(
    column: $table.clickerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get atUtcMs => $composableBuilder(
    column: $table.atUtcMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get factor => $composableBuilder(
    column: $table.factor,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClicksTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClicksTable> {
  $$ClicksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clickerId =>
      $composableBuilder(column: $table.clickerId, builder: (column) => column);

  GeneratedColumn<int> get atUtcMs =>
      $composableBuilder(column: $table.atUtcMs, builder: (column) => column);

  GeneratedColumn<double> get factor =>
      $composableBuilder(column: $table.factor, builder: (column) => column);

  Expression<T> clickContributionsRefs<T extends Object>(
    Expression<T> Function($$ClickContributionsTableAnnotationComposer a) f,
  ) {
    final $$ClickContributionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.clickContributions,
          getReferencedColumn: (t) => t.clickId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ClickContributionsTableAnnotationComposer(
                $db: $db,
                $table: $db.clickContributions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ClicksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClicksTable,
          ClickRow,
          $$ClicksTableFilterComposer,
          $$ClicksTableOrderingComposer,
          $$ClicksTableAnnotationComposer,
          $$ClicksTableCreateCompanionBuilder,
          $$ClicksTableUpdateCompanionBuilder,
          (ClickRow, $$ClicksTableReferences),
          ClickRow,
          PrefetchHooks Function({bool clickContributionsRefs})
        > {
  $$ClicksTableTableManager(_$AppDatabase db, $ClicksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClicksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClicksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClicksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> clickerId = const Value.absent(),
                Value<int> atUtcMs = const Value.absent(),
                Value<double> factor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClicksCompanion(
                id: id,
                clickerId: clickerId,
                atUtcMs: atUtcMs,
                factor: factor,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String clickerId,
                required int atUtcMs,
                Value<double> factor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClicksCompanion.insert(
                id: id,
                clickerId: clickerId,
                atUtcMs: atUtcMs,
                factor: factor,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ClicksTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({clickContributionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (clickContributionsRefs) db.clickContributions,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (clickContributionsRefs)
                    await $_getPrefetchedData<
                      ClickRow,
                      $ClicksTable,
                      ClickContributionRow
                    >(
                      currentTable: table,
                      referencedTable: $$ClicksTableReferences
                          ._clickContributionsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ClicksTableReferences(
                        db,
                        table,
                        p0,
                      ).clickContributionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.clickId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ClicksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClicksTable,
      ClickRow,
      $$ClicksTableFilterComposer,
      $$ClicksTableOrderingComposer,
      $$ClicksTableAnnotationComposer,
      $$ClicksTableCreateCompanionBuilder,
      $$ClicksTableUpdateCompanionBuilder,
      (ClickRow, $$ClicksTableReferences),
      ClickRow,
      PrefetchHooks Function({bool clickContributionsRefs})
    >;
typedef $$ClickContributionsTableCreateCompanionBuilder =
    ClickContributionsCompanion Function({
      required String clickId,
      required String kind,
      required double signedBaseDelta,
      required String enteredInId,
      Value<int> rowid,
    });
typedef $$ClickContributionsTableUpdateCompanionBuilder =
    ClickContributionsCompanion Function({
      Value<String> clickId,
      Value<String> kind,
      Value<double> signedBaseDelta,
      Value<String> enteredInId,
      Value<int> rowid,
    });

final class $$ClickContributionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ClickContributionsTable,
          ClickContributionRow
        > {
  $$ClickContributionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ClicksTable _clickIdTable(_$AppDatabase db) =>
      db.clicks.createAlias('click_contributions__click_id__clicks__id');

  $$ClicksTableProcessedTableManager get clickId {
    final $_column = $_itemColumn<String>('click_id')!;

    final manager = $$ClicksTableTableManager(
      $_db,
      $_db.clicks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clickIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ClickContributionsTableFilterComposer
    extends Composer<_$AppDatabase, $ClickContributionsTable> {
  $$ClickContributionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get signedBaseDelta => $composableBuilder(
    column: $table.signedBaseDelta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get enteredInId => $composableBuilder(
    column: $table.enteredInId,
    builder: (column) => ColumnFilters(column),
  );

  $$ClicksTableFilterComposer get clickId {
    final $$ClicksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clickId,
      referencedTable: $db.clicks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClicksTableFilterComposer(
            $db: $db,
            $table: $db.clicks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ClickContributionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClickContributionsTable> {
  $$ClickContributionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get signedBaseDelta => $composableBuilder(
    column: $table.signedBaseDelta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get enteredInId => $composableBuilder(
    column: $table.enteredInId,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClicksTableOrderingComposer get clickId {
    final $$ClicksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clickId,
      referencedTable: $db.clicks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClicksTableOrderingComposer(
            $db: $db,
            $table: $db.clicks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ClickContributionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClickContributionsTable> {
  $$ClickContributionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<double> get signedBaseDelta => $composableBuilder(
    column: $table.signedBaseDelta,
    builder: (column) => column,
  );

  GeneratedColumn<String> get enteredInId => $composableBuilder(
    column: $table.enteredInId,
    builder: (column) => column,
  );

  $$ClicksTableAnnotationComposer get clickId {
    final $$ClicksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clickId,
      referencedTable: $db.clicks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClicksTableAnnotationComposer(
            $db: $db,
            $table: $db.clicks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ClickContributionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClickContributionsTable,
          ClickContributionRow,
          $$ClickContributionsTableFilterComposer,
          $$ClickContributionsTableOrderingComposer,
          $$ClickContributionsTableAnnotationComposer,
          $$ClickContributionsTableCreateCompanionBuilder,
          $$ClickContributionsTableUpdateCompanionBuilder,
          (ClickContributionRow, $$ClickContributionsTableReferences),
          ClickContributionRow,
          PrefetchHooks Function({bool clickId})
        > {
  $$ClickContributionsTableTableManager(
    _$AppDatabase db,
    $ClickContributionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClickContributionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClickContributionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClickContributionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> clickId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<double> signedBaseDelta = const Value.absent(),
                Value<String> enteredInId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClickContributionsCompanion(
                clickId: clickId,
                kind: kind,
                signedBaseDelta: signedBaseDelta,
                enteredInId: enteredInId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String clickId,
                required String kind,
                required double signedBaseDelta,
                required String enteredInId,
                Value<int> rowid = const Value.absent(),
              }) => ClickContributionsCompanion.insert(
                clickId: clickId,
                kind: kind,
                signedBaseDelta: signedBaseDelta,
                enteredInId: enteredInId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ClickContributionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({clickId = false}) {
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
                    if (clickId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.clickId,
                        referencedTable: $$ClickContributionsTableReferences
                            ._clickIdTable(db),
                        referencedColumn: $$ClickContributionsTableReferences
                            ._clickIdTable(db)
                            .id,
                      ) as T;
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

typedef $$ClickContributionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClickContributionsTable,
      ClickContributionRow,
      $$ClickContributionsTableFilterComposer,
      $$ClickContributionsTableOrderingComposer,
      $$ClickContributionsTableAnnotationComposer,
      $$ClickContributionsTableCreateCompanionBuilder,
      $$ClickContributionsTableUpdateCompanionBuilder,
      (ClickContributionRow, $$ClickContributionsTableReferences),
      ClickContributionRow,
      PrefetchHooks Function({bool clickId})
    >;
typedef $$ClickerSettingsTableCreateCompanionBuilder =
    ClickerSettingsCompanion Function({
      required String clickerId,
      required double volumeEntered,
      required double energyEntered,
      required double moneyEntered,
      required double joyEntered,
      Value<int> rowid,
    });
typedef $$ClickerSettingsTableUpdateCompanionBuilder =
    ClickerSettingsCompanion Function({
      Value<String> clickerId,
      Value<double> volumeEntered,
      Value<double> energyEntered,
      Value<double> moneyEntered,
      Value<double> joyEntered,
      Value<int> rowid,
    });

class $$ClickerSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $ClickerSettingsTable> {
  $$ClickerSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clickerId => $composableBuilder(
    column: $table.clickerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get volumeEntered => $composableBuilder(
    column: $table.volumeEntered,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get energyEntered => $composableBuilder(
    column: $table.energyEntered,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get moneyEntered => $composableBuilder(
    column: $table.moneyEntered,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get joyEntered => $composableBuilder(
    column: $table.joyEntered,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ClickerSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClickerSettingsTable> {
  $$ClickerSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clickerId => $composableBuilder(
    column: $table.clickerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get volumeEntered => $composableBuilder(
    column: $table.volumeEntered,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get energyEntered => $composableBuilder(
    column: $table.energyEntered,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get moneyEntered => $composableBuilder(
    column: $table.moneyEntered,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get joyEntered => $composableBuilder(
    column: $table.joyEntered,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClickerSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClickerSettingsTable> {
  $$ClickerSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clickerId =>
      $composableBuilder(column: $table.clickerId, builder: (column) => column);

  GeneratedColumn<double> get volumeEntered => $composableBuilder(
    column: $table.volumeEntered,
    builder: (column) => column,
  );

  GeneratedColumn<double> get energyEntered => $composableBuilder(
    column: $table.energyEntered,
    builder: (column) => column,
  );

  GeneratedColumn<double> get moneyEntered => $composableBuilder(
    column: $table.moneyEntered,
    builder: (column) => column,
  );

  GeneratedColumn<double> get joyEntered => $composableBuilder(
    column: $table.joyEntered,
    builder: (column) => column,
  );
}

class $$ClickerSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClickerSettingsTable,
          ClickerSettingsRow,
          $$ClickerSettingsTableFilterComposer,
          $$ClickerSettingsTableOrderingComposer,
          $$ClickerSettingsTableAnnotationComposer,
          $$ClickerSettingsTableCreateCompanionBuilder,
          $$ClickerSettingsTableUpdateCompanionBuilder,
          (
            ClickerSettingsRow,
            BaseReferences<
              _$AppDatabase,
              $ClickerSettingsTable,
              ClickerSettingsRow
            >,
          ),
          ClickerSettingsRow,
          PrefetchHooks Function()
        > {
  $$ClickerSettingsTableTableManager(
    _$AppDatabase db,
    $ClickerSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClickerSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClickerSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClickerSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> clickerId = const Value.absent(),
                Value<double> volumeEntered = const Value.absent(),
                Value<double> energyEntered = const Value.absent(),
                Value<double> moneyEntered = const Value.absent(),
                Value<double> joyEntered = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClickerSettingsCompanion(
                clickerId: clickerId,
                volumeEntered: volumeEntered,
                energyEntered: energyEntered,
                moneyEntered: moneyEntered,
                joyEntered: joyEntered,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String clickerId,
                required double volumeEntered,
                required double energyEntered,
                required double moneyEntered,
                required double joyEntered,
                Value<int> rowid = const Value.absent(),
              }) => ClickerSettingsCompanion.insert(
                clickerId: clickerId,
                volumeEntered: volumeEntered,
                energyEntered: energyEntered,
                moneyEntered: moneyEntered,
                joyEntered: joyEntered,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClickerSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClickerSettingsTable,
      ClickerSettingsRow,
      $$ClickerSettingsTableFilterComposer,
      $$ClickerSettingsTableOrderingComposer,
      $$ClickerSettingsTableAnnotationComposer,
      $$ClickerSettingsTableCreateCompanionBuilder,
      $$ClickerSettingsTableUpdateCompanionBuilder,
      (
        ClickerSettingsRow,
        BaseReferences<
          _$AppDatabase,
          $ClickerSettingsTable,
          ClickerSettingsRow
        >,
      ),
      ClickerSettingsRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClicksTableTableManager get clicks =>
      $$ClicksTableTableManager(_db, _db.clicks);
  $$ClickContributionsTableTableManager get clickContributions =>
      $$ClickContributionsTableTableManager(_db, _db.clickContributions);
  $$ClickerSettingsTableTableManager get clickerSettings =>
      $$ClickerSettingsTableTableManager(_db, _db.clickerSettings);
}
