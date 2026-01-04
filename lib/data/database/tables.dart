import 'package:drift/drift.dart';

class Properties extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get address => text().nullable()();
  IntColumn get yearBuilt => integer().nullable()();
  IntColumn get squareFeet => integer().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get coverImagePath => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Assets extends Table {
  TextColumn get id => text()();
  TextColumn get propertyId => text().references(Properties, #id)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get category => text()();
  TextColumn get locationRoom => text().nullable()();
  TextColumn get manufacturer => text().nullable()();
  TextColumn get model => text().nullable()();
  TextColumn get serialNumber => text().nullable()();
  DateTimeColumn get installDate => dateTime().nullable()();
  DateTimeColumn get purchaseDate => dateTime().nullable()();
  DateTimeColumn get warrantyExpirationDate => dateTime().nullable()();
  RealColumn get purchasePrice => real().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get photoPaths => text().withDefault(const Constant('[]'))();
  TextColumn get labelPhotoPath => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class MaintenanceTasks extends Table {
  TextColumn get id => text()();
  TextColumn get propertyId => text().references(Properties, #id)();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get description => text().nullable()();
  TextColumn get instructions => text().nullable()();
  TextColumn get category => text().nullable()();
  TextColumn get frequency => text()();
  IntColumn get customIntervalDays => integer().nullable()();
  TextColumn get season => text().nullable()();
  DateTimeColumn get nextDueDate => dateTime().nullable()();
  DateTimeColumn get lastCompletedDate => dateTime().nullable()();
  TextColumn get linkedAssetIds => text().withDefault(const Constant('[]'))();
  RealColumn get estimatedCost => real().nullable()();
  IntColumn get estimatedTimeMinutes => integer().nullable()();
  BoolColumn get reminderEnabled => boolean().withDefault(const Constant(true))();
  IntColumn get reminderDaysBefore => integer().withDefault(const Constant(3))();
  TextColumn get notes => text().nullable()();
  BoolColumn get isTemplate => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class ServiceRecords extends Table {
  TextColumn get id => text()();
  TextColumn get propertyId => text().references(Properties, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get description => text().nullable()();
  TextColumn get assetIds => text().withDefault(const Constant('[]'))();
  TextColumn get taskId => text().nullable().references(MaintenanceTasks, #id)();
  TextColumn get contractorId => text().nullable().references(Contractors, #id)();
  RealColumn get cost => real().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get attachmentPaths => text().withDefault(const Constant('[]'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Contractors extends Table {
  TextColumn get id => text()();
  TextColumn get propertyId => text().references(Properties, #id)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get companyName => text().nullable()();
  TextColumn get tradeType => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get website => text().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isPreferred => boolean().withDefault(const Constant(false))();
  RealColumn get rating => real().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Documents extends Table {
  TextColumn get id => text()();
  TextColumn get propertyId => text().references(Properties, #id)();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get category => text()();
  TextColumn get filePath => text()();
  TextColumn get linkedAssetId => text().nullable().references(Assets, #id)();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get expirationDate => dateTime().nullable()();
  DateTimeColumn get dateAdded => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class AppSettingsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get themeMode => text().withDefault(const Constant('system'))();
  TextColumn get themeColor => text().withDefault(const Constant('green'))();
  TextColumn get measurementUnit => text().withDefault(const Constant('imperial'))();
  TextColumn get currency => text().withDefault(const Constant('USD'))();
  TextColumn get currencySymbol => text().withDefault(const Constant('\$'))();
  BoolColumn get notificationsEnabled => boolean().withDefault(const Constant(true))();
  IntColumn get defaultReminderDays => integer().withDefault(const Constant(3))();
  BoolColumn get showCompletedTasks => boolean().withDefault(const Constant(false))();
  TextColumn get currentPropertyId => text().nullable()();
  BoolColumn get hasCompletedOnboarding => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastBackupDate => dateTime().nullable()();
}
