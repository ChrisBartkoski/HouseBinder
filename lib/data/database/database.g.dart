// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PropertiesTable extends Properties
    with TableInfo<$PropertiesTable, Property> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PropertiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _yearBuiltMeta = const VerificationMeta(
    'yearBuilt',
  );
  @override
  late final GeneratedColumn<int> yearBuilt = GeneratedColumn<int>(
    'year_built',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _squareFeetMeta = const VerificationMeta(
    'squareFeet',
  );
  @override
  late final GeneratedColumn<int> squareFeet = GeneratedColumn<int>(
    'square_feet',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverImagePathMeta = const VerificationMeta(
    'coverImagePath',
  );
  @override
  late final GeneratedColumn<String> coverImagePath = GeneratedColumn<String>(
    'cover_image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    address,
    yearBuilt,
    squareFeet,
    notes,
    coverImagePath,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'properties';
  @override
  VerificationContext validateIntegrity(
    Insertable<Property> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('year_built')) {
      context.handle(
        _yearBuiltMeta,
        yearBuilt.isAcceptableOrUnknown(data['year_built']!, _yearBuiltMeta),
      );
    }
    if (data.containsKey('square_feet')) {
      context.handle(
        _squareFeetMeta,
        squareFeet.isAcceptableOrUnknown(data['square_feet']!, _squareFeetMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('cover_image_path')) {
      context.handle(
        _coverImagePathMeta,
        coverImagePath.isAcceptableOrUnknown(
          data['cover_image_path']!,
          _coverImagePathMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Property map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Property(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      yearBuilt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year_built'],
      ),
      squareFeet: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}square_feet'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      coverImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_image_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PropertiesTable createAlias(String alias) {
    return $PropertiesTable(attachedDatabase, alias);
  }
}

class Property extends DataClass implements Insertable<Property> {
  final String id;
  final String name;
  final String? address;
  final int? yearBuilt;
  final int? squareFeet;
  final String? notes;
  final String? coverImagePath;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Property({
    required this.id,
    required this.name,
    this.address,
    this.yearBuilt,
    this.squareFeet,
    this.notes,
    this.coverImagePath,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || yearBuilt != null) {
      map['year_built'] = Variable<int>(yearBuilt);
    }
    if (!nullToAbsent || squareFeet != null) {
      map['square_feet'] = Variable<int>(squareFeet);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || coverImagePath != null) {
      map['cover_image_path'] = Variable<String>(coverImagePath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PropertiesCompanion toCompanion(bool nullToAbsent) {
    return PropertiesCompanion(
      id: Value(id),
      name: Value(name),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      yearBuilt: yearBuilt == null && nullToAbsent
          ? const Value.absent()
          : Value(yearBuilt),
      squareFeet: squareFeet == null && nullToAbsent
          ? const Value.absent()
          : Value(squareFeet),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      coverImagePath: coverImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(coverImagePath),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Property.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Property(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String?>(json['address']),
      yearBuilt: serializer.fromJson<int?>(json['yearBuilt']),
      squareFeet: serializer.fromJson<int?>(json['squareFeet']),
      notes: serializer.fromJson<String?>(json['notes']),
      coverImagePath: serializer.fromJson<String?>(json['coverImagePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String?>(address),
      'yearBuilt': serializer.toJson<int?>(yearBuilt),
      'squareFeet': serializer.toJson<int?>(squareFeet),
      'notes': serializer.toJson<String?>(notes),
      'coverImagePath': serializer.toJson<String?>(coverImagePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Property copyWith({
    String? id,
    String? name,
    Value<String?> address = const Value.absent(),
    Value<int?> yearBuilt = const Value.absent(),
    Value<int?> squareFeet = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> coverImagePath = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Property(
    id: id ?? this.id,
    name: name ?? this.name,
    address: address.present ? address.value : this.address,
    yearBuilt: yearBuilt.present ? yearBuilt.value : this.yearBuilt,
    squareFeet: squareFeet.present ? squareFeet.value : this.squareFeet,
    notes: notes.present ? notes.value : this.notes,
    coverImagePath: coverImagePath.present
        ? coverImagePath.value
        : this.coverImagePath,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Property copyWithCompanion(PropertiesCompanion data) {
    return Property(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      yearBuilt: data.yearBuilt.present ? data.yearBuilt.value : this.yearBuilt,
      squareFeet: data.squareFeet.present
          ? data.squareFeet.value
          : this.squareFeet,
      notes: data.notes.present ? data.notes.value : this.notes,
      coverImagePath: data.coverImagePath.present
          ? data.coverImagePath.value
          : this.coverImagePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Property(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('yearBuilt: $yearBuilt, ')
          ..write('squareFeet: $squareFeet, ')
          ..write('notes: $notes, ')
          ..write('coverImagePath: $coverImagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    address,
    yearBuilt,
    squareFeet,
    notes,
    coverImagePath,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Property &&
          other.id == this.id &&
          other.name == this.name &&
          other.address == this.address &&
          other.yearBuilt == this.yearBuilt &&
          other.squareFeet == this.squareFeet &&
          other.notes == this.notes &&
          other.coverImagePath == this.coverImagePath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PropertiesCompanion extends UpdateCompanion<Property> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> address;
  final Value<int?> yearBuilt;
  final Value<int?> squareFeet;
  final Value<String?> notes;
  final Value<String?> coverImagePath;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PropertiesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.yearBuilt = const Value.absent(),
    this.squareFeet = const Value.absent(),
    this.notes = const Value.absent(),
    this.coverImagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PropertiesCompanion.insert({
    required String id,
    required String name,
    this.address = const Value.absent(),
    this.yearBuilt = const Value.absent(),
    this.squareFeet = const Value.absent(),
    this.notes = const Value.absent(),
    this.coverImagePath = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Property> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? address,
    Expression<int>? yearBuilt,
    Expression<int>? squareFeet,
    Expression<String>? notes,
    Expression<String>? coverImagePath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (yearBuilt != null) 'year_built': yearBuilt,
      if (squareFeet != null) 'square_feet': squareFeet,
      if (notes != null) 'notes': notes,
      if (coverImagePath != null) 'cover_image_path': coverImagePath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PropertiesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? address,
    Value<int?>? yearBuilt,
    Value<int?>? squareFeet,
    Value<String?>? notes,
    Value<String?>? coverImagePath,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PropertiesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      yearBuilt: yearBuilt ?? this.yearBuilt,
      squareFeet: squareFeet ?? this.squareFeet,
      notes: notes ?? this.notes,
      coverImagePath: coverImagePath ?? this.coverImagePath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (yearBuilt.present) {
      map['year_built'] = Variable<int>(yearBuilt.value);
    }
    if (squareFeet.present) {
      map['square_feet'] = Variable<int>(squareFeet.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (coverImagePath.present) {
      map['cover_image_path'] = Variable<String>(coverImagePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PropertiesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('yearBuilt: $yearBuilt, ')
          ..write('squareFeet: $squareFeet, ')
          ..write('notes: $notes, ')
          ..write('coverImagePath: $coverImagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AssetsTable extends Assets with TableInfo<$AssetsTable, Asset> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _propertyIdMeta = const VerificationMeta(
    'propertyId',
  );
  @override
  late final GeneratedColumn<String> propertyId = GeneratedColumn<String>(
    'property_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES properties (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationRoomMeta = const VerificationMeta(
    'locationRoom',
  );
  @override
  late final GeneratedColumn<String> locationRoom = GeneratedColumn<String>(
    'location_room',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _manufacturerMeta = const VerificationMeta(
    'manufacturer',
  );
  @override
  late final GeneratedColumn<String> manufacturer = GeneratedColumn<String>(
    'manufacturer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serialNumberMeta = const VerificationMeta(
    'serialNumber',
  );
  @override
  late final GeneratedColumn<String> serialNumber = GeneratedColumn<String>(
    'serial_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _installDateMeta = const VerificationMeta(
    'installDate',
  );
  @override
  late final GeneratedColumn<DateTime> installDate = GeneratedColumn<DateTime>(
    'install_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchaseDateMeta = const VerificationMeta(
    'purchaseDate',
  );
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
    'purchase_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _warrantyExpirationDateMeta =
      const VerificationMeta('warrantyExpirationDate');
  @override
  late final GeneratedColumn<DateTime> warrantyExpirationDate =
      GeneratedColumn<DateTime>(
        'warranty_expiration_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _purchasePriceMeta = const VerificationMeta(
    'purchasePrice',
  );
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
    'purchase_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoPathsMeta = const VerificationMeta(
    'photoPaths',
  );
  @override
  late final GeneratedColumn<String> photoPaths = GeneratedColumn<String>(
    'photo_paths',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _labelPhotoPathMeta = const VerificationMeta(
    'labelPhotoPath',
  );
  @override
  late final GeneratedColumn<String> labelPhotoPath = GeneratedColumn<String>(
    'label_photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    propertyId,
    name,
    category,
    locationRoom,
    manufacturer,
    model,
    serialNumber,
    installDate,
    purchaseDate,
    warrantyExpirationDate,
    purchasePrice,
    notes,
    photoPaths,
    labelPhotoPath,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assets';
  @override
  VerificationContext validateIntegrity(
    Insertable<Asset> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('property_id')) {
      context.handle(
        _propertyIdMeta,
        propertyId.isAcceptableOrUnknown(data['property_id']!, _propertyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_propertyIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('location_room')) {
      context.handle(
        _locationRoomMeta,
        locationRoom.isAcceptableOrUnknown(
          data['location_room']!,
          _locationRoomMeta,
        ),
      );
    }
    if (data.containsKey('manufacturer')) {
      context.handle(
        _manufacturerMeta,
        manufacturer.isAcceptableOrUnknown(
          data['manufacturer']!,
          _manufacturerMeta,
        ),
      );
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    }
    if (data.containsKey('serial_number')) {
      context.handle(
        _serialNumberMeta,
        serialNumber.isAcceptableOrUnknown(
          data['serial_number']!,
          _serialNumberMeta,
        ),
      );
    }
    if (data.containsKey('install_date')) {
      context.handle(
        _installDateMeta,
        installDate.isAcceptableOrUnknown(
          data['install_date']!,
          _installDateMeta,
        ),
      );
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
        _purchaseDateMeta,
        purchaseDate.isAcceptableOrUnknown(
          data['purchase_date']!,
          _purchaseDateMeta,
        ),
      );
    }
    if (data.containsKey('warranty_expiration_date')) {
      context.handle(
        _warrantyExpirationDateMeta,
        warrantyExpirationDate.isAcceptableOrUnknown(
          data['warranty_expiration_date']!,
          _warrantyExpirationDateMeta,
        ),
      );
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
        _purchasePriceMeta,
        purchasePrice.isAcceptableOrUnknown(
          data['purchase_price']!,
          _purchasePriceMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('photo_paths')) {
      context.handle(
        _photoPathsMeta,
        photoPaths.isAcceptableOrUnknown(data['photo_paths']!, _photoPathsMeta),
      );
    }
    if (data.containsKey('label_photo_path')) {
      context.handle(
        _labelPhotoPathMeta,
        labelPhotoPath.isAcceptableOrUnknown(
          data['label_photo_path']!,
          _labelPhotoPathMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Asset map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Asset(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      propertyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}property_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      locationRoom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_room'],
      ),
      manufacturer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manufacturer'],
      ),
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      ),
      serialNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}serial_number'],
      ),
      installDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}install_date'],
      ),
      purchaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchase_date'],
      ),
      warrantyExpirationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}warranty_expiration_date'],
      ),
      purchasePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}purchase_price'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      photoPaths: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_paths'],
      )!,
      labelPhotoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label_photo_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AssetsTable createAlias(String alias) {
    return $AssetsTable(attachedDatabase, alias);
  }
}

class Asset extends DataClass implements Insertable<Asset> {
  final String id;
  final String propertyId;
  final String name;
  final String category;
  final String? locationRoom;
  final String? manufacturer;
  final String? model;
  final String? serialNumber;
  final DateTime? installDate;
  final DateTime? purchaseDate;
  final DateTime? warrantyExpirationDate;
  final double? purchasePrice;
  final String? notes;
  final String photoPaths;
  final String? labelPhotoPath;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Asset({
    required this.id,
    required this.propertyId,
    required this.name,
    required this.category,
    this.locationRoom,
    this.manufacturer,
    this.model,
    this.serialNumber,
    this.installDate,
    this.purchaseDate,
    this.warrantyExpirationDate,
    this.purchasePrice,
    this.notes,
    required this.photoPaths,
    this.labelPhotoPath,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['property_id'] = Variable<String>(propertyId);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || locationRoom != null) {
      map['location_room'] = Variable<String>(locationRoom);
    }
    if (!nullToAbsent || manufacturer != null) {
      map['manufacturer'] = Variable<String>(manufacturer);
    }
    if (!nullToAbsent || model != null) {
      map['model'] = Variable<String>(model);
    }
    if (!nullToAbsent || serialNumber != null) {
      map['serial_number'] = Variable<String>(serialNumber);
    }
    if (!nullToAbsent || installDate != null) {
      map['install_date'] = Variable<DateTime>(installDate);
    }
    if (!nullToAbsent || purchaseDate != null) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate);
    }
    if (!nullToAbsent || warrantyExpirationDate != null) {
      map['warranty_expiration_date'] = Variable<DateTime>(
        warrantyExpirationDate,
      );
    }
    if (!nullToAbsent || purchasePrice != null) {
      map['purchase_price'] = Variable<double>(purchasePrice);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['photo_paths'] = Variable<String>(photoPaths);
    if (!nullToAbsent || labelPhotoPath != null) {
      map['label_photo_path'] = Variable<String>(labelPhotoPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AssetsCompanion toCompanion(bool nullToAbsent) {
    return AssetsCompanion(
      id: Value(id),
      propertyId: Value(propertyId),
      name: Value(name),
      category: Value(category),
      locationRoom: locationRoom == null && nullToAbsent
          ? const Value.absent()
          : Value(locationRoom),
      manufacturer: manufacturer == null && nullToAbsent
          ? const Value.absent()
          : Value(manufacturer),
      model: model == null && nullToAbsent
          ? const Value.absent()
          : Value(model),
      serialNumber: serialNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(serialNumber),
      installDate: installDate == null && nullToAbsent
          ? const Value.absent()
          : Value(installDate),
      purchaseDate: purchaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseDate),
      warrantyExpirationDate: warrantyExpirationDate == null && nullToAbsent
          ? const Value.absent()
          : Value(warrantyExpirationDate),
      purchasePrice: purchasePrice == null && nullToAbsent
          ? const Value.absent()
          : Value(purchasePrice),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      photoPaths: Value(photoPaths),
      labelPhotoPath: labelPhotoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(labelPhotoPath),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Asset.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Asset(
      id: serializer.fromJson<String>(json['id']),
      propertyId: serializer.fromJson<String>(json['propertyId']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      locationRoom: serializer.fromJson<String?>(json['locationRoom']),
      manufacturer: serializer.fromJson<String?>(json['manufacturer']),
      model: serializer.fromJson<String?>(json['model']),
      serialNumber: serializer.fromJson<String?>(json['serialNumber']),
      installDate: serializer.fromJson<DateTime?>(json['installDate']),
      purchaseDate: serializer.fromJson<DateTime?>(json['purchaseDate']),
      warrantyExpirationDate: serializer.fromJson<DateTime?>(
        json['warrantyExpirationDate'],
      ),
      purchasePrice: serializer.fromJson<double?>(json['purchasePrice']),
      notes: serializer.fromJson<String?>(json['notes']),
      photoPaths: serializer.fromJson<String>(json['photoPaths']),
      labelPhotoPath: serializer.fromJson<String?>(json['labelPhotoPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'propertyId': serializer.toJson<String>(propertyId),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'locationRoom': serializer.toJson<String?>(locationRoom),
      'manufacturer': serializer.toJson<String?>(manufacturer),
      'model': serializer.toJson<String?>(model),
      'serialNumber': serializer.toJson<String?>(serialNumber),
      'installDate': serializer.toJson<DateTime?>(installDate),
      'purchaseDate': serializer.toJson<DateTime?>(purchaseDate),
      'warrantyExpirationDate': serializer.toJson<DateTime?>(
        warrantyExpirationDate,
      ),
      'purchasePrice': serializer.toJson<double?>(purchasePrice),
      'notes': serializer.toJson<String?>(notes),
      'photoPaths': serializer.toJson<String>(photoPaths),
      'labelPhotoPath': serializer.toJson<String?>(labelPhotoPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Asset copyWith({
    String? id,
    String? propertyId,
    String? name,
    String? category,
    Value<String?> locationRoom = const Value.absent(),
    Value<String?> manufacturer = const Value.absent(),
    Value<String?> model = const Value.absent(),
    Value<String?> serialNumber = const Value.absent(),
    Value<DateTime?> installDate = const Value.absent(),
    Value<DateTime?> purchaseDate = const Value.absent(),
    Value<DateTime?> warrantyExpirationDate = const Value.absent(),
    Value<double?> purchasePrice = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    String? photoPaths,
    Value<String?> labelPhotoPath = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Asset(
    id: id ?? this.id,
    propertyId: propertyId ?? this.propertyId,
    name: name ?? this.name,
    category: category ?? this.category,
    locationRoom: locationRoom.present ? locationRoom.value : this.locationRoom,
    manufacturer: manufacturer.present ? manufacturer.value : this.manufacturer,
    model: model.present ? model.value : this.model,
    serialNumber: serialNumber.present ? serialNumber.value : this.serialNumber,
    installDate: installDate.present ? installDate.value : this.installDate,
    purchaseDate: purchaseDate.present ? purchaseDate.value : this.purchaseDate,
    warrantyExpirationDate: warrantyExpirationDate.present
        ? warrantyExpirationDate.value
        : this.warrantyExpirationDate,
    purchasePrice: purchasePrice.present
        ? purchasePrice.value
        : this.purchasePrice,
    notes: notes.present ? notes.value : this.notes,
    photoPaths: photoPaths ?? this.photoPaths,
    labelPhotoPath: labelPhotoPath.present
        ? labelPhotoPath.value
        : this.labelPhotoPath,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Asset copyWithCompanion(AssetsCompanion data) {
    return Asset(
      id: data.id.present ? data.id.value : this.id,
      propertyId: data.propertyId.present
          ? data.propertyId.value
          : this.propertyId,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      locationRoom: data.locationRoom.present
          ? data.locationRoom.value
          : this.locationRoom,
      manufacturer: data.manufacturer.present
          ? data.manufacturer.value
          : this.manufacturer,
      model: data.model.present ? data.model.value : this.model,
      serialNumber: data.serialNumber.present
          ? data.serialNumber.value
          : this.serialNumber,
      installDate: data.installDate.present
          ? data.installDate.value
          : this.installDate,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      warrantyExpirationDate: data.warrantyExpirationDate.present
          ? data.warrantyExpirationDate.value
          : this.warrantyExpirationDate,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      notes: data.notes.present ? data.notes.value : this.notes,
      photoPaths: data.photoPaths.present
          ? data.photoPaths.value
          : this.photoPaths,
      labelPhotoPath: data.labelPhotoPath.present
          ? data.labelPhotoPath.value
          : this.labelPhotoPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Asset(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('locationRoom: $locationRoom, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('model: $model, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('installDate: $installDate, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('warrantyExpirationDate: $warrantyExpirationDate, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('notes: $notes, ')
          ..write('photoPaths: $photoPaths, ')
          ..write('labelPhotoPath: $labelPhotoPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    propertyId,
    name,
    category,
    locationRoom,
    manufacturer,
    model,
    serialNumber,
    installDate,
    purchaseDate,
    warrantyExpirationDate,
    purchasePrice,
    notes,
    photoPaths,
    labelPhotoPath,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Asset &&
          other.id == this.id &&
          other.propertyId == this.propertyId &&
          other.name == this.name &&
          other.category == this.category &&
          other.locationRoom == this.locationRoom &&
          other.manufacturer == this.manufacturer &&
          other.model == this.model &&
          other.serialNumber == this.serialNumber &&
          other.installDate == this.installDate &&
          other.purchaseDate == this.purchaseDate &&
          other.warrantyExpirationDate == this.warrantyExpirationDate &&
          other.purchasePrice == this.purchasePrice &&
          other.notes == this.notes &&
          other.photoPaths == this.photoPaths &&
          other.labelPhotoPath == this.labelPhotoPath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AssetsCompanion extends UpdateCompanion<Asset> {
  final Value<String> id;
  final Value<String> propertyId;
  final Value<String> name;
  final Value<String> category;
  final Value<String?> locationRoom;
  final Value<String?> manufacturer;
  final Value<String?> model;
  final Value<String?> serialNumber;
  final Value<DateTime?> installDate;
  final Value<DateTime?> purchaseDate;
  final Value<DateTime?> warrantyExpirationDate;
  final Value<double?> purchasePrice;
  final Value<String?> notes;
  final Value<String> photoPaths;
  final Value<String?> labelPhotoPath;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AssetsCompanion({
    this.id = const Value.absent(),
    this.propertyId = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.locationRoom = const Value.absent(),
    this.manufacturer = const Value.absent(),
    this.model = const Value.absent(),
    this.serialNumber = const Value.absent(),
    this.installDate = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.warrantyExpirationDate = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoPaths = const Value.absent(),
    this.labelPhotoPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AssetsCompanion.insert({
    required String id,
    required String propertyId,
    required String name,
    required String category,
    this.locationRoom = const Value.absent(),
    this.manufacturer = const Value.absent(),
    this.model = const Value.absent(),
    this.serialNumber = const Value.absent(),
    this.installDate = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.warrantyExpirationDate = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoPaths = const Value.absent(),
    this.labelPhotoPath = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       propertyId = Value(propertyId),
       name = Value(name),
       category = Value(category),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Asset> custom({
    Expression<String>? id,
    Expression<String>? propertyId,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? locationRoom,
    Expression<String>? manufacturer,
    Expression<String>? model,
    Expression<String>? serialNumber,
    Expression<DateTime>? installDate,
    Expression<DateTime>? purchaseDate,
    Expression<DateTime>? warrantyExpirationDate,
    Expression<double>? purchasePrice,
    Expression<String>? notes,
    Expression<String>? photoPaths,
    Expression<String>? labelPhotoPath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (propertyId != null) 'property_id': propertyId,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (locationRoom != null) 'location_room': locationRoom,
      if (manufacturer != null) 'manufacturer': manufacturer,
      if (model != null) 'model': model,
      if (serialNumber != null) 'serial_number': serialNumber,
      if (installDate != null) 'install_date': installDate,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (warrantyExpirationDate != null)
        'warranty_expiration_date': warrantyExpirationDate,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (notes != null) 'notes': notes,
      if (photoPaths != null) 'photo_paths': photoPaths,
      if (labelPhotoPath != null) 'label_photo_path': labelPhotoPath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AssetsCompanion copyWith({
    Value<String>? id,
    Value<String>? propertyId,
    Value<String>? name,
    Value<String>? category,
    Value<String?>? locationRoom,
    Value<String?>? manufacturer,
    Value<String?>? model,
    Value<String?>? serialNumber,
    Value<DateTime?>? installDate,
    Value<DateTime?>? purchaseDate,
    Value<DateTime?>? warrantyExpirationDate,
    Value<double?>? purchasePrice,
    Value<String?>? notes,
    Value<String>? photoPaths,
    Value<String?>? labelPhotoPath,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AssetsCompanion(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      name: name ?? this.name,
      category: category ?? this.category,
      locationRoom: locationRoom ?? this.locationRoom,
      manufacturer: manufacturer ?? this.manufacturer,
      model: model ?? this.model,
      serialNumber: serialNumber ?? this.serialNumber,
      installDate: installDate ?? this.installDate,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      warrantyExpirationDate:
          warrantyExpirationDate ?? this.warrantyExpirationDate,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      notes: notes ?? this.notes,
      photoPaths: photoPaths ?? this.photoPaths,
      labelPhotoPath: labelPhotoPath ?? this.labelPhotoPath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (propertyId.present) {
      map['property_id'] = Variable<String>(propertyId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (locationRoom.present) {
      map['location_room'] = Variable<String>(locationRoom.value);
    }
    if (manufacturer.present) {
      map['manufacturer'] = Variable<String>(manufacturer.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (serialNumber.present) {
      map['serial_number'] = Variable<String>(serialNumber.value);
    }
    if (installDate.present) {
      map['install_date'] = Variable<DateTime>(installDate.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (warrantyExpirationDate.present) {
      map['warranty_expiration_date'] = Variable<DateTime>(
        warrantyExpirationDate.value,
      );
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (photoPaths.present) {
      map['photo_paths'] = Variable<String>(photoPaths.value);
    }
    if (labelPhotoPath.present) {
      map['label_photo_path'] = Variable<String>(labelPhotoPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssetsCompanion(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('locationRoom: $locationRoom, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('model: $model, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('installDate: $installDate, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('warrantyExpirationDate: $warrantyExpirationDate, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('notes: $notes, ')
          ..write('photoPaths: $photoPaths, ')
          ..write('labelPhotoPath: $labelPhotoPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MaintenanceTasksTable extends MaintenanceTasks
    with TableInfo<$MaintenanceTasksTable, MaintenanceTask> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaintenanceTasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _propertyIdMeta = const VerificationMeta(
    'propertyId',
  );
  @override
  late final GeneratedColumn<String> propertyId = GeneratedColumn<String>(
    'property_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES properties (id)',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _instructionsMeta = const VerificationMeta(
    'instructions',
  );
  @override
  late final GeneratedColumn<String> instructions = GeneratedColumn<String>(
    'instructions',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _frequencyMeta = const VerificationMeta(
    'frequency',
  );
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
    'frequency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customIntervalDaysMeta =
      const VerificationMeta('customIntervalDays');
  @override
  late final GeneratedColumn<int> customIntervalDays = GeneratedColumn<int>(
    'custom_interval_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _seasonMeta = const VerificationMeta('season');
  @override
  late final GeneratedColumn<String> season = GeneratedColumn<String>(
    'season',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextDueDateMeta = const VerificationMeta(
    'nextDueDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextDueDate = GeneratedColumn<DateTime>(
    'next_due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastCompletedDateMeta = const VerificationMeta(
    'lastCompletedDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastCompletedDate =
      GeneratedColumn<DateTime>(
        'last_completed_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _linkedAssetIdsMeta = const VerificationMeta(
    'linkedAssetIds',
  );
  @override
  late final GeneratedColumn<String> linkedAssetIds = GeneratedColumn<String>(
    'linked_asset_ids',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _estimatedCostMeta = const VerificationMeta(
    'estimatedCost',
  );
  @override
  late final GeneratedColumn<double> estimatedCost = GeneratedColumn<double>(
    'estimated_cost',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estimatedTimeMinutesMeta =
      const VerificationMeta('estimatedTimeMinutes');
  @override
  late final GeneratedColumn<int> estimatedTimeMinutes = GeneratedColumn<int>(
    'estimated_time_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderEnabledMeta = const VerificationMeta(
    'reminderEnabled',
  );
  @override
  late final GeneratedColumn<bool> reminderEnabled = GeneratedColumn<bool>(
    'reminder_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reminder_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _reminderDaysBeforeMeta =
      const VerificationMeta('reminderDaysBefore');
  @override
  late final GeneratedColumn<int> reminderDaysBefore = GeneratedColumn<int>(
    'reminder_days_before',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isTemplateMeta = const VerificationMeta(
    'isTemplate',
  );
  @override
  late final GeneratedColumn<bool> isTemplate = GeneratedColumn<bool>(
    'is_template',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_template" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    propertyId,
    title,
    description,
    instructions,
    category,
    frequency,
    customIntervalDays,
    season,
    nextDueDate,
    lastCompletedDate,
    linkedAssetIds,
    estimatedCost,
    estimatedTimeMinutes,
    reminderEnabled,
    reminderDaysBefore,
    notes,
    isTemplate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'maintenance_tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<MaintenanceTask> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('property_id')) {
      context.handle(
        _propertyIdMeta,
        propertyId.isAcceptableOrUnknown(data['property_id']!, _propertyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_propertyIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('instructions')) {
      context.handle(
        _instructionsMeta,
        instructions.isAcceptableOrUnknown(
          data['instructions']!,
          _instructionsMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('frequency')) {
      context.handle(
        _frequencyMeta,
        frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta),
      );
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('custom_interval_days')) {
      context.handle(
        _customIntervalDaysMeta,
        customIntervalDays.isAcceptableOrUnknown(
          data['custom_interval_days']!,
          _customIntervalDaysMeta,
        ),
      );
    }
    if (data.containsKey('season')) {
      context.handle(
        _seasonMeta,
        season.isAcceptableOrUnknown(data['season']!, _seasonMeta),
      );
    }
    if (data.containsKey('next_due_date')) {
      context.handle(
        _nextDueDateMeta,
        nextDueDate.isAcceptableOrUnknown(
          data['next_due_date']!,
          _nextDueDateMeta,
        ),
      );
    }
    if (data.containsKey('last_completed_date')) {
      context.handle(
        _lastCompletedDateMeta,
        lastCompletedDate.isAcceptableOrUnknown(
          data['last_completed_date']!,
          _lastCompletedDateMeta,
        ),
      );
    }
    if (data.containsKey('linked_asset_ids')) {
      context.handle(
        _linkedAssetIdsMeta,
        linkedAssetIds.isAcceptableOrUnknown(
          data['linked_asset_ids']!,
          _linkedAssetIdsMeta,
        ),
      );
    }
    if (data.containsKey('estimated_cost')) {
      context.handle(
        _estimatedCostMeta,
        estimatedCost.isAcceptableOrUnknown(
          data['estimated_cost']!,
          _estimatedCostMeta,
        ),
      );
    }
    if (data.containsKey('estimated_time_minutes')) {
      context.handle(
        _estimatedTimeMinutesMeta,
        estimatedTimeMinutes.isAcceptableOrUnknown(
          data['estimated_time_minutes']!,
          _estimatedTimeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('reminder_enabled')) {
      context.handle(
        _reminderEnabledMeta,
        reminderEnabled.isAcceptableOrUnknown(
          data['reminder_enabled']!,
          _reminderEnabledMeta,
        ),
      );
    }
    if (data.containsKey('reminder_days_before')) {
      context.handle(
        _reminderDaysBeforeMeta,
        reminderDaysBefore.isAcceptableOrUnknown(
          data['reminder_days_before']!,
          _reminderDaysBeforeMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_template')) {
      context.handle(
        _isTemplateMeta,
        isTemplate.isAcceptableOrUnknown(data['is_template']!, _isTemplateMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MaintenanceTask map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaintenanceTask(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      propertyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}property_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      instructions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instructions'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      frequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frequency'],
      )!,
      customIntervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}custom_interval_days'],
      ),
      season: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}season'],
      ),
      nextDueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_due_date'],
      ),
      lastCompletedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_completed_date'],
      ),
      linkedAssetIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}linked_asset_ids'],
      )!,
      estimatedCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}estimated_cost'],
      ),
      estimatedTimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_time_minutes'],
      ),
      reminderEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminder_enabled'],
      )!,
      reminderDaysBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_days_before'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isTemplate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_template'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MaintenanceTasksTable createAlias(String alias) {
    return $MaintenanceTasksTable(attachedDatabase, alias);
  }
}

class MaintenanceTask extends DataClass implements Insertable<MaintenanceTask> {
  final String id;
  final String propertyId;
  final String title;
  final String? description;
  final String? instructions;
  final String? category;
  final String frequency;
  final int? customIntervalDays;
  final String? season;
  final DateTime? nextDueDate;
  final DateTime? lastCompletedDate;
  final String linkedAssetIds;
  final double? estimatedCost;
  final int? estimatedTimeMinutes;
  final bool reminderEnabled;
  final int reminderDaysBefore;
  final String? notes;
  final bool isTemplate;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MaintenanceTask({
    required this.id,
    required this.propertyId,
    required this.title,
    this.description,
    this.instructions,
    this.category,
    required this.frequency,
    this.customIntervalDays,
    this.season,
    this.nextDueDate,
    this.lastCompletedDate,
    required this.linkedAssetIds,
    this.estimatedCost,
    this.estimatedTimeMinutes,
    required this.reminderEnabled,
    required this.reminderDaysBefore,
    this.notes,
    required this.isTemplate,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['property_id'] = Variable<String>(propertyId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || instructions != null) {
      map['instructions'] = Variable<String>(instructions);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    map['frequency'] = Variable<String>(frequency);
    if (!nullToAbsent || customIntervalDays != null) {
      map['custom_interval_days'] = Variable<int>(customIntervalDays);
    }
    if (!nullToAbsent || season != null) {
      map['season'] = Variable<String>(season);
    }
    if (!nullToAbsent || nextDueDate != null) {
      map['next_due_date'] = Variable<DateTime>(nextDueDate);
    }
    if (!nullToAbsent || lastCompletedDate != null) {
      map['last_completed_date'] = Variable<DateTime>(lastCompletedDate);
    }
    map['linked_asset_ids'] = Variable<String>(linkedAssetIds);
    if (!nullToAbsent || estimatedCost != null) {
      map['estimated_cost'] = Variable<double>(estimatedCost);
    }
    if (!nullToAbsent || estimatedTimeMinutes != null) {
      map['estimated_time_minutes'] = Variable<int>(estimatedTimeMinutes);
    }
    map['reminder_enabled'] = Variable<bool>(reminderEnabled);
    map['reminder_days_before'] = Variable<int>(reminderDaysBefore);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_template'] = Variable<bool>(isTemplate);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MaintenanceTasksCompanion toCompanion(bool nullToAbsent) {
    return MaintenanceTasksCompanion(
      id: Value(id),
      propertyId: Value(propertyId),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      instructions: instructions == null && nullToAbsent
          ? const Value.absent()
          : Value(instructions),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      frequency: Value(frequency),
      customIntervalDays: customIntervalDays == null && nullToAbsent
          ? const Value.absent()
          : Value(customIntervalDays),
      season: season == null && nullToAbsent
          ? const Value.absent()
          : Value(season),
      nextDueDate: nextDueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextDueDate),
      lastCompletedDate: lastCompletedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastCompletedDate),
      linkedAssetIds: Value(linkedAssetIds),
      estimatedCost: estimatedCost == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedCost),
      estimatedTimeMinutes: estimatedTimeMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedTimeMinutes),
      reminderEnabled: Value(reminderEnabled),
      reminderDaysBefore: Value(reminderDaysBefore),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isTemplate: Value(isTemplate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MaintenanceTask.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaintenanceTask(
      id: serializer.fromJson<String>(json['id']),
      propertyId: serializer.fromJson<String>(json['propertyId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      instructions: serializer.fromJson<String?>(json['instructions']),
      category: serializer.fromJson<String?>(json['category']),
      frequency: serializer.fromJson<String>(json['frequency']),
      customIntervalDays: serializer.fromJson<int?>(json['customIntervalDays']),
      season: serializer.fromJson<String?>(json['season']),
      nextDueDate: serializer.fromJson<DateTime?>(json['nextDueDate']),
      lastCompletedDate: serializer.fromJson<DateTime?>(
        json['lastCompletedDate'],
      ),
      linkedAssetIds: serializer.fromJson<String>(json['linkedAssetIds']),
      estimatedCost: serializer.fromJson<double?>(json['estimatedCost']),
      estimatedTimeMinutes: serializer.fromJson<int?>(
        json['estimatedTimeMinutes'],
      ),
      reminderEnabled: serializer.fromJson<bool>(json['reminderEnabled']),
      reminderDaysBefore: serializer.fromJson<int>(json['reminderDaysBefore']),
      notes: serializer.fromJson<String?>(json['notes']),
      isTemplate: serializer.fromJson<bool>(json['isTemplate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'propertyId': serializer.toJson<String>(propertyId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'instructions': serializer.toJson<String?>(instructions),
      'category': serializer.toJson<String?>(category),
      'frequency': serializer.toJson<String>(frequency),
      'customIntervalDays': serializer.toJson<int?>(customIntervalDays),
      'season': serializer.toJson<String?>(season),
      'nextDueDate': serializer.toJson<DateTime?>(nextDueDate),
      'lastCompletedDate': serializer.toJson<DateTime?>(lastCompletedDate),
      'linkedAssetIds': serializer.toJson<String>(linkedAssetIds),
      'estimatedCost': serializer.toJson<double?>(estimatedCost),
      'estimatedTimeMinutes': serializer.toJson<int?>(estimatedTimeMinutes),
      'reminderEnabled': serializer.toJson<bool>(reminderEnabled),
      'reminderDaysBefore': serializer.toJson<int>(reminderDaysBefore),
      'notes': serializer.toJson<String?>(notes),
      'isTemplate': serializer.toJson<bool>(isTemplate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MaintenanceTask copyWith({
    String? id,
    String? propertyId,
    String? title,
    Value<String?> description = const Value.absent(),
    Value<String?> instructions = const Value.absent(),
    Value<String?> category = const Value.absent(),
    String? frequency,
    Value<int?> customIntervalDays = const Value.absent(),
    Value<String?> season = const Value.absent(),
    Value<DateTime?> nextDueDate = const Value.absent(),
    Value<DateTime?> lastCompletedDate = const Value.absent(),
    String? linkedAssetIds,
    Value<double?> estimatedCost = const Value.absent(),
    Value<int?> estimatedTimeMinutes = const Value.absent(),
    bool? reminderEnabled,
    int? reminderDaysBefore,
    Value<String?> notes = const Value.absent(),
    bool? isTemplate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MaintenanceTask(
    id: id ?? this.id,
    propertyId: propertyId ?? this.propertyId,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    instructions: instructions.present ? instructions.value : this.instructions,
    category: category.present ? category.value : this.category,
    frequency: frequency ?? this.frequency,
    customIntervalDays: customIntervalDays.present
        ? customIntervalDays.value
        : this.customIntervalDays,
    season: season.present ? season.value : this.season,
    nextDueDate: nextDueDate.present ? nextDueDate.value : this.nextDueDate,
    lastCompletedDate: lastCompletedDate.present
        ? lastCompletedDate.value
        : this.lastCompletedDate,
    linkedAssetIds: linkedAssetIds ?? this.linkedAssetIds,
    estimatedCost: estimatedCost.present
        ? estimatedCost.value
        : this.estimatedCost,
    estimatedTimeMinutes: estimatedTimeMinutes.present
        ? estimatedTimeMinutes.value
        : this.estimatedTimeMinutes,
    reminderEnabled: reminderEnabled ?? this.reminderEnabled,
    reminderDaysBefore: reminderDaysBefore ?? this.reminderDaysBefore,
    notes: notes.present ? notes.value : this.notes,
    isTemplate: isTemplate ?? this.isTemplate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MaintenanceTask copyWithCompanion(MaintenanceTasksCompanion data) {
    return MaintenanceTask(
      id: data.id.present ? data.id.value : this.id,
      propertyId: data.propertyId.present
          ? data.propertyId.value
          : this.propertyId,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      instructions: data.instructions.present
          ? data.instructions.value
          : this.instructions,
      category: data.category.present ? data.category.value : this.category,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      customIntervalDays: data.customIntervalDays.present
          ? data.customIntervalDays.value
          : this.customIntervalDays,
      season: data.season.present ? data.season.value : this.season,
      nextDueDate: data.nextDueDate.present
          ? data.nextDueDate.value
          : this.nextDueDate,
      lastCompletedDate: data.lastCompletedDate.present
          ? data.lastCompletedDate.value
          : this.lastCompletedDate,
      linkedAssetIds: data.linkedAssetIds.present
          ? data.linkedAssetIds.value
          : this.linkedAssetIds,
      estimatedCost: data.estimatedCost.present
          ? data.estimatedCost.value
          : this.estimatedCost,
      estimatedTimeMinutes: data.estimatedTimeMinutes.present
          ? data.estimatedTimeMinutes.value
          : this.estimatedTimeMinutes,
      reminderEnabled: data.reminderEnabled.present
          ? data.reminderEnabled.value
          : this.reminderEnabled,
      reminderDaysBefore: data.reminderDaysBefore.present
          ? data.reminderDaysBefore.value
          : this.reminderDaysBefore,
      notes: data.notes.present ? data.notes.value : this.notes,
      isTemplate: data.isTemplate.present
          ? data.isTemplate.value
          : this.isTemplate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceTask(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('instructions: $instructions, ')
          ..write('category: $category, ')
          ..write('frequency: $frequency, ')
          ..write('customIntervalDays: $customIntervalDays, ')
          ..write('season: $season, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('lastCompletedDate: $lastCompletedDate, ')
          ..write('linkedAssetIds: $linkedAssetIds, ')
          ..write('estimatedCost: $estimatedCost, ')
          ..write('estimatedTimeMinutes: $estimatedTimeMinutes, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('reminderDaysBefore: $reminderDaysBefore, ')
          ..write('notes: $notes, ')
          ..write('isTemplate: $isTemplate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    propertyId,
    title,
    description,
    instructions,
    category,
    frequency,
    customIntervalDays,
    season,
    nextDueDate,
    lastCompletedDate,
    linkedAssetIds,
    estimatedCost,
    estimatedTimeMinutes,
    reminderEnabled,
    reminderDaysBefore,
    notes,
    isTemplate,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaintenanceTask &&
          other.id == this.id &&
          other.propertyId == this.propertyId &&
          other.title == this.title &&
          other.description == this.description &&
          other.instructions == this.instructions &&
          other.category == this.category &&
          other.frequency == this.frequency &&
          other.customIntervalDays == this.customIntervalDays &&
          other.season == this.season &&
          other.nextDueDate == this.nextDueDate &&
          other.lastCompletedDate == this.lastCompletedDate &&
          other.linkedAssetIds == this.linkedAssetIds &&
          other.estimatedCost == this.estimatedCost &&
          other.estimatedTimeMinutes == this.estimatedTimeMinutes &&
          other.reminderEnabled == this.reminderEnabled &&
          other.reminderDaysBefore == this.reminderDaysBefore &&
          other.notes == this.notes &&
          other.isTemplate == this.isTemplate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MaintenanceTasksCompanion extends UpdateCompanion<MaintenanceTask> {
  final Value<String> id;
  final Value<String> propertyId;
  final Value<String> title;
  final Value<String?> description;
  final Value<String?> instructions;
  final Value<String?> category;
  final Value<String> frequency;
  final Value<int?> customIntervalDays;
  final Value<String?> season;
  final Value<DateTime?> nextDueDate;
  final Value<DateTime?> lastCompletedDate;
  final Value<String> linkedAssetIds;
  final Value<double?> estimatedCost;
  final Value<int?> estimatedTimeMinutes;
  final Value<bool> reminderEnabled;
  final Value<int> reminderDaysBefore;
  final Value<String?> notes;
  final Value<bool> isTemplate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MaintenanceTasksCompanion({
    this.id = const Value.absent(),
    this.propertyId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.instructions = const Value.absent(),
    this.category = const Value.absent(),
    this.frequency = const Value.absent(),
    this.customIntervalDays = const Value.absent(),
    this.season = const Value.absent(),
    this.nextDueDate = const Value.absent(),
    this.lastCompletedDate = const Value.absent(),
    this.linkedAssetIds = const Value.absent(),
    this.estimatedCost = const Value.absent(),
    this.estimatedTimeMinutes = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.reminderDaysBefore = const Value.absent(),
    this.notes = const Value.absent(),
    this.isTemplate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MaintenanceTasksCompanion.insert({
    required String id,
    required String propertyId,
    required String title,
    this.description = const Value.absent(),
    this.instructions = const Value.absent(),
    this.category = const Value.absent(),
    required String frequency,
    this.customIntervalDays = const Value.absent(),
    this.season = const Value.absent(),
    this.nextDueDate = const Value.absent(),
    this.lastCompletedDate = const Value.absent(),
    this.linkedAssetIds = const Value.absent(),
    this.estimatedCost = const Value.absent(),
    this.estimatedTimeMinutes = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.reminderDaysBefore = const Value.absent(),
    this.notes = const Value.absent(),
    this.isTemplate = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       propertyId = Value(propertyId),
       title = Value(title),
       frequency = Value(frequency),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MaintenanceTask> custom({
    Expression<String>? id,
    Expression<String>? propertyId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? instructions,
    Expression<String>? category,
    Expression<String>? frequency,
    Expression<int>? customIntervalDays,
    Expression<String>? season,
    Expression<DateTime>? nextDueDate,
    Expression<DateTime>? lastCompletedDate,
    Expression<String>? linkedAssetIds,
    Expression<double>? estimatedCost,
    Expression<int>? estimatedTimeMinutes,
    Expression<bool>? reminderEnabled,
    Expression<int>? reminderDaysBefore,
    Expression<String>? notes,
    Expression<bool>? isTemplate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (propertyId != null) 'property_id': propertyId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (instructions != null) 'instructions': instructions,
      if (category != null) 'category': category,
      if (frequency != null) 'frequency': frequency,
      if (customIntervalDays != null)
        'custom_interval_days': customIntervalDays,
      if (season != null) 'season': season,
      if (nextDueDate != null) 'next_due_date': nextDueDate,
      if (lastCompletedDate != null) 'last_completed_date': lastCompletedDate,
      if (linkedAssetIds != null) 'linked_asset_ids': linkedAssetIds,
      if (estimatedCost != null) 'estimated_cost': estimatedCost,
      if (estimatedTimeMinutes != null)
        'estimated_time_minutes': estimatedTimeMinutes,
      if (reminderEnabled != null) 'reminder_enabled': reminderEnabled,
      if (reminderDaysBefore != null)
        'reminder_days_before': reminderDaysBefore,
      if (notes != null) 'notes': notes,
      if (isTemplate != null) 'is_template': isTemplate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MaintenanceTasksCompanion copyWith({
    Value<String>? id,
    Value<String>? propertyId,
    Value<String>? title,
    Value<String?>? description,
    Value<String?>? instructions,
    Value<String?>? category,
    Value<String>? frequency,
    Value<int?>? customIntervalDays,
    Value<String?>? season,
    Value<DateTime?>? nextDueDate,
    Value<DateTime?>? lastCompletedDate,
    Value<String>? linkedAssetIds,
    Value<double?>? estimatedCost,
    Value<int?>? estimatedTimeMinutes,
    Value<bool>? reminderEnabled,
    Value<int>? reminderDaysBefore,
    Value<String?>? notes,
    Value<bool>? isTemplate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MaintenanceTasksCompanion(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      title: title ?? this.title,
      description: description ?? this.description,
      instructions: instructions ?? this.instructions,
      category: category ?? this.category,
      frequency: frequency ?? this.frequency,
      customIntervalDays: customIntervalDays ?? this.customIntervalDays,
      season: season ?? this.season,
      nextDueDate: nextDueDate ?? this.nextDueDate,
      lastCompletedDate: lastCompletedDate ?? this.lastCompletedDate,
      linkedAssetIds: linkedAssetIds ?? this.linkedAssetIds,
      estimatedCost: estimatedCost ?? this.estimatedCost,
      estimatedTimeMinutes: estimatedTimeMinutes ?? this.estimatedTimeMinutes,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderDaysBefore: reminderDaysBefore ?? this.reminderDaysBefore,
      notes: notes ?? this.notes,
      isTemplate: isTemplate ?? this.isTemplate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (propertyId.present) {
      map['property_id'] = Variable<String>(propertyId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(instructions.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (customIntervalDays.present) {
      map['custom_interval_days'] = Variable<int>(customIntervalDays.value);
    }
    if (season.present) {
      map['season'] = Variable<String>(season.value);
    }
    if (nextDueDate.present) {
      map['next_due_date'] = Variable<DateTime>(nextDueDate.value);
    }
    if (lastCompletedDate.present) {
      map['last_completed_date'] = Variable<DateTime>(lastCompletedDate.value);
    }
    if (linkedAssetIds.present) {
      map['linked_asset_ids'] = Variable<String>(linkedAssetIds.value);
    }
    if (estimatedCost.present) {
      map['estimated_cost'] = Variable<double>(estimatedCost.value);
    }
    if (estimatedTimeMinutes.present) {
      map['estimated_time_minutes'] = Variable<int>(estimatedTimeMinutes.value);
    }
    if (reminderEnabled.present) {
      map['reminder_enabled'] = Variable<bool>(reminderEnabled.value);
    }
    if (reminderDaysBefore.present) {
      map['reminder_days_before'] = Variable<int>(reminderDaysBefore.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isTemplate.present) {
      map['is_template'] = Variable<bool>(isTemplate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceTasksCompanion(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('instructions: $instructions, ')
          ..write('category: $category, ')
          ..write('frequency: $frequency, ')
          ..write('customIntervalDays: $customIntervalDays, ')
          ..write('season: $season, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('lastCompletedDate: $lastCompletedDate, ')
          ..write('linkedAssetIds: $linkedAssetIds, ')
          ..write('estimatedCost: $estimatedCost, ')
          ..write('estimatedTimeMinutes: $estimatedTimeMinutes, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('reminderDaysBefore: $reminderDaysBefore, ')
          ..write('notes: $notes, ')
          ..write('isTemplate: $isTemplate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContractorsTable extends Contractors
    with TableInfo<$ContractorsTable, Contractor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContractorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _propertyIdMeta = const VerificationMeta(
    'propertyId',
  );
  @override
  late final GeneratedColumn<String> propertyId = GeneratedColumn<String>(
    'property_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES properties (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyNameMeta = const VerificationMeta(
    'companyName',
  );
  @override
  late final GeneratedColumn<String> companyName = GeneratedColumn<String>(
    'company_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tradeTypeMeta = const VerificationMeta(
    'tradeType',
  );
  @override
  late final GeneratedColumn<String> tradeType = GeneratedColumn<String>(
    'trade_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _websiteMeta = const VerificationMeta(
    'website',
  );
  @override
  late final GeneratedColumn<String> website = GeneratedColumn<String>(
    'website',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPreferredMeta = const VerificationMeta(
    'isPreferred',
  );
  @override
  late final GeneratedColumn<bool> isPreferred = GeneratedColumn<bool>(
    'is_preferred',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_preferred" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
    'rating',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    propertyId,
    name,
    companyName,
    tradeType,
    phone,
    email,
    address,
    website,
    notes,
    isPreferred,
    rating,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contractors';
  @override
  VerificationContext validateIntegrity(
    Insertable<Contractor> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('property_id')) {
      context.handle(
        _propertyIdMeta,
        propertyId.isAcceptableOrUnknown(data['property_id']!, _propertyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_propertyIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('company_name')) {
      context.handle(
        _companyNameMeta,
        companyName.isAcceptableOrUnknown(
          data['company_name']!,
          _companyNameMeta,
        ),
      );
    }
    if (data.containsKey('trade_type')) {
      context.handle(
        _tradeTypeMeta,
        tradeType.isAcceptableOrUnknown(data['trade_type']!, _tradeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_tradeTypeMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('website')) {
      context.handle(
        _websiteMeta,
        website.isAcceptableOrUnknown(data['website']!, _websiteMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_preferred')) {
      context.handle(
        _isPreferredMeta,
        isPreferred.isAcceptableOrUnknown(
          data['is_preferred']!,
          _isPreferredMeta,
        ),
      );
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contractor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contractor(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      propertyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}property_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      companyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_name'],
      ),
      tradeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trade_type'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      website: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}website'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isPreferred: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_preferred'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rating'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ContractorsTable createAlias(String alias) {
    return $ContractorsTable(attachedDatabase, alias);
  }
}

class Contractor extends DataClass implements Insertable<Contractor> {
  final String id;
  final String propertyId;
  final String name;
  final String? companyName;
  final String tradeType;
  final String? phone;
  final String? email;
  final String? address;
  final String? website;
  final String? notes;
  final bool isPreferred;
  final double? rating;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Contractor({
    required this.id,
    required this.propertyId,
    required this.name,
    this.companyName,
    required this.tradeType,
    this.phone,
    this.email,
    this.address,
    this.website,
    this.notes,
    required this.isPreferred,
    this.rating,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['property_id'] = Variable<String>(propertyId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || companyName != null) {
      map['company_name'] = Variable<String>(companyName);
    }
    map['trade_type'] = Variable<String>(tradeType);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || website != null) {
      map['website'] = Variable<String>(website);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_preferred'] = Variable<bool>(isPreferred);
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<double>(rating);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ContractorsCompanion toCompanion(bool nullToAbsent) {
    return ContractorsCompanion(
      id: Value(id),
      propertyId: Value(propertyId),
      name: Value(name),
      companyName: companyName == null && nullToAbsent
          ? const Value.absent()
          : Value(companyName),
      tradeType: Value(tradeType),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      website: website == null && nullToAbsent
          ? const Value.absent()
          : Value(website),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isPreferred: Value(isPreferred),
      rating: rating == null && nullToAbsent
          ? const Value.absent()
          : Value(rating),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Contractor.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contractor(
      id: serializer.fromJson<String>(json['id']),
      propertyId: serializer.fromJson<String>(json['propertyId']),
      name: serializer.fromJson<String>(json['name']),
      companyName: serializer.fromJson<String?>(json['companyName']),
      tradeType: serializer.fromJson<String>(json['tradeType']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      website: serializer.fromJson<String?>(json['website']),
      notes: serializer.fromJson<String?>(json['notes']),
      isPreferred: serializer.fromJson<bool>(json['isPreferred']),
      rating: serializer.fromJson<double?>(json['rating']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'propertyId': serializer.toJson<String>(propertyId),
      'name': serializer.toJson<String>(name),
      'companyName': serializer.toJson<String?>(companyName),
      'tradeType': serializer.toJson<String>(tradeType),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'website': serializer.toJson<String?>(website),
      'notes': serializer.toJson<String?>(notes),
      'isPreferred': serializer.toJson<bool>(isPreferred),
      'rating': serializer.toJson<double?>(rating),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Contractor copyWith({
    String? id,
    String? propertyId,
    String? name,
    Value<String?> companyName = const Value.absent(),
    String? tradeType,
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> website = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? isPreferred,
    Value<double?> rating = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Contractor(
    id: id ?? this.id,
    propertyId: propertyId ?? this.propertyId,
    name: name ?? this.name,
    companyName: companyName.present ? companyName.value : this.companyName,
    tradeType: tradeType ?? this.tradeType,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    address: address.present ? address.value : this.address,
    website: website.present ? website.value : this.website,
    notes: notes.present ? notes.value : this.notes,
    isPreferred: isPreferred ?? this.isPreferred,
    rating: rating.present ? rating.value : this.rating,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Contractor copyWithCompanion(ContractorsCompanion data) {
    return Contractor(
      id: data.id.present ? data.id.value : this.id,
      propertyId: data.propertyId.present
          ? data.propertyId.value
          : this.propertyId,
      name: data.name.present ? data.name.value : this.name,
      companyName: data.companyName.present
          ? data.companyName.value
          : this.companyName,
      tradeType: data.tradeType.present ? data.tradeType.value : this.tradeType,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      website: data.website.present ? data.website.value : this.website,
      notes: data.notes.present ? data.notes.value : this.notes,
      isPreferred: data.isPreferred.present
          ? data.isPreferred.value
          : this.isPreferred,
      rating: data.rating.present ? data.rating.value : this.rating,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Contractor(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('name: $name, ')
          ..write('companyName: $companyName, ')
          ..write('tradeType: $tradeType, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('website: $website, ')
          ..write('notes: $notes, ')
          ..write('isPreferred: $isPreferred, ')
          ..write('rating: $rating, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    propertyId,
    name,
    companyName,
    tradeType,
    phone,
    email,
    address,
    website,
    notes,
    isPreferred,
    rating,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contractor &&
          other.id == this.id &&
          other.propertyId == this.propertyId &&
          other.name == this.name &&
          other.companyName == this.companyName &&
          other.tradeType == this.tradeType &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.address == this.address &&
          other.website == this.website &&
          other.notes == this.notes &&
          other.isPreferred == this.isPreferred &&
          other.rating == this.rating &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ContractorsCompanion extends UpdateCompanion<Contractor> {
  final Value<String> id;
  final Value<String> propertyId;
  final Value<String> name;
  final Value<String?> companyName;
  final Value<String> tradeType;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> address;
  final Value<String?> website;
  final Value<String?> notes;
  final Value<bool> isPreferred;
  final Value<double?> rating;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ContractorsCompanion({
    this.id = const Value.absent(),
    this.propertyId = const Value.absent(),
    this.name = const Value.absent(),
    this.companyName = const Value.absent(),
    this.tradeType = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.website = const Value.absent(),
    this.notes = const Value.absent(),
    this.isPreferred = const Value.absent(),
    this.rating = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContractorsCompanion.insert({
    required String id,
    required String propertyId,
    required String name,
    this.companyName = const Value.absent(),
    required String tradeType,
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.website = const Value.absent(),
    this.notes = const Value.absent(),
    this.isPreferred = const Value.absent(),
    this.rating = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       propertyId = Value(propertyId),
       name = Value(name),
       tradeType = Value(tradeType),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Contractor> custom({
    Expression<String>? id,
    Expression<String>? propertyId,
    Expression<String>? name,
    Expression<String>? companyName,
    Expression<String>? tradeType,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? address,
    Expression<String>? website,
    Expression<String>? notes,
    Expression<bool>? isPreferred,
    Expression<double>? rating,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (propertyId != null) 'property_id': propertyId,
      if (name != null) 'name': name,
      if (companyName != null) 'company_name': companyName,
      if (tradeType != null) 'trade_type': tradeType,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (website != null) 'website': website,
      if (notes != null) 'notes': notes,
      if (isPreferred != null) 'is_preferred': isPreferred,
      if (rating != null) 'rating': rating,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContractorsCompanion copyWith({
    Value<String>? id,
    Value<String>? propertyId,
    Value<String>? name,
    Value<String?>? companyName,
    Value<String>? tradeType,
    Value<String?>? phone,
    Value<String?>? email,
    Value<String?>? address,
    Value<String?>? website,
    Value<String?>? notes,
    Value<bool>? isPreferred,
    Value<double?>? rating,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ContractorsCompanion(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      name: name ?? this.name,
      companyName: companyName ?? this.companyName,
      tradeType: tradeType ?? this.tradeType,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      website: website ?? this.website,
      notes: notes ?? this.notes,
      isPreferred: isPreferred ?? this.isPreferred,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (propertyId.present) {
      map['property_id'] = Variable<String>(propertyId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    if (tradeType.present) {
      map['trade_type'] = Variable<String>(tradeType.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (website.present) {
      map['website'] = Variable<String>(website.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isPreferred.present) {
      map['is_preferred'] = Variable<bool>(isPreferred.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContractorsCompanion(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('name: $name, ')
          ..write('companyName: $companyName, ')
          ..write('tradeType: $tradeType, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('website: $website, ')
          ..write('notes: $notes, ')
          ..write('isPreferred: $isPreferred, ')
          ..write('rating: $rating, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ServiceRecordsTable extends ServiceRecords
    with TableInfo<$ServiceRecordsTable, ServiceRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServiceRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _propertyIdMeta = const VerificationMeta(
    'propertyId',
  );
  @override
  late final GeneratedColumn<String> propertyId = GeneratedColumn<String>(
    'property_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES properties (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _assetIdsMeta = const VerificationMeta(
    'assetIds',
  );
  @override
  late final GeneratedColumn<String> assetIds = GeneratedColumn<String>(
    'asset_ids',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
    'task_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES maintenance_tasks (id)',
    ),
  );
  static const VerificationMeta _contractorIdMeta = const VerificationMeta(
    'contractorId',
  );
  @override
  late final GeneratedColumn<String> contractorId = GeneratedColumn<String>(
    'contractor_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES contractors (id)',
    ),
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<double> cost = GeneratedColumn<double>(
    'cost',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _attachmentPathsMeta = const VerificationMeta(
    'attachmentPaths',
  );
  @override
  late final GeneratedColumn<String> attachmentPaths = GeneratedColumn<String>(
    'attachment_paths',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    propertyId,
    date,
    title,
    description,
    assetIds,
    taskId,
    contractorId,
    cost,
    notes,
    attachmentPaths,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'service_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<ServiceRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('property_id')) {
      context.handle(
        _propertyIdMeta,
        propertyId.isAcceptableOrUnknown(data['property_id']!, _propertyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_propertyIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('asset_ids')) {
      context.handle(
        _assetIdsMeta,
        assetIds.isAcceptableOrUnknown(data['asset_ids']!, _assetIdsMeta),
      );
    }
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    }
    if (data.containsKey('contractor_id')) {
      context.handle(
        _contractorIdMeta,
        contractorId.isAcceptableOrUnknown(
          data['contractor_id']!,
          _contractorIdMeta,
        ),
      );
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('attachment_paths')) {
      context.handle(
        _attachmentPathsMeta,
        attachmentPaths.isAcceptableOrUnknown(
          data['attachment_paths']!,
          _attachmentPathsMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      propertyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}property_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      assetIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_ids'],
      )!,
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_id'],
      ),
      contractorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contractor_id'],
      ),
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      attachmentPaths: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attachment_paths'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ServiceRecordsTable createAlias(String alias) {
    return $ServiceRecordsTable(attachedDatabase, alias);
  }
}

class ServiceRecord extends DataClass implements Insertable<ServiceRecord> {
  final String id;
  final String propertyId;
  final DateTime date;
  final String title;
  final String? description;
  final String assetIds;
  final String? taskId;
  final String? contractorId;
  final double? cost;
  final String? notes;
  final String attachmentPaths;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ServiceRecord({
    required this.id,
    required this.propertyId,
    required this.date,
    required this.title,
    this.description,
    required this.assetIds,
    this.taskId,
    this.contractorId,
    this.cost,
    this.notes,
    required this.attachmentPaths,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['property_id'] = Variable<String>(propertyId);
    map['date'] = Variable<DateTime>(date);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['asset_ids'] = Variable<String>(assetIds);
    if (!nullToAbsent || taskId != null) {
      map['task_id'] = Variable<String>(taskId);
    }
    if (!nullToAbsent || contractorId != null) {
      map['contractor_id'] = Variable<String>(contractorId);
    }
    if (!nullToAbsent || cost != null) {
      map['cost'] = Variable<double>(cost);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['attachment_paths'] = Variable<String>(attachmentPaths);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ServiceRecordsCompanion toCompanion(bool nullToAbsent) {
    return ServiceRecordsCompanion(
      id: Value(id),
      propertyId: Value(propertyId),
      date: Value(date),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      assetIds: Value(assetIds),
      taskId: taskId == null && nullToAbsent
          ? const Value.absent()
          : Value(taskId),
      contractorId: contractorId == null && nullToAbsent
          ? const Value.absent()
          : Value(contractorId),
      cost: cost == null && nullToAbsent ? const Value.absent() : Value(cost),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      attachmentPaths: Value(attachmentPaths),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ServiceRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServiceRecord(
      id: serializer.fromJson<String>(json['id']),
      propertyId: serializer.fromJson<String>(json['propertyId']),
      date: serializer.fromJson<DateTime>(json['date']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      assetIds: serializer.fromJson<String>(json['assetIds']),
      taskId: serializer.fromJson<String?>(json['taskId']),
      contractorId: serializer.fromJson<String?>(json['contractorId']),
      cost: serializer.fromJson<double?>(json['cost']),
      notes: serializer.fromJson<String?>(json['notes']),
      attachmentPaths: serializer.fromJson<String>(json['attachmentPaths']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'propertyId': serializer.toJson<String>(propertyId),
      'date': serializer.toJson<DateTime>(date),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'assetIds': serializer.toJson<String>(assetIds),
      'taskId': serializer.toJson<String?>(taskId),
      'contractorId': serializer.toJson<String?>(contractorId),
      'cost': serializer.toJson<double?>(cost),
      'notes': serializer.toJson<String?>(notes),
      'attachmentPaths': serializer.toJson<String>(attachmentPaths),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ServiceRecord copyWith({
    String? id,
    String? propertyId,
    DateTime? date,
    String? title,
    Value<String?> description = const Value.absent(),
    String? assetIds,
    Value<String?> taskId = const Value.absent(),
    Value<String?> contractorId = const Value.absent(),
    Value<double?> cost = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    String? attachmentPaths,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ServiceRecord(
    id: id ?? this.id,
    propertyId: propertyId ?? this.propertyId,
    date: date ?? this.date,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    assetIds: assetIds ?? this.assetIds,
    taskId: taskId.present ? taskId.value : this.taskId,
    contractorId: contractorId.present ? contractorId.value : this.contractorId,
    cost: cost.present ? cost.value : this.cost,
    notes: notes.present ? notes.value : this.notes,
    attachmentPaths: attachmentPaths ?? this.attachmentPaths,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ServiceRecord copyWithCompanion(ServiceRecordsCompanion data) {
    return ServiceRecord(
      id: data.id.present ? data.id.value : this.id,
      propertyId: data.propertyId.present
          ? data.propertyId.value
          : this.propertyId,
      date: data.date.present ? data.date.value : this.date,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      assetIds: data.assetIds.present ? data.assetIds.value : this.assetIds,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      contractorId: data.contractorId.present
          ? data.contractorId.value
          : this.contractorId,
      cost: data.cost.present ? data.cost.value : this.cost,
      notes: data.notes.present ? data.notes.value : this.notes,
      attachmentPaths: data.attachmentPaths.present
          ? data.attachmentPaths.value
          : this.attachmentPaths,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServiceRecord(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('date: $date, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('assetIds: $assetIds, ')
          ..write('taskId: $taskId, ')
          ..write('contractorId: $contractorId, ')
          ..write('cost: $cost, ')
          ..write('notes: $notes, ')
          ..write('attachmentPaths: $attachmentPaths, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    propertyId,
    date,
    title,
    description,
    assetIds,
    taskId,
    contractorId,
    cost,
    notes,
    attachmentPaths,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceRecord &&
          other.id == this.id &&
          other.propertyId == this.propertyId &&
          other.date == this.date &&
          other.title == this.title &&
          other.description == this.description &&
          other.assetIds == this.assetIds &&
          other.taskId == this.taskId &&
          other.contractorId == this.contractorId &&
          other.cost == this.cost &&
          other.notes == this.notes &&
          other.attachmentPaths == this.attachmentPaths &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ServiceRecordsCompanion extends UpdateCompanion<ServiceRecord> {
  final Value<String> id;
  final Value<String> propertyId;
  final Value<DateTime> date;
  final Value<String> title;
  final Value<String?> description;
  final Value<String> assetIds;
  final Value<String?> taskId;
  final Value<String?> contractorId;
  final Value<double?> cost;
  final Value<String?> notes;
  final Value<String> attachmentPaths;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ServiceRecordsCompanion({
    this.id = const Value.absent(),
    this.propertyId = const Value.absent(),
    this.date = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.assetIds = const Value.absent(),
    this.taskId = const Value.absent(),
    this.contractorId = const Value.absent(),
    this.cost = const Value.absent(),
    this.notes = const Value.absent(),
    this.attachmentPaths = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServiceRecordsCompanion.insert({
    required String id,
    required String propertyId,
    required DateTime date,
    required String title,
    this.description = const Value.absent(),
    this.assetIds = const Value.absent(),
    this.taskId = const Value.absent(),
    this.contractorId = const Value.absent(),
    this.cost = const Value.absent(),
    this.notes = const Value.absent(),
    this.attachmentPaths = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       propertyId = Value(propertyId),
       date = Value(date),
       title = Value(title),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ServiceRecord> custom({
    Expression<String>? id,
    Expression<String>? propertyId,
    Expression<DateTime>? date,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? assetIds,
    Expression<String>? taskId,
    Expression<String>? contractorId,
    Expression<double>? cost,
    Expression<String>? notes,
    Expression<String>? attachmentPaths,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (propertyId != null) 'property_id': propertyId,
      if (date != null) 'date': date,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (assetIds != null) 'asset_ids': assetIds,
      if (taskId != null) 'task_id': taskId,
      if (contractorId != null) 'contractor_id': contractorId,
      if (cost != null) 'cost': cost,
      if (notes != null) 'notes': notes,
      if (attachmentPaths != null) 'attachment_paths': attachmentPaths,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServiceRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? propertyId,
    Value<DateTime>? date,
    Value<String>? title,
    Value<String?>? description,
    Value<String>? assetIds,
    Value<String?>? taskId,
    Value<String?>? contractorId,
    Value<double?>? cost,
    Value<String?>? notes,
    Value<String>? attachmentPaths,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ServiceRecordsCompanion(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      date: date ?? this.date,
      title: title ?? this.title,
      description: description ?? this.description,
      assetIds: assetIds ?? this.assetIds,
      taskId: taskId ?? this.taskId,
      contractorId: contractorId ?? this.contractorId,
      cost: cost ?? this.cost,
      notes: notes ?? this.notes,
      attachmentPaths: attachmentPaths ?? this.attachmentPaths,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (propertyId.present) {
      map['property_id'] = Variable<String>(propertyId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (assetIds.present) {
      map['asset_ids'] = Variable<String>(assetIds.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (contractorId.present) {
      map['contractor_id'] = Variable<String>(contractorId.value);
    }
    if (cost.present) {
      map['cost'] = Variable<double>(cost.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (attachmentPaths.present) {
      map['attachment_paths'] = Variable<String>(attachmentPaths.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiceRecordsCompanion(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('date: $date, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('assetIds: $assetIds, ')
          ..write('taskId: $taskId, ')
          ..write('contractorId: $contractorId, ')
          ..write('cost: $cost, ')
          ..write('notes: $notes, ')
          ..write('attachmentPaths: $attachmentPaths, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DocumentsTable extends Documents
    with TableInfo<$DocumentsTable, Document> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _propertyIdMeta = const VerificationMeta(
    'propertyId',
  );
  @override
  late final GeneratedColumn<String> propertyId = GeneratedColumn<String>(
    'property_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES properties (id)',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _linkedAssetIdMeta = const VerificationMeta(
    'linkedAssetId',
  );
  @override
  late final GeneratedColumn<String> linkedAssetId = GeneratedColumn<String>(
    'linked_asset_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES assets (id)',
    ),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expirationDateMeta = const VerificationMeta(
    'expirationDate',
  );
  @override
  late final GeneratedColumn<DateTime> expirationDate =
      GeneratedColumn<DateTime>(
        'expiration_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _dateAddedMeta = const VerificationMeta(
    'dateAdded',
  );
  @override
  late final GeneratedColumn<DateTime> dateAdded = GeneratedColumn<DateTime>(
    'date_added',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    propertyId,
    title,
    category,
    filePath,
    linkedAssetId,
    notes,
    expirationDate,
    dateAdded,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<Document> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('property_id')) {
      context.handle(
        _propertyIdMeta,
        propertyId.isAcceptableOrUnknown(data['property_id']!, _propertyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_propertyIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('linked_asset_id')) {
      context.handle(
        _linkedAssetIdMeta,
        linkedAssetId.isAcceptableOrUnknown(
          data['linked_asset_id']!,
          _linkedAssetIdMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('expiration_date')) {
      context.handle(
        _expirationDateMeta,
        expirationDate.isAcceptableOrUnknown(
          data['expiration_date']!,
          _expirationDateMeta,
        ),
      );
    }
    if (data.containsKey('date_added')) {
      context.handle(
        _dateAddedMeta,
        dateAdded.isAcceptableOrUnknown(data['date_added']!, _dateAddedMeta),
      );
    } else if (isInserting) {
      context.missing(_dateAddedMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Document map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Document(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      propertyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}property_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      linkedAssetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}linked_asset_id'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      expirationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expiration_date'],
      ),
      dateAdded: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_added'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DocumentsTable createAlias(String alias) {
    return $DocumentsTable(attachedDatabase, alias);
  }
}

class Document extends DataClass implements Insertable<Document> {
  final String id;
  final String propertyId;
  final String title;
  final String category;
  final String filePath;
  final String? linkedAssetId;
  final String? notes;
  final DateTime? expirationDate;
  final DateTime dateAdded;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Document({
    required this.id,
    required this.propertyId,
    required this.title,
    required this.category,
    required this.filePath,
    this.linkedAssetId,
    this.notes,
    this.expirationDate,
    required this.dateAdded,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['property_id'] = Variable<String>(propertyId);
    map['title'] = Variable<String>(title);
    map['category'] = Variable<String>(category);
    map['file_path'] = Variable<String>(filePath);
    if (!nullToAbsent || linkedAssetId != null) {
      map['linked_asset_id'] = Variable<String>(linkedAssetId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || expirationDate != null) {
      map['expiration_date'] = Variable<DateTime>(expirationDate);
    }
    map['date_added'] = Variable<DateTime>(dateAdded);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      id: Value(id),
      propertyId: Value(propertyId),
      title: Value(title),
      category: Value(category),
      filePath: Value(filePath),
      linkedAssetId: linkedAssetId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedAssetId),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      expirationDate: expirationDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expirationDate),
      dateAdded: Value(dateAdded),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Document.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Document(
      id: serializer.fromJson<String>(json['id']),
      propertyId: serializer.fromJson<String>(json['propertyId']),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<String>(json['category']),
      filePath: serializer.fromJson<String>(json['filePath']),
      linkedAssetId: serializer.fromJson<String?>(json['linkedAssetId']),
      notes: serializer.fromJson<String?>(json['notes']),
      expirationDate: serializer.fromJson<DateTime?>(json['expirationDate']),
      dateAdded: serializer.fromJson<DateTime>(json['dateAdded']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'propertyId': serializer.toJson<String>(propertyId),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<String>(category),
      'filePath': serializer.toJson<String>(filePath),
      'linkedAssetId': serializer.toJson<String?>(linkedAssetId),
      'notes': serializer.toJson<String?>(notes),
      'expirationDate': serializer.toJson<DateTime?>(expirationDate),
      'dateAdded': serializer.toJson<DateTime>(dateAdded),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Document copyWith({
    String? id,
    String? propertyId,
    String? title,
    String? category,
    String? filePath,
    Value<String?> linkedAssetId = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<DateTime?> expirationDate = const Value.absent(),
    DateTime? dateAdded,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Document(
    id: id ?? this.id,
    propertyId: propertyId ?? this.propertyId,
    title: title ?? this.title,
    category: category ?? this.category,
    filePath: filePath ?? this.filePath,
    linkedAssetId: linkedAssetId.present
        ? linkedAssetId.value
        : this.linkedAssetId,
    notes: notes.present ? notes.value : this.notes,
    expirationDate: expirationDate.present
        ? expirationDate.value
        : this.expirationDate,
    dateAdded: dateAdded ?? this.dateAdded,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Document copyWithCompanion(DocumentsCompanion data) {
    return Document(
      id: data.id.present ? data.id.value : this.id,
      propertyId: data.propertyId.present
          ? data.propertyId.value
          : this.propertyId,
      title: data.title.present ? data.title.value : this.title,
      category: data.category.present ? data.category.value : this.category,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      linkedAssetId: data.linkedAssetId.present
          ? data.linkedAssetId.value
          : this.linkedAssetId,
      notes: data.notes.present ? data.notes.value : this.notes,
      expirationDate: data.expirationDate.present
          ? data.expirationDate.value
          : this.expirationDate,
      dateAdded: data.dateAdded.present ? data.dateAdded.value : this.dateAdded,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Document(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('filePath: $filePath, ')
          ..write('linkedAssetId: $linkedAssetId, ')
          ..write('notes: $notes, ')
          ..write('expirationDate: $expirationDate, ')
          ..write('dateAdded: $dateAdded, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    propertyId,
    title,
    category,
    filePath,
    linkedAssetId,
    notes,
    expirationDate,
    dateAdded,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Document &&
          other.id == this.id &&
          other.propertyId == this.propertyId &&
          other.title == this.title &&
          other.category == this.category &&
          other.filePath == this.filePath &&
          other.linkedAssetId == this.linkedAssetId &&
          other.notes == this.notes &&
          other.expirationDate == this.expirationDate &&
          other.dateAdded == this.dateAdded &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DocumentsCompanion extends UpdateCompanion<Document> {
  final Value<String> id;
  final Value<String> propertyId;
  final Value<String> title;
  final Value<String> category;
  final Value<String> filePath;
  final Value<String?> linkedAssetId;
  final Value<String?> notes;
  final Value<DateTime?> expirationDate;
  final Value<DateTime> dateAdded;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DocumentsCompanion({
    this.id = const Value.absent(),
    this.propertyId = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.filePath = const Value.absent(),
    this.linkedAssetId = const Value.absent(),
    this.notes = const Value.absent(),
    this.expirationDate = const Value.absent(),
    this.dateAdded = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentsCompanion.insert({
    required String id,
    required String propertyId,
    required String title,
    required String category,
    required String filePath,
    this.linkedAssetId = const Value.absent(),
    this.notes = const Value.absent(),
    this.expirationDate = const Value.absent(),
    required DateTime dateAdded,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       propertyId = Value(propertyId),
       title = Value(title),
       category = Value(category),
       filePath = Value(filePath),
       dateAdded = Value(dateAdded),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Document> custom({
    Expression<String>? id,
    Expression<String>? propertyId,
    Expression<String>? title,
    Expression<String>? category,
    Expression<String>? filePath,
    Expression<String>? linkedAssetId,
    Expression<String>? notes,
    Expression<DateTime>? expirationDate,
    Expression<DateTime>? dateAdded,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (propertyId != null) 'property_id': propertyId,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (filePath != null) 'file_path': filePath,
      if (linkedAssetId != null) 'linked_asset_id': linkedAssetId,
      if (notes != null) 'notes': notes,
      if (expirationDate != null) 'expiration_date': expirationDate,
      if (dateAdded != null) 'date_added': dateAdded,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentsCompanion copyWith({
    Value<String>? id,
    Value<String>? propertyId,
    Value<String>? title,
    Value<String>? category,
    Value<String>? filePath,
    Value<String?>? linkedAssetId,
    Value<String?>? notes,
    Value<DateTime?>? expirationDate,
    Value<DateTime>? dateAdded,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return DocumentsCompanion(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      title: title ?? this.title,
      category: category ?? this.category,
      filePath: filePath ?? this.filePath,
      linkedAssetId: linkedAssetId ?? this.linkedAssetId,
      notes: notes ?? this.notes,
      expirationDate: expirationDate ?? this.expirationDate,
      dateAdded: dateAdded ?? this.dateAdded,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (propertyId.present) {
      map['property_id'] = Variable<String>(propertyId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (linkedAssetId.present) {
      map['linked_asset_id'] = Variable<String>(linkedAssetId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (expirationDate.present) {
      map['expiration_date'] = Variable<DateTime>(expirationDate.value);
    }
    if (dateAdded.present) {
      map['date_added'] = Variable<DateTime>(dateAdded.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('filePath: $filePath, ')
          ..write('linkedAssetId: $linkedAssetId, ')
          ..write('notes: $notes, ')
          ..write('expirationDate: $expirationDate, ')
          ..write('dateAdded: $dateAdded, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTableTable extends AppSettingsTable
    with TableInfo<$AppSettingsTableTable, AppSettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _themeColorMeta = const VerificationMeta(
    'themeColor',
  );
  @override
  late final GeneratedColumn<String> themeColor = GeneratedColumn<String>(
    'theme_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('green'),
  );
  static const VerificationMeta _measurementUnitMeta = const VerificationMeta(
    'measurementUnit',
  );
  @override
  late final GeneratedColumn<String> measurementUnit = GeneratedColumn<String>(
    'measurement_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('imperial'),
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('USD'),
  );
  static const VerificationMeta _currencySymbolMeta = const VerificationMeta(
    'currencySymbol',
  );
  @override
  late final GeneratedColumn<String> currencySymbol = GeneratedColumn<String>(
    'currency_symbol',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('\$'),
  );
  static const VerificationMeta _notificationsEnabledMeta =
      const VerificationMeta('notificationsEnabled');
  @override
  late final GeneratedColumn<bool> notificationsEnabled = GeneratedColumn<bool>(
    'notifications_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notifications_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _defaultReminderDaysMeta =
      const VerificationMeta('defaultReminderDays');
  @override
  late final GeneratedColumn<int> defaultReminderDays = GeneratedColumn<int>(
    'default_reminder_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _showCompletedTasksMeta =
      const VerificationMeta('showCompletedTasks');
  @override
  late final GeneratedColumn<bool> showCompletedTasks = GeneratedColumn<bool>(
    'show_completed_tasks',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_completed_tasks" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _currentPropertyIdMeta = const VerificationMeta(
    'currentPropertyId',
  );
  @override
  late final GeneratedColumn<String> currentPropertyId =
      GeneratedColumn<String>(
        'current_property_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _hasCompletedOnboardingMeta =
      const VerificationMeta('hasCompletedOnboarding');
  @override
  late final GeneratedColumn<bool> hasCompletedOnboarding =
      GeneratedColumn<bool>(
        'has_completed_onboarding',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("has_completed_onboarding" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _lastBackupDateMeta = const VerificationMeta(
    'lastBackupDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastBackupDate =
      GeneratedColumn<DateTime>(
        'last_backup_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    themeMode,
    themeColor,
    measurementUnit,
    currency,
    currencySymbol,
    notificationsEnabled,
    defaultReminderDays,
    showCompletedTasks,
    currentPropertyId,
    hasCompletedOnboarding,
    lastBackupDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSettingsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('theme_color')) {
      context.handle(
        _themeColorMeta,
        themeColor.isAcceptableOrUnknown(data['theme_color']!, _themeColorMeta),
      );
    }
    if (data.containsKey('measurement_unit')) {
      context.handle(
        _measurementUnitMeta,
        measurementUnit.isAcceptableOrUnknown(
          data['measurement_unit']!,
          _measurementUnitMeta,
        ),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('currency_symbol')) {
      context.handle(
        _currencySymbolMeta,
        currencySymbol.isAcceptableOrUnknown(
          data['currency_symbol']!,
          _currencySymbolMeta,
        ),
      );
    }
    if (data.containsKey('notifications_enabled')) {
      context.handle(
        _notificationsEnabledMeta,
        notificationsEnabled.isAcceptableOrUnknown(
          data['notifications_enabled']!,
          _notificationsEnabledMeta,
        ),
      );
    }
    if (data.containsKey('default_reminder_days')) {
      context.handle(
        _defaultReminderDaysMeta,
        defaultReminderDays.isAcceptableOrUnknown(
          data['default_reminder_days']!,
          _defaultReminderDaysMeta,
        ),
      );
    }
    if (data.containsKey('show_completed_tasks')) {
      context.handle(
        _showCompletedTasksMeta,
        showCompletedTasks.isAcceptableOrUnknown(
          data['show_completed_tasks']!,
          _showCompletedTasksMeta,
        ),
      );
    }
    if (data.containsKey('current_property_id')) {
      context.handle(
        _currentPropertyIdMeta,
        currentPropertyId.isAcceptableOrUnknown(
          data['current_property_id']!,
          _currentPropertyIdMeta,
        ),
      );
    }
    if (data.containsKey('has_completed_onboarding')) {
      context.handle(
        _hasCompletedOnboardingMeta,
        hasCompletedOnboarding.isAcceptableOrUnknown(
          data['has_completed_onboarding']!,
          _hasCompletedOnboardingMeta,
        ),
      );
    }
    if (data.containsKey('last_backup_date')) {
      context.handle(
        _lastBackupDateMeta,
        lastBackupDate.isAcceptableOrUnknown(
          data['last_backup_date']!,
          _lastBackupDateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSettingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      themeColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_color'],
      )!,
      measurementUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}measurement_unit'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      currencySymbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_symbol'],
      )!,
      notificationsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notifications_enabled'],
      )!,
      defaultReminderDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_reminder_days'],
      )!,
      showCompletedTasks: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_completed_tasks'],
      )!,
      currentPropertyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_property_id'],
      ),
      hasCompletedOnboarding: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_completed_onboarding'],
      )!,
      lastBackupDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_backup_date'],
      ),
    );
  }

  @override
  $AppSettingsTableTable createAlias(String alias) {
    return $AppSettingsTableTable(attachedDatabase, alias);
  }
}

class AppSettingsTableData extends DataClass
    implements Insertable<AppSettingsTableData> {
  final int id;
  final String themeMode;
  final String themeColor;
  final String measurementUnit;
  final String currency;
  final String currencySymbol;
  final bool notificationsEnabled;
  final int defaultReminderDays;
  final bool showCompletedTasks;
  final String? currentPropertyId;
  final bool hasCompletedOnboarding;
  final DateTime? lastBackupDate;
  const AppSettingsTableData({
    required this.id,
    required this.themeMode,
    required this.themeColor,
    required this.measurementUnit,
    required this.currency,
    required this.currencySymbol,
    required this.notificationsEnabled,
    required this.defaultReminderDays,
    required this.showCompletedTasks,
    this.currentPropertyId,
    required this.hasCompletedOnboarding,
    this.lastBackupDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['theme_mode'] = Variable<String>(themeMode);
    map['theme_color'] = Variable<String>(themeColor);
    map['measurement_unit'] = Variable<String>(measurementUnit);
    map['currency'] = Variable<String>(currency);
    map['currency_symbol'] = Variable<String>(currencySymbol);
    map['notifications_enabled'] = Variable<bool>(notificationsEnabled);
    map['default_reminder_days'] = Variable<int>(defaultReminderDays);
    map['show_completed_tasks'] = Variable<bool>(showCompletedTasks);
    if (!nullToAbsent || currentPropertyId != null) {
      map['current_property_id'] = Variable<String>(currentPropertyId);
    }
    map['has_completed_onboarding'] = Variable<bool>(hasCompletedOnboarding);
    if (!nullToAbsent || lastBackupDate != null) {
      map['last_backup_date'] = Variable<DateTime>(lastBackupDate);
    }
    return map;
  }

  AppSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsTableCompanion(
      id: Value(id),
      themeMode: Value(themeMode),
      themeColor: Value(themeColor),
      measurementUnit: Value(measurementUnit),
      currency: Value(currency),
      currencySymbol: Value(currencySymbol),
      notificationsEnabled: Value(notificationsEnabled),
      defaultReminderDays: Value(defaultReminderDays),
      showCompletedTasks: Value(showCompletedTasks),
      currentPropertyId: currentPropertyId == null && nullToAbsent
          ? const Value.absent()
          : Value(currentPropertyId),
      hasCompletedOnboarding: Value(hasCompletedOnboarding),
      lastBackupDate: lastBackupDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastBackupDate),
    );
  }

  factory AppSettingsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingsTableData(
      id: serializer.fromJson<int>(json['id']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      themeColor: serializer.fromJson<String>(json['themeColor']),
      measurementUnit: serializer.fromJson<String>(json['measurementUnit']),
      currency: serializer.fromJson<String>(json['currency']),
      currencySymbol: serializer.fromJson<String>(json['currencySymbol']),
      notificationsEnabled: serializer.fromJson<bool>(
        json['notificationsEnabled'],
      ),
      defaultReminderDays: serializer.fromJson<int>(
        json['defaultReminderDays'],
      ),
      showCompletedTasks: serializer.fromJson<bool>(json['showCompletedTasks']),
      currentPropertyId: serializer.fromJson<String?>(
        json['currentPropertyId'],
      ),
      hasCompletedOnboarding: serializer.fromJson<bool>(
        json['hasCompletedOnboarding'],
      ),
      lastBackupDate: serializer.fromJson<DateTime?>(json['lastBackupDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'themeMode': serializer.toJson<String>(themeMode),
      'themeColor': serializer.toJson<String>(themeColor),
      'measurementUnit': serializer.toJson<String>(measurementUnit),
      'currency': serializer.toJson<String>(currency),
      'currencySymbol': serializer.toJson<String>(currencySymbol),
      'notificationsEnabled': serializer.toJson<bool>(notificationsEnabled),
      'defaultReminderDays': serializer.toJson<int>(defaultReminderDays),
      'showCompletedTasks': serializer.toJson<bool>(showCompletedTasks),
      'currentPropertyId': serializer.toJson<String?>(currentPropertyId),
      'hasCompletedOnboarding': serializer.toJson<bool>(hasCompletedOnboarding),
      'lastBackupDate': serializer.toJson<DateTime?>(lastBackupDate),
    };
  }

  AppSettingsTableData copyWith({
    int? id,
    String? themeMode,
    String? themeColor,
    String? measurementUnit,
    String? currency,
    String? currencySymbol,
    bool? notificationsEnabled,
    int? defaultReminderDays,
    bool? showCompletedTasks,
    Value<String?> currentPropertyId = const Value.absent(),
    bool? hasCompletedOnboarding,
    Value<DateTime?> lastBackupDate = const Value.absent(),
  }) => AppSettingsTableData(
    id: id ?? this.id,
    themeMode: themeMode ?? this.themeMode,
    themeColor: themeColor ?? this.themeColor,
    measurementUnit: measurementUnit ?? this.measurementUnit,
    currency: currency ?? this.currency,
    currencySymbol: currencySymbol ?? this.currencySymbol,
    notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    defaultReminderDays: defaultReminderDays ?? this.defaultReminderDays,
    showCompletedTasks: showCompletedTasks ?? this.showCompletedTasks,
    currentPropertyId: currentPropertyId.present
        ? currentPropertyId.value
        : this.currentPropertyId,
    hasCompletedOnboarding:
        hasCompletedOnboarding ?? this.hasCompletedOnboarding,
    lastBackupDate: lastBackupDate.present
        ? lastBackupDate.value
        : this.lastBackupDate,
  );
  AppSettingsTableData copyWithCompanion(AppSettingsTableCompanion data) {
    return AppSettingsTableData(
      id: data.id.present ? data.id.value : this.id,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      themeColor: data.themeColor.present
          ? data.themeColor.value
          : this.themeColor,
      measurementUnit: data.measurementUnit.present
          ? data.measurementUnit.value
          : this.measurementUnit,
      currency: data.currency.present ? data.currency.value : this.currency,
      currencySymbol: data.currencySymbol.present
          ? data.currencySymbol.value
          : this.currencySymbol,
      notificationsEnabled: data.notificationsEnabled.present
          ? data.notificationsEnabled.value
          : this.notificationsEnabled,
      defaultReminderDays: data.defaultReminderDays.present
          ? data.defaultReminderDays.value
          : this.defaultReminderDays,
      showCompletedTasks: data.showCompletedTasks.present
          ? data.showCompletedTasks.value
          : this.showCompletedTasks,
      currentPropertyId: data.currentPropertyId.present
          ? data.currentPropertyId.value
          : this.currentPropertyId,
      hasCompletedOnboarding: data.hasCompletedOnboarding.present
          ? data.hasCompletedOnboarding.value
          : this.hasCompletedOnboarding,
      lastBackupDate: data.lastBackupDate.present
          ? data.lastBackupDate.value
          : this.lastBackupDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsTableData(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('themeColor: $themeColor, ')
          ..write('measurementUnit: $measurementUnit, ')
          ..write('currency: $currency, ')
          ..write('currencySymbol: $currencySymbol, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('defaultReminderDays: $defaultReminderDays, ')
          ..write('showCompletedTasks: $showCompletedTasks, ')
          ..write('currentPropertyId: $currentPropertyId, ')
          ..write('hasCompletedOnboarding: $hasCompletedOnboarding, ')
          ..write('lastBackupDate: $lastBackupDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    themeMode,
    themeColor,
    measurementUnit,
    currency,
    currencySymbol,
    notificationsEnabled,
    defaultReminderDays,
    showCompletedTasks,
    currentPropertyId,
    hasCompletedOnboarding,
    lastBackupDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingsTableData &&
          other.id == this.id &&
          other.themeMode == this.themeMode &&
          other.themeColor == this.themeColor &&
          other.measurementUnit == this.measurementUnit &&
          other.currency == this.currency &&
          other.currencySymbol == this.currencySymbol &&
          other.notificationsEnabled == this.notificationsEnabled &&
          other.defaultReminderDays == this.defaultReminderDays &&
          other.showCompletedTasks == this.showCompletedTasks &&
          other.currentPropertyId == this.currentPropertyId &&
          other.hasCompletedOnboarding == this.hasCompletedOnboarding &&
          other.lastBackupDate == this.lastBackupDate);
}

class AppSettingsTableCompanion extends UpdateCompanion<AppSettingsTableData> {
  final Value<int> id;
  final Value<String> themeMode;
  final Value<String> themeColor;
  final Value<String> measurementUnit;
  final Value<String> currency;
  final Value<String> currencySymbol;
  final Value<bool> notificationsEnabled;
  final Value<int> defaultReminderDays;
  final Value<bool> showCompletedTasks;
  final Value<String?> currentPropertyId;
  final Value<bool> hasCompletedOnboarding;
  final Value<DateTime?> lastBackupDate;
  const AppSettingsTableCompanion({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.themeColor = const Value.absent(),
    this.measurementUnit = const Value.absent(),
    this.currency = const Value.absent(),
    this.currencySymbol = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.defaultReminderDays = const Value.absent(),
    this.showCompletedTasks = const Value.absent(),
    this.currentPropertyId = const Value.absent(),
    this.hasCompletedOnboarding = const Value.absent(),
    this.lastBackupDate = const Value.absent(),
  });
  AppSettingsTableCompanion.insert({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.themeColor = const Value.absent(),
    this.measurementUnit = const Value.absent(),
    this.currency = const Value.absent(),
    this.currencySymbol = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.defaultReminderDays = const Value.absent(),
    this.showCompletedTasks = const Value.absent(),
    this.currentPropertyId = const Value.absent(),
    this.hasCompletedOnboarding = const Value.absent(),
    this.lastBackupDate = const Value.absent(),
  });
  static Insertable<AppSettingsTableData> custom({
    Expression<int>? id,
    Expression<String>? themeMode,
    Expression<String>? themeColor,
    Expression<String>? measurementUnit,
    Expression<String>? currency,
    Expression<String>? currencySymbol,
    Expression<bool>? notificationsEnabled,
    Expression<int>? defaultReminderDays,
    Expression<bool>? showCompletedTasks,
    Expression<String>? currentPropertyId,
    Expression<bool>? hasCompletedOnboarding,
    Expression<DateTime>? lastBackupDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (themeMode != null) 'theme_mode': themeMode,
      if (themeColor != null) 'theme_color': themeColor,
      if (measurementUnit != null) 'measurement_unit': measurementUnit,
      if (currency != null) 'currency': currency,
      if (currencySymbol != null) 'currency_symbol': currencySymbol,
      if (notificationsEnabled != null)
        'notifications_enabled': notificationsEnabled,
      if (defaultReminderDays != null)
        'default_reminder_days': defaultReminderDays,
      if (showCompletedTasks != null)
        'show_completed_tasks': showCompletedTasks,
      if (currentPropertyId != null) 'current_property_id': currentPropertyId,
      if (hasCompletedOnboarding != null)
        'has_completed_onboarding': hasCompletedOnboarding,
      if (lastBackupDate != null) 'last_backup_date': lastBackupDate,
    });
  }

  AppSettingsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? themeMode,
    Value<String>? themeColor,
    Value<String>? measurementUnit,
    Value<String>? currency,
    Value<String>? currencySymbol,
    Value<bool>? notificationsEnabled,
    Value<int>? defaultReminderDays,
    Value<bool>? showCompletedTasks,
    Value<String?>? currentPropertyId,
    Value<bool>? hasCompletedOnboarding,
    Value<DateTime?>? lastBackupDate,
  }) {
    return AppSettingsTableCompanion(
      id: id ?? this.id,
      themeMode: themeMode ?? this.themeMode,
      themeColor: themeColor ?? this.themeColor,
      measurementUnit: measurementUnit ?? this.measurementUnit,
      currency: currency ?? this.currency,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      defaultReminderDays: defaultReminderDays ?? this.defaultReminderDays,
      showCompletedTasks: showCompletedTasks ?? this.showCompletedTasks,
      currentPropertyId: currentPropertyId ?? this.currentPropertyId,
      hasCompletedOnboarding:
          hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      lastBackupDate: lastBackupDate ?? this.lastBackupDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (themeColor.present) {
      map['theme_color'] = Variable<String>(themeColor.value);
    }
    if (measurementUnit.present) {
      map['measurement_unit'] = Variable<String>(measurementUnit.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (currencySymbol.present) {
      map['currency_symbol'] = Variable<String>(currencySymbol.value);
    }
    if (notificationsEnabled.present) {
      map['notifications_enabled'] = Variable<bool>(notificationsEnabled.value);
    }
    if (defaultReminderDays.present) {
      map['default_reminder_days'] = Variable<int>(defaultReminderDays.value);
    }
    if (showCompletedTasks.present) {
      map['show_completed_tasks'] = Variable<bool>(showCompletedTasks.value);
    }
    if (currentPropertyId.present) {
      map['current_property_id'] = Variable<String>(currentPropertyId.value);
    }
    if (hasCompletedOnboarding.present) {
      map['has_completed_onboarding'] = Variable<bool>(
        hasCompletedOnboarding.value,
      );
    }
    if (lastBackupDate.present) {
      map['last_backup_date'] = Variable<DateTime>(lastBackupDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('themeColor: $themeColor, ')
          ..write('measurementUnit: $measurementUnit, ')
          ..write('currency: $currency, ')
          ..write('currencySymbol: $currencySymbol, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('defaultReminderDays: $defaultReminderDays, ')
          ..write('showCompletedTasks: $showCompletedTasks, ')
          ..write('currentPropertyId: $currentPropertyId, ')
          ..write('hasCompletedOnboarding: $hasCompletedOnboarding, ')
          ..write('lastBackupDate: $lastBackupDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PropertiesTable properties = $PropertiesTable(this);
  late final $AssetsTable assets = $AssetsTable(this);
  late final $MaintenanceTasksTable maintenanceTasks = $MaintenanceTasksTable(
    this,
  );
  late final $ContractorsTable contractors = $ContractorsTable(this);
  late final $ServiceRecordsTable serviceRecords = $ServiceRecordsTable(this);
  late final $DocumentsTable documents = $DocumentsTable(this);
  late final $AppSettingsTableTable appSettingsTable = $AppSettingsTableTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    properties,
    assets,
    maintenanceTasks,
    contractors,
    serviceRecords,
    documents,
    appSettingsTable,
  ];
}

typedef $$PropertiesTableCreateCompanionBuilder =
    PropertiesCompanion Function({
      required String id,
      required String name,
      Value<String?> address,
      Value<int?> yearBuilt,
      Value<int?> squareFeet,
      Value<String?> notes,
      Value<String?> coverImagePath,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$PropertiesTableUpdateCompanionBuilder =
    PropertiesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> address,
      Value<int?> yearBuilt,
      Value<int?> squareFeet,
      Value<String?> notes,
      Value<String?> coverImagePath,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$PropertiesTableReferences
    extends BaseReferences<_$AppDatabase, $PropertiesTable, Property> {
  $$PropertiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AssetsTable, List<Asset>> _assetsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.assets,
    aliasName: $_aliasNameGenerator(db.properties.id, db.assets.propertyId),
  );

  $$AssetsTableProcessedTableManager get assetsRefs {
    final manager = $$AssetsTableTableManager(
      $_db,
      $_db.assets,
    ).filter((f) => f.propertyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_assetsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MaintenanceTasksTable, List<MaintenanceTask>>
  _maintenanceTasksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.maintenanceTasks,
    aliasName: $_aliasNameGenerator(
      db.properties.id,
      db.maintenanceTasks.propertyId,
    ),
  );

  $$MaintenanceTasksTableProcessedTableManager get maintenanceTasksRefs {
    final manager = $$MaintenanceTasksTableTableManager(
      $_db,
      $_db.maintenanceTasks,
    ).filter((f) => f.propertyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _maintenanceTasksRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ContractorsTable, List<Contractor>>
  _contractorsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.contractors,
    aliasName: $_aliasNameGenerator(
      db.properties.id,
      db.contractors.propertyId,
    ),
  );

  $$ContractorsTableProcessedTableManager get contractorsRefs {
    final manager = $$ContractorsTableTableManager(
      $_db,
      $_db.contractors,
    ).filter((f) => f.propertyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_contractorsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ServiceRecordsTable, List<ServiceRecord>>
  _serviceRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.serviceRecords,
    aliasName: $_aliasNameGenerator(
      db.properties.id,
      db.serviceRecords.propertyId,
    ),
  );

  $$ServiceRecordsTableProcessedTableManager get serviceRecordsRefs {
    final manager = $$ServiceRecordsTableTableManager(
      $_db,
      $_db.serviceRecords,
    ).filter((f) => f.propertyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_serviceRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DocumentsTable, List<Document>>
  _documentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.documents,
    aliasName: $_aliasNameGenerator(db.properties.id, db.documents.propertyId),
  );

  $$DocumentsTableProcessedTableManager get documentsRefs {
    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.propertyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_documentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PropertiesTableFilterComposer
    extends Composer<_$AppDatabase, $PropertiesTable> {
  $$PropertiesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get yearBuilt => $composableBuilder(
    column: $table.yearBuilt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get squareFeet => $composableBuilder(
    column: $table.squareFeet,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverImagePath => $composableBuilder(
    column: $table.coverImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> assetsRefs(
    Expression<bool> Function($$AssetsTableFilterComposer f) f,
  ) {
    final $$AssetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.assets,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssetsTableFilterComposer(
            $db: $db,
            $table: $db.assets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> maintenanceTasksRefs(
    Expression<bool> Function($$MaintenanceTasksTableFilterComposer f) f,
  ) {
    final $$MaintenanceTasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenanceTasks,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceTasksTableFilterComposer(
            $db: $db,
            $table: $db.maintenanceTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> contractorsRefs(
    Expression<bool> Function($$ContractorsTableFilterComposer f) f,
  ) {
    final $$ContractorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contractors,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractorsTableFilterComposer(
            $db: $db,
            $table: $db.contractors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> serviceRecordsRefs(
    Expression<bool> Function($$ServiceRecordsTableFilterComposer f) f,
  ) {
    final $$ServiceRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.serviceRecords,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceRecordsTableFilterComposer(
            $db: $db,
            $table: $db.serviceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> documentsRefs(
    Expression<bool> Function($$DocumentsTableFilterComposer f) f,
  ) {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PropertiesTableOrderingComposer
    extends Composer<_$AppDatabase, $PropertiesTable> {
  $$PropertiesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get yearBuilt => $composableBuilder(
    column: $table.yearBuilt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get squareFeet => $composableBuilder(
    column: $table.squareFeet,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverImagePath => $composableBuilder(
    column: $table.coverImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PropertiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PropertiesTable> {
  $$PropertiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<int> get yearBuilt =>
      $composableBuilder(column: $table.yearBuilt, builder: (column) => column);

  GeneratedColumn<int> get squareFeet => $composableBuilder(
    column: $table.squareFeet,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get coverImagePath => $composableBuilder(
    column: $table.coverImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> assetsRefs<T extends Object>(
    Expression<T> Function($$AssetsTableAnnotationComposer a) f,
  ) {
    final $$AssetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.assets,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssetsTableAnnotationComposer(
            $db: $db,
            $table: $db.assets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> maintenanceTasksRefs<T extends Object>(
    Expression<T> Function($$MaintenanceTasksTableAnnotationComposer a) f,
  ) {
    final $$MaintenanceTasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenanceTasks,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceTasksTableAnnotationComposer(
            $db: $db,
            $table: $db.maintenanceTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> contractorsRefs<T extends Object>(
    Expression<T> Function($$ContractorsTableAnnotationComposer a) f,
  ) {
    final $$ContractorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contractors,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractorsTableAnnotationComposer(
            $db: $db,
            $table: $db.contractors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> serviceRecordsRefs<T extends Object>(
    Expression<T> Function($$ServiceRecordsTableAnnotationComposer a) f,
  ) {
    final $$ServiceRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.serviceRecords,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.serviceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> documentsRefs<T extends Object>(
    Expression<T> Function($$DocumentsTableAnnotationComposer a) f,
  ) {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PropertiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PropertiesTable,
          Property,
          $$PropertiesTableFilterComposer,
          $$PropertiesTableOrderingComposer,
          $$PropertiesTableAnnotationComposer,
          $$PropertiesTableCreateCompanionBuilder,
          $$PropertiesTableUpdateCompanionBuilder,
          (Property, $$PropertiesTableReferences),
          Property,
          PrefetchHooks Function({
            bool assetsRefs,
            bool maintenanceTasksRefs,
            bool contractorsRefs,
            bool serviceRecordsRefs,
            bool documentsRefs,
          })
        > {
  $$PropertiesTableTableManager(_$AppDatabase db, $PropertiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PropertiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PropertiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PropertiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<int?> yearBuilt = const Value.absent(),
                Value<int?> squareFeet = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> coverImagePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PropertiesCompanion(
                id: id,
                name: name,
                address: address,
                yearBuilt: yearBuilt,
                squareFeet: squareFeet,
                notes: notes,
                coverImagePath: coverImagePath,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> address = const Value.absent(),
                Value<int?> yearBuilt = const Value.absent(),
                Value<int?> squareFeet = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> coverImagePath = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => PropertiesCompanion.insert(
                id: id,
                name: name,
                address: address,
                yearBuilt: yearBuilt,
                squareFeet: squareFeet,
                notes: notes,
                coverImagePath: coverImagePath,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PropertiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                assetsRefs = false,
                maintenanceTasksRefs = false,
                contractorsRefs = false,
                serviceRecordsRefs = false,
                documentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (assetsRefs) db.assets,
                    if (maintenanceTasksRefs) db.maintenanceTasks,
                    if (contractorsRefs) db.contractors,
                    if (serviceRecordsRefs) db.serviceRecords,
                    if (documentsRefs) db.documents,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (assetsRefs)
                        await $_getPrefetchedData<
                          Property,
                          $PropertiesTable,
                          Asset
                        >(
                          currentTable: table,
                          referencedTable: $$PropertiesTableReferences
                              ._assetsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PropertiesTableReferences(
                                db,
                                table,
                                p0,
                              ).assetsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.propertyId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (maintenanceTasksRefs)
                        await $_getPrefetchedData<
                          Property,
                          $PropertiesTable,
                          MaintenanceTask
                        >(
                          currentTable: table,
                          referencedTable: $$PropertiesTableReferences
                              ._maintenanceTasksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PropertiesTableReferences(
                                db,
                                table,
                                p0,
                              ).maintenanceTasksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.propertyId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (contractorsRefs)
                        await $_getPrefetchedData<
                          Property,
                          $PropertiesTable,
                          Contractor
                        >(
                          currentTable: table,
                          referencedTable: $$PropertiesTableReferences
                              ._contractorsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PropertiesTableReferences(
                                db,
                                table,
                                p0,
                              ).contractorsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.propertyId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (serviceRecordsRefs)
                        await $_getPrefetchedData<
                          Property,
                          $PropertiesTable,
                          ServiceRecord
                        >(
                          currentTable: table,
                          referencedTable: $$PropertiesTableReferences
                              ._serviceRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PropertiesTableReferences(
                                db,
                                table,
                                p0,
                              ).serviceRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.propertyId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (documentsRefs)
                        await $_getPrefetchedData<
                          Property,
                          $PropertiesTable,
                          Document
                        >(
                          currentTable: table,
                          referencedTable: $$PropertiesTableReferences
                              ._documentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PropertiesTableReferences(
                                db,
                                table,
                                p0,
                              ).documentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.propertyId == item.id,
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

typedef $$PropertiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PropertiesTable,
      Property,
      $$PropertiesTableFilterComposer,
      $$PropertiesTableOrderingComposer,
      $$PropertiesTableAnnotationComposer,
      $$PropertiesTableCreateCompanionBuilder,
      $$PropertiesTableUpdateCompanionBuilder,
      (Property, $$PropertiesTableReferences),
      Property,
      PrefetchHooks Function({
        bool assetsRefs,
        bool maintenanceTasksRefs,
        bool contractorsRefs,
        bool serviceRecordsRefs,
        bool documentsRefs,
      })
    >;
typedef $$AssetsTableCreateCompanionBuilder =
    AssetsCompanion Function({
      required String id,
      required String propertyId,
      required String name,
      required String category,
      Value<String?> locationRoom,
      Value<String?> manufacturer,
      Value<String?> model,
      Value<String?> serialNumber,
      Value<DateTime?> installDate,
      Value<DateTime?> purchaseDate,
      Value<DateTime?> warrantyExpirationDate,
      Value<double?> purchasePrice,
      Value<String?> notes,
      Value<String> photoPaths,
      Value<String?> labelPhotoPath,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$AssetsTableUpdateCompanionBuilder =
    AssetsCompanion Function({
      Value<String> id,
      Value<String> propertyId,
      Value<String> name,
      Value<String> category,
      Value<String?> locationRoom,
      Value<String?> manufacturer,
      Value<String?> model,
      Value<String?> serialNumber,
      Value<DateTime?> installDate,
      Value<DateTime?> purchaseDate,
      Value<DateTime?> warrantyExpirationDate,
      Value<double?> purchasePrice,
      Value<String?> notes,
      Value<String> photoPaths,
      Value<String?> labelPhotoPath,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$AssetsTableReferences
    extends BaseReferences<_$AppDatabase, $AssetsTable, Asset> {
  $$AssetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PropertiesTable _propertyIdTable(_$AppDatabase db) =>
      db.properties.createAlias(
        $_aliasNameGenerator(db.assets.propertyId, db.properties.id),
      );

  $$PropertiesTableProcessedTableManager get propertyId {
    final $_column = $_itemColumn<String>('property_id')!;

    final manager = $$PropertiesTableTableManager(
      $_db,
      $_db.properties,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_propertyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DocumentsTable, List<Document>>
  _documentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.documents,
    aliasName: $_aliasNameGenerator(db.assets.id, db.documents.linkedAssetId),
  );

  $$DocumentsTableProcessedTableManager get documentsRefs {
    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.linkedAssetId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_documentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AssetsTableFilterComposer
    extends Composer<_$AppDatabase, $AssetsTable> {
  $$AssetsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationRoom => $composableBuilder(
    column: $table.locationRoom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get manufacturer => $composableBuilder(
    column: $table.manufacturer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get installDate => $composableBuilder(
    column: $table.installDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get warrantyExpirationDate => $composableBuilder(
    column: $table.warrantyExpirationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPaths => $composableBuilder(
    column: $table.photoPaths,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelPhotoPath => $composableBuilder(
    column: $table.labelPhotoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PropertiesTableFilterComposer get propertyId {
    final $$PropertiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableFilterComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> documentsRefs(
    Expression<bool> Function($$DocumentsTableFilterComposer f) f,
  ) {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.linkedAssetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AssetsTableOrderingComposer
    extends Composer<_$AppDatabase, $AssetsTable> {
  $$AssetsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationRoom => $composableBuilder(
    column: $table.locationRoom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get manufacturer => $composableBuilder(
    column: $table.manufacturer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get installDate => $composableBuilder(
    column: $table.installDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get warrantyExpirationDate => $composableBuilder(
    column: $table.warrantyExpirationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPaths => $composableBuilder(
    column: $table.photoPaths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelPhotoPath => $composableBuilder(
    column: $table.labelPhotoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PropertiesTableOrderingComposer get propertyId {
    final $$PropertiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableOrderingComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AssetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssetsTable> {
  $$AssetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get locationRoom => $composableBuilder(
    column: $table.locationRoom,
    builder: (column) => column,
  );

  GeneratedColumn<String> get manufacturer => $composableBuilder(
    column: $table.manufacturer,
    builder: (column) => column,
  );

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get installDate => $composableBuilder(
    column: $table.installDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get warrantyExpirationDate => $composableBuilder(
    column: $table.warrantyExpirationDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get photoPaths => $composableBuilder(
    column: $table.photoPaths,
    builder: (column) => column,
  );

  GeneratedColumn<String> get labelPhotoPath => $composableBuilder(
    column: $table.labelPhotoPath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$PropertiesTableAnnotationComposer get propertyId {
    final $$PropertiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableAnnotationComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> documentsRefs<T extends Object>(
    Expression<T> Function($$DocumentsTableAnnotationComposer a) f,
  ) {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.linkedAssetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AssetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AssetsTable,
          Asset,
          $$AssetsTableFilterComposer,
          $$AssetsTableOrderingComposer,
          $$AssetsTableAnnotationComposer,
          $$AssetsTableCreateCompanionBuilder,
          $$AssetsTableUpdateCompanionBuilder,
          (Asset, $$AssetsTableReferences),
          Asset,
          PrefetchHooks Function({bool propertyId, bool documentsRefs})
        > {
  $$AssetsTableTableManager(_$AppDatabase db, $AssetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> propertyId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> locationRoom = const Value.absent(),
                Value<String?> manufacturer = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<String?> serialNumber = const Value.absent(),
                Value<DateTime?> installDate = const Value.absent(),
                Value<DateTime?> purchaseDate = const Value.absent(),
                Value<DateTime?> warrantyExpirationDate = const Value.absent(),
                Value<double?> purchasePrice = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> photoPaths = const Value.absent(),
                Value<String?> labelPhotoPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AssetsCompanion(
                id: id,
                propertyId: propertyId,
                name: name,
                category: category,
                locationRoom: locationRoom,
                manufacturer: manufacturer,
                model: model,
                serialNumber: serialNumber,
                installDate: installDate,
                purchaseDate: purchaseDate,
                warrantyExpirationDate: warrantyExpirationDate,
                purchasePrice: purchasePrice,
                notes: notes,
                photoPaths: photoPaths,
                labelPhotoPath: labelPhotoPath,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String propertyId,
                required String name,
                required String category,
                Value<String?> locationRoom = const Value.absent(),
                Value<String?> manufacturer = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<String?> serialNumber = const Value.absent(),
                Value<DateTime?> installDate = const Value.absent(),
                Value<DateTime?> purchaseDate = const Value.absent(),
                Value<DateTime?> warrantyExpirationDate = const Value.absent(),
                Value<double?> purchasePrice = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> photoPaths = const Value.absent(),
                Value<String?> labelPhotoPath = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AssetsCompanion.insert(
                id: id,
                propertyId: propertyId,
                name: name,
                category: category,
                locationRoom: locationRoom,
                manufacturer: manufacturer,
                model: model,
                serialNumber: serialNumber,
                installDate: installDate,
                purchaseDate: purchaseDate,
                warrantyExpirationDate: warrantyExpirationDate,
                purchasePrice: purchasePrice,
                notes: notes,
                photoPaths: photoPaths,
                labelPhotoPath: labelPhotoPath,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$AssetsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({propertyId = false, documentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (documentsRefs) db.documents],
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
                    if (propertyId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.propertyId,
                                referencedTable: $$AssetsTableReferences
                                    ._propertyIdTable(db),
                                referencedColumn: $$AssetsTableReferences
                                    ._propertyIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (documentsRefs)
                    await $_getPrefetchedData<Asset, $AssetsTable, Document>(
                      currentTable: table,
                      referencedTable: $$AssetsTableReferences
                          ._documentsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$AssetsTableReferences(db, table, p0).documentsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.linkedAssetId == item.id,
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

typedef $$AssetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AssetsTable,
      Asset,
      $$AssetsTableFilterComposer,
      $$AssetsTableOrderingComposer,
      $$AssetsTableAnnotationComposer,
      $$AssetsTableCreateCompanionBuilder,
      $$AssetsTableUpdateCompanionBuilder,
      (Asset, $$AssetsTableReferences),
      Asset,
      PrefetchHooks Function({bool propertyId, bool documentsRefs})
    >;
typedef $$MaintenanceTasksTableCreateCompanionBuilder =
    MaintenanceTasksCompanion Function({
      required String id,
      required String propertyId,
      required String title,
      Value<String?> description,
      Value<String?> instructions,
      Value<String?> category,
      required String frequency,
      Value<int?> customIntervalDays,
      Value<String?> season,
      Value<DateTime?> nextDueDate,
      Value<DateTime?> lastCompletedDate,
      Value<String> linkedAssetIds,
      Value<double?> estimatedCost,
      Value<int?> estimatedTimeMinutes,
      Value<bool> reminderEnabled,
      Value<int> reminderDaysBefore,
      Value<String?> notes,
      Value<bool> isTemplate,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$MaintenanceTasksTableUpdateCompanionBuilder =
    MaintenanceTasksCompanion Function({
      Value<String> id,
      Value<String> propertyId,
      Value<String> title,
      Value<String?> description,
      Value<String?> instructions,
      Value<String?> category,
      Value<String> frequency,
      Value<int?> customIntervalDays,
      Value<String?> season,
      Value<DateTime?> nextDueDate,
      Value<DateTime?> lastCompletedDate,
      Value<String> linkedAssetIds,
      Value<double?> estimatedCost,
      Value<int?> estimatedTimeMinutes,
      Value<bool> reminderEnabled,
      Value<int> reminderDaysBefore,
      Value<String?> notes,
      Value<bool> isTemplate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$MaintenanceTasksTableReferences
    extends
        BaseReferences<_$AppDatabase, $MaintenanceTasksTable, MaintenanceTask> {
  $$MaintenanceTasksTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PropertiesTable _propertyIdTable(_$AppDatabase db) =>
      db.properties.createAlias(
        $_aliasNameGenerator(db.maintenanceTasks.propertyId, db.properties.id),
      );

  $$PropertiesTableProcessedTableManager get propertyId {
    final $_column = $_itemColumn<String>('property_id')!;

    final manager = $$PropertiesTableTableManager(
      $_db,
      $_db.properties,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_propertyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ServiceRecordsTable, List<ServiceRecord>>
  _serviceRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.serviceRecords,
    aliasName: $_aliasNameGenerator(
      db.maintenanceTasks.id,
      db.serviceRecords.taskId,
    ),
  );

  $$ServiceRecordsTableProcessedTableManager get serviceRecordsRefs {
    final manager = $$ServiceRecordsTableTableManager(
      $_db,
      $_db.serviceRecords,
    ).filter((f) => f.taskId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_serviceRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MaintenanceTasksTableFilterComposer
    extends Composer<_$AppDatabase, $MaintenanceTasksTable> {
  $$MaintenanceTasksTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get customIntervalDays => $composableBuilder(
    column: $table.customIntervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get season => $composableBuilder(
    column: $table.season,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastCompletedDate => $composableBuilder(
    column: $table.lastCompletedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get linkedAssetIds => $composableBuilder(
    column: $table.linkedAssetIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get estimatedCost => $composableBuilder(
    column: $table.estimatedCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedTimeMinutes => $composableBuilder(
    column: $table.estimatedTimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderDaysBefore => $composableBuilder(
    column: $table.reminderDaysBefore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isTemplate => $composableBuilder(
    column: $table.isTemplate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PropertiesTableFilterComposer get propertyId {
    final $$PropertiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableFilterComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> serviceRecordsRefs(
    Expression<bool> Function($$ServiceRecordsTableFilterComposer f) f,
  ) {
    final $$ServiceRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.serviceRecords,
      getReferencedColumn: (t) => t.taskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceRecordsTableFilterComposer(
            $db: $db,
            $table: $db.serviceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MaintenanceTasksTableOrderingComposer
    extends Composer<_$AppDatabase, $MaintenanceTasksTable> {
  $$MaintenanceTasksTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get customIntervalDays => $composableBuilder(
    column: $table.customIntervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get season => $composableBuilder(
    column: $table.season,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastCompletedDate => $composableBuilder(
    column: $table.lastCompletedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get linkedAssetIds => $composableBuilder(
    column: $table.linkedAssetIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get estimatedCost => $composableBuilder(
    column: $table.estimatedCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedTimeMinutes => $composableBuilder(
    column: $table.estimatedTimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderDaysBefore => $composableBuilder(
    column: $table.reminderDaysBefore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isTemplate => $composableBuilder(
    column: $table.isTemplate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PropertiesTableOrderingComposer get propertyId {
    final $$PropertiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableOrderingComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenanceTasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaintenanceTasksTable> {
  $$MaintenanceTasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<int> get customIntervalDays => $composableBuilder(
    column: $table.customIntervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get season =>
      $composableBuilder(column: $table.season, builder: (column) => column);

  GeneratedColumn<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastCompletedDate => $composableBuilder(
    column: $table.lastCompletedDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get linkedAssetIds => $composableBuilder(
    column: $table.linkedAssetIds,
    builder: (column) => column,
  );

  GeneratedColumn<double> get estimatedCost => $composableBuilder(
    column: $table.estimatedCost,
    builder: (column) => column,
  );

  GeneratedColumn<int> get estimatedTimeMinutes => $composableBuilder(
    column: $table.estimatedTimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderDaysBefore => $composableBuilder(
    column: $table.reminderDaysBefore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isTemplate => $composableBuilder(
    column: $table.isTemplate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$PropertiesTableAnnotationComposer get propertyId {
    final $$PropertiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableAnnotationComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> serviceRecordsRefs<T extends Object>(
    Expression<T> Function($$ServiceRecordsTableAnnotationComposer a) f,
  ) {
    final $$ServiceRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.serviceRecords,
      getReferencedColumn: (t) => t.taskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.serviceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MaintenanceTasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MaintenanceTasksTable,
          MaintenanceTask,
          $$MaintenanceTasksTableFilterComposer,
          $$MaintenanceTasksTableOrderingComposer,
          $$MaintenanceTasksTableAnnotationComposer,
          $$MaintenanceTasksTableCreateCompanionBuilder,
          $$MaintenanceTasksTableUpdateCompanionBuilder,
          (MaintenanceTask, $$MaintenanceTasksTableReferences),
          MaintenanceTask,
          PrefetchHooks Function({bool propertyId, bool serviceRecordsRefs})
        > {
  $$MaintenanceTasksTableTableManager(
    _$AppDatabase db,
    $MaintenanceTasksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaintenanceTasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaintenanceTasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MaintenanceTasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> propertyId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> instructions = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String> frequency = const Value.absent(),
                Value<int?> customIntervalDays = const Value.absent(),
                Value<String?> season = const Value.absent(),
                Value<DateTime?> nextDueDate = const Value.absent(),
                Value<DateTime?> lastCompletedDate = const Value.absent(),
                Value<String> linkedAssetIds = const Value.absent(),
                Value<double?> estimatedCost = const Value.absent(),
                Value<int?> estimatedTimeMinutes = const Value.absent(),
                Value<bool> reminderEnabled = const Value.absent(),
                Value<int> reminderDaysBefore = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isTemplate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MaintenanceTasksCompanion(
                id: id,
                propertyId: propertyId,
                title: title,
                description: description,
                instructions: instructions,
                category: category,
                frequency: frequency,
                customIntervalDays: customIntervalDays,
                season: season,
                nextDueDate: nextDueDate,
                lastCompletedDate: lastCompletedDate,
                linkedAssetIds: linkedAssetIds,
                estimatedCost: estimatedCost,
                estimatedTimeMinutes: estimatedTimeMinutes,
                reminderEnabled: reminderEnabled,
                reminderDaysBefore: reminderDaysBefore,
                notes: notes,
                isTemplate: isTemplate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String propertyId,
                required String title,
                Value<String?> description = const Value.absent(),
                Value<String?> instructions = const Value.absent(),
                Value<String?> category = const Value.absent(),
                required String frequency,
                Value<int?> customIntervalDays = const Value.absent(),
                Value<String?> season = const Value.absent(),
                Value<DateTime?> nextDueDate = const Value.absent(),
                Value<DateTime?> lastCompletedDate = const Value.absent(),
                Value<String> linkedAssetIds = const Value.absent(),
                Value<double?> estimatedCost = const Value.absent(),
                Value<int?> estimatedTimeMinutes = const Value.absent(),
                Value<bool> reminderEnabled = const Value.absent(),
                Value<int> reminderDaysBefore = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isTemplate = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MaintenanceTasksCompanion.insert(
                id: id,
                propertyId: propertyId,
                title: title,
                description: description,
                instructions: instructions,
                category: category,
                frequency: frequency,
                customIntervalDays: customIntervalDays,
                season: season,
                nextDueDate: nextDueDate,
                lastCompletedDate: lastCompletedDate,
                linkedAssetIds: linkedAssetIds,
                estimatedCost: estimatedCost,
                estimatedTimeMinutes: estimatedTimeMinutes,
                reminderEnabled: reminderEnabled,
                reminderDaysBefore: reminderDaysBefore,
                notes: notes,
                isTemplate: isTemplate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MaintenanceTasksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({propertyId = false, serviceRecordsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (serviceRecordsRefs) db.serviceRecords,
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
                        if (propertyId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.propertyId,
                                    referencedTable:
                                        $$MaintenanceTasksTableReferences
                                            ._propertyIdTable(db),
                                    referencedColumn:
                                        $$MaintenanceTasksTableReferences
                                            ._propertyIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (serviceRecordsRefs)
                        await $_getPrefetchedData<
                          MaintenanceTask,
                          $MaintenanceTasksTable,
                          ServiceRecord
                        >(
                          currentTable: table,
                          referencedTable: $$MaintenanceTasksTableReferences
                              ._serviceRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MaintenanceTasksTableReferences(
                                db,
                                table,
                                p0,
                              ).serviceRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.taskId == item.id,
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

typedef $$MaintenanceTasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MaintenanceTasksTable,
      MaintenanceTask,
      $$MaintenanceTasksTableFilterComposer,
      $$MaintenanceTasksTableOrderingComposer,
      $$MaintenanceTasksTableAnnotationComposer,
      $$MaintenanceTasksTableCreateCompanionBuilder,
      $$MaintenanceTasksTableUpdateCompanionBuilder,
      (MaintenanceTask, $$MaintenanceTasksTableReferences),
      MaintenanceTask,
      PrefetchHooks Function({bool propertyId, bool serviceRecordsRefs})
    >;
typedef $$ContractorsTableCreateCompanionBuilder =
    ContractorsCompanion Function({
      required String id,
      required String propertyId,
      required String name,
      Value<String?> companyName,
      required String tradeType,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> address,
      Value<String?> website,
      Value<String?> notes,
      Value<bool> isPreferred,
      Value<double?> rating,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ContractorsTableUpdateCompanionBuilder =
    ContractorsCompanion Function({
      Value<String> id,
      Value<String> propertyId,
      Value<String> name,
      Value<String?> companyName,
      Value<String> tradeType,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> address,
      Value<String?> website,
      Value<String?> notes,
      Value<bool> isPreferred,
      Value<double?> rating,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ContractorsTableReferences
    extends BaseReferences<_$AppDatabase, $ContractorsTable, Contractor> {
  $$ContractorsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PropertiesTable _propertyIdTable(_$AppDatabase db) =>
      db.properties.createAlias(
        $_aliasNameGenerator(db.contractors.propertyId, db.properties.id),
      );

  $$PropertiesTableProcessedTableManager get propertyId {
    final $_column = $_itemColumn<String>('property_id')!;

    final manager = $$PropertiesTableTableManager(
      $_db,
      $_db.properties,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_propertyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ServiceRecordsTable, List<ServiceRecord>>
  _serviceRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.serviceRecords,
    aliasName: $_aliasNameGenerator(
      db.contractors.id,
      db.serviceRecords.contractorId,
    ),
  );

  $$ServiceRecordsTableProcessedTableManager get serviceRecordsRefs {
    final manager = $$ServiceRecordsTableTableManager(
      $_db,
      $_db.serviceRecords,
    ).filter((f) => f.contractorId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_serviceRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ContractorsTableFilterComposer
    extends Composer<_$AppDatabase, $ContractorsTable> {
  $$ContractorsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tradeType => $composableBuilder(
    column: $table.tradeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get website => $composableBuilder(
    column: $table.website,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPreferred => $composableBuilder(
    column: $table.isPreferred,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PropertiesTableFilterComposer get propertyId {
    final $$PropertiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableFilterComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> serviceRecordsRefs(
    Expression<bool> Function($$ServiceRecordsTableFilterComposer f) f,
  ) {
    final $$ServiceRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.serviceRecords,
      getReferencedColumn: (t) => t.contractorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceRecordsTableFilterComposer(
            $db: $db,
            $table: $db.serviceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContractorsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContractorsTable> {
  $$ContractorsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tradeType => $composableBuilder(
    column: $table.tradeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get website => $composableBuilder(
    column: $table.website,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPreferred => $composableBuilder(
    column: $table.isPreferred,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PropertiesTableOrderingComposer get propertyId {
    final $$PropertiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableOrderingComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContractorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContractorsTable> {
  $$ContractorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tradeType =>
      $composableBuilder(column: $table.tradeType, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get website =>
      $composableBuilder(column: $table.website, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isPreferred => $composableBuilder(
    column: $table.isPreferred,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$PropertiesTableAnnotationComposer get propertyId {
    final $$PropertiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableAnnotationComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> serviceRecordsRefs<T extends Object>(
    Expression<T> Function($$ServiceRecordsTableAnnotationComposer a) f,
  ) {
    final $$ServiceRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.serviceRecords,
      getReferencedColumn: (t) => t.contractorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.serviceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContractorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContractorsTable,
          Contractor,
          $$ContractorsTableFilterComposer,
          $$ContractorsTableOrderingComposer,
          $$ContractorsTableAnnotationComposer,
          $$ContractorsTableCreateCompanionBuilder,
          $$ContractorsTableUpdateCompanionBuilder,
          (Contractor, $$ContractorsTableReferences),
          Contractor,
          PrefetchHooks Function({bool propertyId, bool serviceRecordsRefs})
        > {
  $$ContractorsTableTableManager(_$AppDatabase db, $ContractorsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContractorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContractorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContractorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> propertyId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> companyName = const Value.absent(),
                Value<String> tradeType = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> website = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isPreferred = const Value.absent(),
                Value<double?> rating = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContractorsCompanion(
                id: id,
                propertyId: propertyId,
                name: name,
                companyName: companyName,
                tradeType: tradeType,
                phone: phone,
                email: email,
                address: address,
                website: website,
                notes: notes,
                isPreferred: isPreferred,
                rating: rating,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String propertyId,
                required String name,
                Value<String?> companyName = const Value.absent(),
                required String tradeType,
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> website = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isPreferred = const Value.absent(),
                Value<double?> rating = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ContractorsCompanion.insert(
                id: id,
                propertyId: propertyId,
                name: name,
                companyName: companyName,
                tradeType: tradeType,
                phone: phone,
                email: email,
                address: address,
                website: website,
                notes: notes,
                isPreferred: isPreferred,
                rating: rating,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ContractorsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({propertyId = false, serviceRecordsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (serviceRecordsRefs) db.serviceRecords,
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
                        if (propertyId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.propertyId,
                                    referencedTable:
                                        $$ContractorsTableReferences
                                            ._propertyIdTable(db),
                                    referencedColumn:
                                        $$ContractorsTableReferences
                                            ._propertyIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (serviceRecordsRefs)
                        await $_getPrefetchedData<
                          Contractor,
                          $ContractorsTable,
                          ServiceRecord
                        >(
                          currentTable: table,
                          referencedTable: $$ContractorsTableReferences
                              ._serviceRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ContractorsTableReferences(
                                db,
                                table,
                                p0,
                              ).serviceRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.contractorId == item.id,
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

typedef $$ContractorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContractorsTable,
      Contractor,
      $$ContractorsTableFilterComposer,
      $$ContractorsTableOrderingComposer,
      $$ContractorsTableAnnotationComposer,
      $$ContractorsTableCreateCompanionBuilder,
      $$ContractorsTableUpdateCompanionBuilder,
      (Contractor, $$ContractorsTableReferences),
      Contractor,
      PrefetchHooks Function({bool propertyId, bool serviceRecordsRefs})
    >;
typedef $$ServiceRecordsTableCreateCompanionBuilder =
    ServiceRecordsCompanion Function({
      required String id,
      required String propertyId,
      required DateTime date,
      required String title,
      Value<String?> description,
      Value<String> assetIds,
      Value<String?> taskId,
      Value<String?> contractorId,
      Value<double?> cost,
      Value<String?> notes,
      Value<String> attachmentPaths,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ServiceRecordsTableUpdateCompanionBuilder =
    ServiceRecordsCompanion Function({
      Value<String> id,
      Value<String> propertyId,
      Value<DateTime> date,
      Value<String> title,
      Value<String?> description,
      Value<String> assetIds,
      Value<String?> taskId,
      Value<String?> contractorId,
      Value<double?> cost,
      Value<String?> notes,
      Value<String> attachmentPaths,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ServiceRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $ServiceRecordsTable, ServiceRecord> {
  $$ServiceRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PropertiesTable _propertyIdTable(_$AppDatabase db) =>
      db.properties.createAlias(
        $_aliasNameGenerator(db.serviceRecords.propertyId, db.properties.id),
      );

  $$PropertiesTableProcessedTableManager get propertyId {
    final $_column = $_itemColumn<String>('property_id')!;

    final manager = $$PropertiesTableTableManager(
      $_db,
      $_db.properties,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_propertyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MaintenanceTasksTable _taskIdTable(_$AppDatabase db) =>
      db.maintenanceTasks.createAlias(
        $_aliasNameGenerator(db.serviceRecords.taskId, db.maintenanceTasks.id),
      );

  $$MaintenanceTasksTableProcessedTableManager? get taskId {
    final $_column = $_itemColumn<String>('task_id');
    if ($_column == null) return null;
    final manager = $$MaintenanceTasksTableTableManager(
      $_db,
      $_db.maintenanceTasks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ContractorsTable _contractorIdTable(_$AppDatabase db) =>
      db.contractors.createAlias(
        $_aliasNameGenerator(db.serviceRecords.contractorId, db.contractors.id),
      );

  $$ContractorsTableProcessedTableManager? get contractorId {
    final $_column = $_itemColumn<String>('contractor_id');
    if ($_column == null) return null;
    final manager = $$ContractorsTableTableManager(
      $_db,
      $_db.contractors,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_contractorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ServiceRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $ServiceRecordsTable> {
  $$ServiceRecordsTableFilterComposer({
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

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetIds => $composableBuilder(
    column: $table.assetIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attachmentPaths => $composableBuilder(
    column: $table.attachmentPaths,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PropertiesTableFilterComposer get propertyId {
    final $$PropertiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableFilterComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MaintenanceTasksTableFilterComposer get taskId {
    final $$MaintenanceTasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.maintenanceTasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceTasksTableFilterComposer(
            $db: $db,
            $table: $db.maintenanceTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContractorsTableFilterComposer get contractorId {
    final $$ContractorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contractorId,
      referencedTable: $db.contractors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractorsTableFilterComposer(
            $db: $db,
            $table: $db.contractors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ServiceRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $ServiceRecordsTable> {
  $$ServiceRecordsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetIds => $composableBuilder(
    column: $table.assetIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attachmentPaths => $composableBuilder(
    column: $table.attachmentPaths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PropertiesTableOrderingComposer get propertyId {
    final $$PropertiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableOrderingComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MaintenanceTasksTableOrderingComposer get taskId {
    final $$MaintenanceTasksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.maintenanceTasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceTasksTableOrderingComposer(
            $db: $db,
            $table: $db.maintenanceTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContractorsTableOrderingComposer get contractorId {
    final $$ContractorsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contractorId,
      referencedTable: $db.contractors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractorsTableOrderingComposer(
            $db: $db,
            $table: $db.contractors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ServiceRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServiceRecordsTable> {
  $$ServiceRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get assetIds =>
      $composableBuilder(column: $table.assetIds, builder: (column) => column);

  GeneratedColumn<double> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get attachmentPaths => $composableBuilder(
    column: $table.attachmentPaths,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$PropertiesTableAnnotationComposer get propertyId {
    final $$PropertiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableAnnotationComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MaintenanceTasksTableAnnotationComposer get taskId {
    final $$MaintenanceTasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.maintenanceTasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceTasksTableAnnotationComposer(
            $db: $db,
            $table: $db.maintenanceTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContractorsTableAnnotationComposer get contractorId {
    final $$ContractorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contractorId,
      referencedTable: $db.contractors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractorsTableAnnotationComposer(
            $db: $db,
            $table: $db.contractors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ServiceRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ServiceRecordsTable,
          ServiceRecord,
          $$ServiceRecordsTableFilterComposer,
          $$ServiceRecordsTableOrderingComposer,
          $$ServiceRecordsTableAnnotationComposer,
          $$ServiceRecordsTableCreateCompanionBuilder,
          $$ServiceRecordsTableUpdateCompanionBuilder,
          (ServiceRecord, $$ServiceRecordsTableReferences),
          ServiceRecord,
          PrefetchHooks Function({
            bool propertyId,
            bool taskId,
            bool contractorId,
          })
        > {
  $$ServiceRecordsTableTableManager(
    _$AppDatabase db,
    $ServiceRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServiceRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServiceRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServiceRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> propertyId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> assetIds = const Value.absent(),
                Value<String?> taskId = const Value.absent(),
                Value<String?> contractorId = const Value.absent(),
                Value<double?> cost = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> attachmentPaths = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServiceRecordsCompanion(
                id: id,
                propertyId: propertyId,
                date: date,
                title: title,
                description: description,
                assetIds: assetIds,
                taskId: taskId,
                contractorId: contractorId,
                cost: cost,
                notes: notes,
                attachmentPaths: attachmentPaths,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String propertyId,
                required DateTime date,
                required String title,
                Value<String?> description = const Value.absent(),
                Value<String> assetIds = const Value.absent(),
                Value<String?> taskId = const Value.absent(),
                Value<String?> contractorId = const Value.absent(),
                Value<double?> cost = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> attachmentPaths = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ServiceRecordsCompanion.insert(
                id: id,
                propertyId: propertyId,
                date: date,
                title: title,
                description: description,
                assetIds: assetIds,
                taskId: taskId,
                contractorId: contractorId,
                cost: cost,
                notes: notes,
                attachmentPaths: attachmentPaths,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ServiceRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({propertyId = false, taskId = false, contractorId = false}) {
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
                        if (propertyId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.propertyId,
                                    referencedTable:
                                        $$ServiceRecordsTableReferences
                                            ._propertyIdTable(db),
                                    referencedColumn:
                                        $$ServiceRecordsTableReferences
                                            ._propertyIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (taskId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.taskId,
                                    referencedTable:
                                        $$ServiceRecordsTableReferences
                                            ._taskIdTable(db),
                                    referencedColumn:
                                        $$ServiceRecordsTableReferences
                                            ._taskIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (contractorId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.contractorId,
                                    referencedTable:
                                        $$ServiceRecordsTableReferences
                                            ._contractorIdTable(db),
                                    referencedColumn:
                                        $$ServiceRecordsTableReferences
                                            ._contractorIdTable(db)
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

typedef $$ServiceRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ServiceRecordsTable,
      ServiceRecord,
      $$ServiceRecordsTableFilterComposer,
      $$ServiceRecordsTableOrderingComposer,
      $$ServiceRecordsTableAnnotationComposer,
      $$ServiceRecordsTableCreateCompanionBuilder,
      $$ServiceRecordsTableUpdateCompanionBuilder,
      (ServiceRecord, $$ServiceRecordsTableReferences),
      ServiceRecord,
      PrefetchHooks Function({bool propertyId, bool taskId, bool contractorId})
    >;
typedef $$DocumentsTableCreateCompanionBuilder =
    DocumentsCompanion Function({
      required String id,
      required String propertyId,
      required String title,
      required String category,
      required String filePath,
      Value<String?> linkedAssetId,
      Value<String?> notes,
      Value<DateTime?> expirationDate,
      required DateTime dateAdded,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$DocumentsTableUpdateCompanionBuilder =
    DocumentsCompanion Function({
      Value<String> id,
      Value<String> propertyId,
      Value<String> title,
      Value<String> category,
      Value<String> filePath,
      Value<String?> linkedAssetId,
      Value<String?> notes,
      Value<DateTime?> expirationDate,
      Value<DateTime> dateAdded,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$DocumentsTableReferences
    extends BaseReferences<_$AppDatabase, $DocumentsTable, Document> {
  $$DocumentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PropertiesTable _propertyIdTable(_$AppDatabase db) =>
      db.properties.createAlias(
        $_aliasNameGenerator(db.documents.propertyId, db.properties.id),
      );

  $$PropertiesTableProcessedTableManager get propertyId {
    final $_column = $_itemColumn<String>('property_id')!;

    final manager = $$PropertiesTableTableManager(
      $_db,
      $_db.properties,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_propertyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AssetsTable _linkedAssetIdTable(_$AppDatabase db) =>
      db.assets.createAlias(
        $_aliasNameGenerator(db.documents.linkedAssetId, db.assets.id),
      );

  $$AssetsTableProcessedTableManager? get linkedAssetId {
    final $_column = $_itemColumn<String>('linked_asset_id');
    if ($_column == null) return null;
    final manager = $$AssetsTableTableManager(
      $_db,
      $_db.assets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_linkedAssetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateAdded => $composableBuilder(
    column: $table.dateAdded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PropertiesTableFilterComposer get propertyId {
    final $$PropertiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableFilterComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AssetsTableFilterComposer get linkedAssetId {
    final $$AssetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.linkedAssetId,
      referencedTable: $db.assets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssetsTableFilterComposer(
            $db: $db,
            $table: $db.assets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateAdded => $composableBuilder(
    column: $table.dateAdded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PropertiesTableOrderingComposer get propertyId {
    final $$PropertiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableOrderingComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AssetsTableOrderingComposer get linkedAssetId {
    final $$AssetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.linkedAssetId,
      referencedTable: $db.assets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssetsTableOrderingComposer(
            $db: $db,
            $table: $db.assets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateAdded =>
      $composableBuilder(column: $table.dateAdded, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$PropertiesTableAnnotationComposer get propertyId {
    final $$PropertiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableAnnotationComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AssetsTableAnnotationComposer get linkedAssetId {
    final $$AssetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.linkedAssetId,
      referencedTable: $db.assets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssetsTableAnnotationComposer(
            $db: $db,
            $table: $db.assets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentsTable,
          Document,
          $$DocumentsTableFilterComposer,
          $$DocumentsTableOrderingComposer,
          $$DocumentsTableAnnotationComposer,
          $$DocumentsTableCreateCompanionBuilder,
          $$DocumentsTableUpdateCompanionBuilder,
          (Document, $$DocumentsTableReferences),
          Document,
          PrefetchHooks Function({bool propertyId, bool linkedAssetId})
        > {
  $$DocumentsTableTableManager(_$AppDatabase db, $DocumentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> propertyId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<String?> linkedAssetId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime?> expirationDate = const Value.absent(),
                Value<DateTime> dateAdded = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentsCompanion(
                id: id,
                propertyId: propertyId,
                title: title,
                category: category,
                filePath: filePath,
                linkedAssetId: linkedAssetId,
                notes: notes,
                expirationDate: expirationDate,
                dateAdded: dateAdded,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String propertyId,
                required String title,
                required String category,
                required String filePath,
                Value<String?> linkedAssetId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime?> expirationDate = const Value.absent(),
                required DateTime dateAdded,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => DocumentsCompanion.insert(
                id: id,
                propertyId: propertyId,
                title: title,
                category: category,
                filePath: filePath,
                linkedAssetId: linkedAssetId,
                notes: notes,
                expirationDate: expirationDate,
                dateAdded: dateAdded,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DocumentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({propertyId = false, linkedAssetId = false}) {
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
                    if (propertyId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.propertyId,
                                referencedTable: $$DocumentsTableReferences
                                    ._propertyIdTable(db),
                                referencedColumn: $$DocumentsTableReferences
                                    ._propertyIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (linkedAssetId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.linkedAssetId,
                                referencedTable: $$DocumentsTableReferences
                                    ._linkedAssetIdTable(db),
                                referencedColumn: $$DocumentsTableReferences
                                    ._linkedAssetIdTable(db)
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

typedef $$DocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentsTable,
      Document,
      $$DocumentsTableFilterComposer,
      $$DocumentsTableOrderingComposer,
      $$DocumentsTableAnnotationComposer,
      $$DocumentsTableCreateCompanionBuilder,
      $$DocumentsTableUpdateCompanionBuilder,
      (Document, $$DocumentsTableReferences),
      Document,
      PrefetchHooks Function({bool propertyId, bool linkedAssetId})
    >;
typedef $$AppSettingsTableTableCreateCompanionBuilder =
    AppSettingsTableCompanion Function({
      Value<int> id,
      Value<String> themeMode,
      Value<String> themeColor,
      Value<String> measurementUnit,
      Value<String> currency,
      Value<String> currencySymbol,
      Value<bool> notificationsEnabled,
      Value<int> defaultReminderDays,
      Value<bool> showCompletedTasks,
      Value<String?> currentPropertyId,
      Value<bool> hasCompletedOnboarding,
      Value<DateTime?> lastBackupDate,
    });
typedef $$AppSettingsTableTableUpdateCompanionBuilder =
    AppSettingsTableCompanion Function({
      Value<int> id,
      Value<String> themeMode,
      Value<String> themeColor,
      Value<String> measurementUnit,
      Value<String> currency,
      Value<String> currencySymbol,
      Value<bool> notificationsEnabled,
      Value<int> defaultReminderDays,
      Value<bool> showCompletedTasks,
      Value<String?> currentPropertyId,
      Value<bool> hasCompletedOnboarding,
      Value<DateTime?> lastBackupDate,
    });

class $$AppSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableFilterComposer({
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

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeColor => $composableBuilder(
    column: $table.themeColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get measurementUnit => $composableBuilder(
    column: $table.measurementUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencySymbol => $composableBuilder(
    column: $table.currencySymbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultReminderDays => $composableBuilder(
    column: $table.defaultReminderDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showCompletedTasks => $composableBuilder(
    column: $table.showCompletedTasks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentPropertyId => $composableBuilder(
    column: $table.currentPropertyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasCompletedOnboarding => $composableBuilder(
    column: $table.hasCompletedOnboarding,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastBackupDate => $composableBuilder(
    column: $table.lastBackupDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableOrderingComposer({
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

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeColor => $composableBuilder(
    column: $table.themeColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get measurementUnit => $composableBuilder(
    column: $table.measurementUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencySymbol => $composableBuilder(
    column: $table.currencySymbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultReminderDays => $composableBuilder(
    column: $table.defaultReminderDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showCompletedTasks => $composableBuilder(
    column: $table.showCompletedTasks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentPropertyId => $composableBuilder(
    column: $table.currentPropertyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasCompletedOnboarding => $composableBuilder(
    column: $table.hasCompletedOnboarding,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastBackupDate => $composableBuilder(
    column: $table.lastBackupDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<String> get themeColor => $composableBuilder(
    column: $table.themeColor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get measurementUnit => $composableBuilder(
    column: $table.measurementUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get currencySymbol => $composableBuilder(
    column: $table.currencySymbol,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultReminderDays => $composableBuilder(
    column: $table.defaultReminderDays,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showCompletedTasks => $composableBuilder(
    column: $table.showCompletedTasks,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currentPropertyId => $composableBuilder(
    column: $table.currentPropertyId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasCompletedOnboarding => $composableBuilder(
    column: $table.hasCompletedOnboarding,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastBackupDate => $composableBuilder(
    column: $table.lastBackupDate,
    builder: (column) => column,
  );
}

class $$AppSettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTableTable,
          AppSettingsTableData,
          $$AppSettingsTableTableFilterComposer,
          $$AppSettingsTableTableOrderingComposer,
          $$AppSettingsTableTableAnnotationComposer,
          $$AppSettingsTableTableCreateCompanionBuilder,
          $$AppSettingsTableTableUpdateCompanionBuilder,
          (
            AppSettingsTableData,
            BaseReferences<
              _$AppDatabase,
              $AppSettingsTableTable,
              AppSettingsTableData
            >,
          ),
          AppSettingsTableData,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableTableManager(
    _$AppDatabase db,
    $AppSettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String> themeColor = const Value.absent(),
                Value<String> measurementUnit = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> currencySymbol = const Value.absent(),
                Value<bool> notificationsEnabled = const Value.absent(),
                Value<int> defaultReminderDays = const Value.absent(),
                Value<bool> showCompletedTasks = const Value.absent(),
                Value<String?> currentPropertyId = const Value.absent(),
                Value<bool> hasCompletedOnboarding = const Value.absent(),
                Value<DateTime?> lastBackupDate = const Value.absent(),
              }) => AppSettingsTableCompanion(
                id: id,
                themeMode: themeMode,
                themeColor: themeColor,
                measurementUnit: measurementUnit,
                currency: currency,
                currencySymbol: currencySymbol,
                notificationsEnabled: notificationsEnabled,
                defaultReminderDays: defaultReminderDays,
                showCompletedTasks: showCompletedTasks,
                currentPropertyId: currentPropertyId,
                hasCompletedOnboarding: hasCompletedOnboarding,
                lastBackupDate: lastBackupDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String> themeColor = const Value.absent(),
                Value<String> measurementUnit = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> currencySymbol = const Value.absent(),
                Value<bool> notificationsEnabled = const Value.absent(),
                Value<int> defaultReminderDays = const Value.absent(),
                Value<bool> showCompletedTasks = const Value.absent(),
                Value<String?> currentPropertyId = const Value.absent(),
                Value<bool> hasCompletedOnboarding = const Value.absent(),
                Value<DateTime?> lastBackupDate = const Value.absent(),
              }) => AppSettingsTableCompanion.insert(
                id: id,
                themeMode: themeMode,
                themeColor: themeColor,
                measurementUnit: measurementUnit,
                currency: currency,
                currencySymbol: currencySymbol,
                notificationsEnabled: notificationsEnabled,
                defaultReminderDays: defaultReminderDays,
                showCompletedTasks: showCompletedTasks,
                currentPropertyId: currentPropertyId,
                hasCompletedOnboarding: hasCompletedOnboarding,
                lastBackupDate: lastBackupDate,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTableTable,
      AppSettingsTableData,
      $$AppSettingsTableTableFilterComposer,
      $$AppSettingsTableTableOrderingComposer,
      $$AppSettingsTableTableAnnotationComposer,
      $$AppSettingsTableTableCreateCompanionBuilder,
      $$AppSettingsTableTableUpdateCompanionBuilder,
      (
        AppSettingsTableData,
        BaseReferences<
          _$AppDatabase,
          $AppSettingsTableTable,
          AppSettingsTableData
        >,
      ),
      AppSettingsTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PropertiesTableTableManager get properties =>
      $$PropertiesTableTableManager(_db, _db.properties);
  $$AssetsTableTableManager get assets =>
      $$AssetsTableTableManager(_db, _db.assets);
  $$MaintenanceTasksTableTableManager get maintenanceTasks =>
      $$MaintenanceTasksTableTableManager(_db, _db.maintenanceTasks);
  $$ContractorsTableTableManager get contractors =>
      $$ContractorsTableTableManager(_db, _db.contractors);
  $$ServiceRecordsTableTableManager get serviceRecords =>
      $$ServiceRecordsTableTableManager(_db, _db.serviceRecords);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db, _db.documents);
  $$AppSettingsTableTableTableManager get appSettingsTable =>
      $$AppSettingsTableTableTableManager(_db, _db.appSettingsTable);
}
