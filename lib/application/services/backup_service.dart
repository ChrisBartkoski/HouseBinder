import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/database/database.dart';

class BackupService {
  final AppDatabase _db;

  BackupService(this._db);

  Future<String> exportBackup() async {
    // Gather all data
    final properties = await _db.getAllProperties();
    final allAssets = <Map<String, dynamic>>[];
    final allTasks = <Map<String, dynamic>>[];
    final allRecords = <Map<String, dynamic>>[];
    final allContractors = <Map<String, dynamic>>[];
    final allDocuments = <Map<String, dynamic>>[];

    for (final property in properties) {
      final assets = await _db.getAssetsByProperty(property.id);
      final tasks = await _db.getTasksByProperty(property.id);
      final records = await _db.getServiceRecordsByProperty(property.id);
      final contractors = await _db.getContractorsByProperty(property.id);
      final documents = await _db.getDocumentsByProperty(property.id);

      allAssets.addAll(assets.map((a) => a.toJson()));
      allTasks.addAll(tasks.map((t) => t.toJson()));
      allRecords.addAll(records.map((r) => r.toJson()));
      allContractors.addAll(contractors.map((c) => c.toJson()));
      allDocuments.addAll(documents.map((d) => d.toJson()));
    }

    final settings = await _db.getSettings();

    // Create JSON data
    final data = {
      'version': 1,
      'exportDate': DateTime.now().toIso8601String(),
      'properties': properties.map((p) => p.toJson()).toList(),
      'assets': allAssets,
      'tasks': allTasks,
      'serviceRecords': allRecords,
      'contractors': allContractors,
      'documents': allDocuments,
      'settings': settings.toJson(),
    };

    final jsonString = const JsonEncoder.withIndent('  ').convert(data);

    // Create archive
    final archive = Archive();

    // Add JSON data
    archive.addFile(ArchiveFile(
      'housebinder.json',
      jsonString.length,
      utf8.encode(jsonString),
    ));

    // Add schema version
    archive.addFile(ArchiveFile(
      'schema_version.txt',
      1,
      utf8.encode('1'),
    ));

    // Copy documents/photos to archive (if they exist and are accessible)
    final appDir = await getApplicationDocumentsDirectory();
    final houseBinderDir = Directory(p.join(appDir.path, 'HouseBinder'));

    if (await houseBinderDir.exists()) {
      await _addDirectoryToArchive(archive, houseBinderDir, 'files');
    }

    // Encode archive
    final zipData = ZipEncoder().encode(archive);

    // Save to file
    final backupDir = await getApplicationDocumentsDirectory();
    final fileName =
        'HouseBinder_Backup_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.zip';
    final filePath = p.join(backupDir.path, fileName);
    final file = File(filePath);
    await file.writeAsBytes(zipData);

    // Share the file
    await SharePlus.instance.share(ShareParams(files: [XFile(filePath)], subject: 'HouseBinder Backup'));

    return filePath;
  }

  Future<void> _addDirectoryToArchive(
      Archive archive, Directory dir, String archivePath) async {
    await for (final entity in dir.list(recursive: true)) {
      if (entity is File) {
        final relativePath = p.relative(entity.path, from: dir.path);
        final archiveFilePath = p.join(archivePath, relativePath);
        final bytes = await entity.readAsBytes();
        archive.addFile(ArchiveFile(archiveFilePath, bytes.length, bytes));
      }
    }
  }

  Future<void> importBackup() async {
    // Pick file
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip'],
    );

    if (result == null || result.files.single.path == null) {
      throw Exception('No file selected');
    }

    final file = File(result.files.single.path!);
    final bytes = await file.readAsBytes();

    // Decode archive
    final archive = ZipDecoder().decodeBytes(bytes);

    // Find and parse JSON data
    final jsonFile = archive.findFile('housebinder.json');
    if (jsonFile == null) {
      throw Exception('Invalid backup file: missing housebinder.json');
    }

    final jsonString = utf8.decode(jsonFile.content as List<int>);
    final data = jsonDecode(jsonString) as Map<String, dynamic>;

    // Verify version
    final version = data['version'] as int?;
    if (version != 1) {
      throw Exception('Unsupported backup version: $version');
    }

    // Import properties
    final propertiesJson = data['properties'] as List<dynamic>;
    for (final json in propertiesJson) {
      final map = json as Map<String, dynamic>;
      final companion = _propertyFromJson(map);
      try {
        await _db.insertProperty(companion);
      } catch (e) {
        await _db.updatePropertyById(map['id'] as String, companion);
      }
    }

    // Import assets
    final assetsJson = data['assets'] as List<dynamic>;
    for (final json in assetsJson) {
      final map = json as Map<String, dynamic>;
      final companion = _assetFromJson(map);
      try {
        await _db.insertAsset(companion);
      } catch (e) {
        await _db.updateAssetById(map['id'] as String, companion);
      }
    }

    // Import tasks
    final tasksJson = data['tasks'] as List<dynamic>;
    for (final json in tasksJson) {
      final map = json as Map<String, dynamic>;
      final companion = _taskFromJson(map);
      try {
        await _db.insertTask(companion);
      } catch (e) {
        await _db.updateTaskById(map['id'] as String, companion);
      }
    }

    // Import service records
    final recordsJson = data['serviceRecords'] as List<dynamic>;
    for (final json in recordsJson) {
      final map = json as Map<String, dynamic>;
      final companion = _serviceRecordFromJson(map);
      try {
        await _db.insertServiceRecord(companion);
      } catch (e) {
        await _db.updateServiceRecordById(map['id'] as String, companion);
      }
    }

    // Import contractors
    final contractorsJson = data['contractors'] as List<dynamic>;
    for (final json in contractorsJson) {
      final map = json as Map<String, dynamic>;
      final companion = _contractorFromJson(map);
      try {
        await _db.insertContractor(companion);
      } catch (e) {
        await _db.updateContractorById(map['id'] as String, companion);
      }
    }

    // Import documents
    final documentsJson = data['documents'] as List<dynamic>;
    for (final json in documentsJson) {
      final map = json as Map<String, dynamic>;
      final companion = _documentFromJson(map);
      try {
        await _db.insertDocument(companion);
      } catch (e) {
        await _db.updateDocumentById(map['id'] as String, companion);
      }
    }

    // Import settings
    if (data['settings'] != null) {
      final settingsMap = data['settings'] as Map<String, dynamic>;
      await _db.updateSettings(AppSettingsTableCompanion(
        themeMode: Value(settingsMap['themeMode'] as String? ?? 'system'),
        themeColor: Value(settingsMap['themeColor'] as String? ?? 'green'),
        measurementUnit:
            Value(settingsMap['measurementUnit'] as String? ?? 'imperial'),
        currency: Value(settingsMap['currency'] as String? ?? 'USD'),
        currencySymbol: Value(settingsMap['currencySymbol'] as String? ?? '\$'),
        notificationsEnabled:
            Value(settingsMap['notificationsEnabled'] as bool? ?? true),
        defaultReminderDays:
            Value(settingsMap['defaultReminderDays'] as int? ?? 3),
        showCompletedTasks:
            Value(settingsMap['showCompletedTasks'] as bool? ?? false),
        currentPropertyId: Value(settingsMap['currentPropertyId'] as String?),
        hasCompletedOnboarding:
            Value(settingsMap['hasCompletedOnboarding'] as bool? ?? false),
      ));
    }

    // Extract files from archive
    final appDir = await getApplicationDocumentsDirectory();
    final houseBinderDir = Directory(p.join(appDir.path, 'HouseBinder'));

    for (final archiveFile in archive) {
      if (archiveFile.name.startsWith('files/')) {
        final relativePath =
            archiveFile.name.substring(6); // Remove 'files/' prefix
        final destPath = p.join(houseBinderDir.path, relativePath);
        final destFile = File(destPath);
        await destFile.parent.create(recursive: true);
        await destFile.writeAsBytes(archiveFile.content as List<int>);
      }
    }
  }

  PropertiesCompanion _propertyFromJson(Map<String, dynamic> json) {
    return PropertiesCompanion(
      id: Value(json['id'] as String),
      name: Value(json['name'] as String),
      address: Value(json['address'] as String?),
      yearBuilt: Value(json['yearBuilt'] as int?),
      squareFeet: Value(json['squareFeet'] as int?),
      notes: Value(json['notes'] as String?),
      coverImagePath: Value(json['coverImagePath'] as String?),
      createdAt: Value(DateTime.parse(json['createdAt'] as String)),
      updatedAt: Value(DateTime.parse(json['updatedAt'] as String)),
    );
  }

  AssetsCompanion _assetFromJson(Map<String, dynamic> json) {
    return AssetsCompanion(
      id: Value(json['id'] as String),
      propertyId: Value(json['propertyId'] as String),
      name: Value(json['name'] as String),
      category: Value(json['category'] as String),
      locationRoom: Value(json['locationRoom'] as String?),
      manufacturer: Value(json['manufacturer'] as String?),
      model: Value(json['model'] as String?),
      serialNumber: Value(json['serialNumber'] as String?),
      installDate: Value(json['installDate'] != null
          ? DateTime.parse(json['installDate'] as String)
          : null),
      purchaseDate: Value(json['purchaseDate'] != null
          ? DateTime.parse(json['purchaseDate'] as String)
          : null),
      warrantyExpirationDate: Value(json['warrantyExpirationDate'] != null
          ? DateTime.parse(json['warrantyExpirationDate'] as String)
          : null),
      purchasePrice: Value((json['purchasePrice'] as num?)?.toDouble()),
      notes: Value(json['notes'] as String?),
      photoPaths: Value(json['photoPaths'] as String),
      labelPhotoPath: Value(json['labelPhotoPath'] as String?),
      createdAt: Value(DateTime.parse(json['createdAt'] as String)),
      updatedAt: Value(DateTime.parse(json['updatedAt'] as String)),
    );
  }

  MaintenanceTasksCompanion _taskFromJson(Map<String, dynamic> json) {
    return MaintenanceTasksCompanion(
      id: Value(json['id'] as String),
      propertyId: Value(json['propertyId'] as String),
      title: Value(json['title'] as String),
      description: Value(json['description'] as String?),
      instructions: Value(json['instructions'] as String?),
      category: Value(json['category'] as String?),
      frequency: Value(json['frequency'] as String),
      customIntervalDays: Value(json['customIntervalDays'] as int?),
      season: Value(json['season'] as String?),
      nextDueDate: Value(json['nextDueDate'] != null
          ? DateTime.parse(json['nextDueDate'] as String)
          : null),
      lastCompletedDate: Value(json['lastCompletedDate'] != null
          ? DateTime.parse(json['lastCompletedDate'] as String)
          : null),
      linkedAssetIds: Value(json['linkedAssetIds'] as String),
      estimatedCost: Value((json['estimatedCost'] as num?)?.toDouble()),
      estimatedTimeMinutes: Value(json['estimatedTimeMinutes'] as int?),
      reminderEnabled: Value(json['reminderEnabled'] as bool? ?? true),
      reminderDaysBefore: Value(json['reminderDaysBefore'] as int? ?? 3),
      notes: Value(json['notes'] as String?),
      isTemplate: Value(json['isTemplate'] as bool? ?? false),
      createdAt: Value(DateTime.parse(json['createdAt'] as String)),
      updatedAt: Value(DateTime.parse(json['updatedAt'] as String)),
    );
  }

  ServiceRecordsCompanion _serviceRecordFromJson(Map<String, dynamic> json) {
    return ServiceRecordsCompanion(
      id: Value(json['id'] as String),
      propertyId: Value(json['propertyId'] as String),
      date: Value(DateTime.parse(json['date'] as String)),
      title: Value(json['title'] as String),
      description: Value(json['description'] as String?),
      assetIds: Value(json['assetIds'] as String),
      taskId: Value(json['taskId'] as String?),
      contractorId: Value(json['contractorId'] as String?),
      cost: Value((json['cost'] as num?)?.toDouble()),
      notes: Value(json['notes'] as String?),
      attachmentPaths: Value(json['attachmentPaths'] as String),
      createdAt: Value(DateTime.parse(json['createdAt'] as String)),
      updatedAt: Value(DateTime.parse(json['updatedAt'] as String)),
    );
  }

  ContractorsCompanion _contractorFromJson(Map<String, dynamic> json) {
    return ContractorsCompanion(
      id: Value(json['id'] as String),
      propertyId: Value(json['propertyId'] as String),
      name: Value(json['name'] as String),
      companyName: Value(json['companyName'] as String?),
      tradeType: Value(json['tradeType'] as String),
      phone: Value(json['phone'] as String?),
      email: Value(json['email'] as String?),
      address: Value(json['address'] as String?),
      website: Value(json['website'] as String?),
      notes: Value(json['notes'] as String?),
      isPreferred: Value(json['isPreferred'] as bool? ?? false),
      rating: Value((json['rating'] as num?)?.toDouble()),
      createdAt: Value(DateTime.parse(json['createdAt'] as String)),
      updatedAt: Value(DateTime.parse(json['updatedAt'] as String)),
    );
  }

  DocumentsCompanion _documentFromJson(Map<String, dynamic> json) {
    return DocumentsCompanion(
      id: Value(json['id'] as String),
      propertyId: Value(json['propertyId'] as String),
      title: Value(json['title'] as String),
      category: Value(json['category'] as String),
      filePath: Value(json['filePath'] as String),
      linkedAssetId: Value(json['linkedAssetId'] as String?),
      notes: Value(json['notes'] as String?),
      expirationDate: Value(json['expirationDate'] != null
          ? DateTime.parse(json['expirationDate'] as String)
          : null),
      dateAdded: Value(DateTime.parse(json['dateAdded'] as String)),
      createdAt: Value(DateTime.parse(json['createdAt'] as String)),
      updatedAt: Value(DateTime.parse(json['updatedAt'] as String)),
    );
  }
}
