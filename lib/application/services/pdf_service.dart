import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../providers/providers.dart';

class PdfService {
  final WidgetRef _ref;

  PdfService(this._ref);

  Future<String> generateHouseBinderReport({
    bool includeAssets = true,
    bool includeWarranties = true,
    bool includeTasks = true,
    bool includeServiceHistory = true,
    int serviceHistoryMonths = 12,
    bool includeContractors = true,
    bool includeDocumentIndex = true,
  }) async {
    final property = await _ref.read(currentPropertyProvider.future);
    if (property == null) {
      throw Exception('No property selected');
    }

    final pdf = pw.Document();
    final dateFormat = DateFormat.yMMMd();
    final currencyFormat = NumberFormat.currency(symbol: '\$');

    // Get all data
    final assets = includeAssets ? await _ref.read(assetsProvider.future) : [];
    final tasks = includeTasks ? await _ref.read(tasksProvider.future) : [];
    final records =
        includeServiceHistory ? await _ref.read(serviceRecordsProvider.future) : [];
    final contractors =
        includeContractors ? await _ref.read(contractorsProvider.future) : [];
    final documents =
        includeDocumentIndex ? await _ref.read(documentsProvider.future) : [];

    // Filter service history by date
    final filteredRecords = serviceHistoryMonths > 0
        ? records.where((r) {
            final cutoff = DateTime.now().subtract(Duration(days: serviceHistoryMonths * 30));
            return r.date.isAfter(cutoff);
          }).toList()
        : records;

    // Expiring warranties
    final expiringWarranties = assets.where((a) => a.isWarrantyExpiringSoon).toList();

    // Cover Page
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.letter,
        build: (context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'House Binder',
                  style: pw.TextStyle(
                    fontSize: 42,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  property.name,
                  style: pw.TextStyle(
                    fontSize: 28,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                if (property.address != null) ...[
                  pw.SizedBox(height: 10),
                  pw.Text(
                    property.address!,
                    style: const pw.TextStyle(fontSize: 16),
                  ),
                ],
                pw.SizedBox(height: 40),
                pw.Text(
                  'Generated: ${dateFormat.format(DateTime.now())}',
                  style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
                ),
              ],
            ),
          );
        },
      ),
    );

    // Table of Contents
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.letter,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Table of Contents',
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 20),
              if (includeAssets) _tocItem('Asset Inventory', assets.length),
              if (includeWarranties && expiringWarranties.isNotEmpty)
                _tocItem('Expiring Warranties', expiringWarranties.length),
              if (includeTasks) _tocItem('Maintenance Tasks', tasks.length),
              if (includeServiceHistory)
                _tocItem('Service History', filteredRecords.length),
              if (includeContractors)
                _tocItem('Service Providers', contractors.length),
              if (includeDocumentIndex)
                _tocItem('Document Index', documents.length),
            ],
          );
        },
      ),
    );

    // Asset Inventory
    if (includeAssets && assets.isNotEmpty) {
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.letter,
          header: (context) => pw.Text(
            'Asset Inventory',
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
          build: (context) {
            return [
              pw.TableHelper.fromTextArray(
                headers: ['Name', 'Category', 'Location', 'Manufacturer', 'Model'],
                data: assets
                    .map((a) => [
                          a.name,
                          a.categoryEnum.displayName,
                          a.locationRoom ?? '-',
                          a.manufacturer ?? '-',
                          a.model ?? '-',
                        ])
                    .toList(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
                cellPadding: const pw.EdgeInsets.all(5),
              ),
            ];
          },
        ),
      );
    }

    // Expiring Warranties
    if (includeWarranties && expiringWarranties.isNotEmpty) {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.letter,
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Expiring Warranties (Next 90 Days)',
                  style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 20),
                pw.TableHelper.fromTextArray(
                  headers: ['Asset', 'Expiration Date', 'Days Remaining'],
                  data: expiringWarranties
                      .map((a) => [
                            a.name,
                            dateFormat.format(a.warrantyExpirationDate!),
                            '${a.warrantyExpirationDate!.difference(DateTime.now()).inDays} days',
                          ])
                      .toList(),
                  headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
                  cellPadding: const pw.EdgeInsets.all(5),
                ),
              ],
            );
          },
        ),
      );
    }

    // Maintenance Tasks
    if (includeTasks && tasks.isNotEmpty) {
      final overdueTasks = tasks.where((t) => t.isOverdue).toList();
      final upcomingTasks = tasks.where((t) => !t.isOverdue).toList();

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.letter,
          header: (context) => pw.Text(
            'Maintenance Tasks',
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
          build: (context) {
            return [
              if (overdueTasks.isNotEmpty) ...[
                pw.Text(
                  'Overdue (${overdueTasks.length})',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.red,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.TableHelper.fromTextArray(
                  headers: ['Task', 'Due Date', 'Frequency'],
                  data: overdueTasks
                      .map((t) => [
                            t.title,
                            t.nextDueDate != null ? dateFormat.format(t.nextDueDate!) : '-',
                            t.frequencyEnum.displayName,
                          ])
                      .toList(),
                  headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  headerDecoration: const pw.BoxDecoration(color: PdfColors.red100),
                  cellPadding: const pw.EdgeInsets.all(5),
                ),
                pw.SizedBox(height: 20),
              ],
              pw.Text(
                'Upcoming (${upcomingTasks.length})',
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              pw.TableHelper.fromTextArray(
                headers: ['Task', 'Due Date', 'Frequency'],
                data: upcomingTasks
                    .map((t) => [
                          t.title,
                          t.nextDueDate != null ? dateFormat.format(t.nextDueDate!) : '-',
                          t.frequencyEnum.displayName,
                        ])
                    .toList(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
                cellPadding: const pw.EdgeInsets.all(5),
              ),
            ];
          },
        ),
      );
    }

    // Service History
    if (includeServiceHistory && filteredRecords.isNotEmpty) {
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.letter,
          header: (context) => pw.Text(
            'Service History',
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
          build: (context) {
            return [
              pw.TableHelper.fromTextArray(
                headers: ['Date', 'Description', 'Cost'],
                data: filteredRecords
                    .map((r) => [
                          dateFormat.format(r.date),
                          r.title,
                          r.cost != null ? currencyFormat.format(r.cost) : '-',
                        ])
                    .toList(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
                cellPadding: const pw.EdgeInsets.all(5),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Total: ${currencyFormat.format(filteredRecords.fold(0.0, (sum, r) => sum + (r.cost ?? 0)))}',
                style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
              ),
            ];
          },
        ),
      );
    }

    // Contractors
    if (includeContractors && contractors.isNotEmpty) {
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.letter,
          header: (context) => pw.Text(
            'Service Providers',
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
          build: (context) {
            return [
              pw.TableHelper.fromTextArray(
                headers: ['Name', 'Trade', 'Phone', 'Email'],
                data: contractors
                    .map((c) => [
                          c.displayName,
                          c.tradeTypeEnum.displayName,
                          c.phone ?? '-',
                          c.email ?? '-',
                        ])
                    .toList(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
                cellPadding: const pw.EdgeInsets.all(5),
              ),
            ];
          },
        ),
      );
    }

    // Document Index
    if (includeDocumentIndex && documents.isNotEmpty) {
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.letter,
          header: (context) => pw.Text(
            'Document Index',
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
          build: (context) {
            return [
              pw.TableHelper.fromTextArray(
                headers: ['Title', 'Category', 'Date Added'],
                data: documents
                    .map((d) => [
                          d.title,
                          d.categoryEnum.displayName,
                          dateFormat.format(d.dateAdded),
                        ])
                    .toList(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
                cellPadding: const pw.EdgeInsets.all(5),
              ),
            ];
          },
        ),
      );
    }

    // Save PDF
    final appDir = await getApplicationDocumentsDirectory();
    final reportsDir = Directory(p.join(appDir.path, 'HouseBinder', 'reports'));
    if (!await reportsDir.exists()) {
      await reportsDir.create(recursive: true);
    }

    final fileName = 'HouseBinder_${property.name.replaceAll(' ', '_')}_${DateFormat('yyyyMMdd').format(DateTime.now())}.pdf';
    final filePath = p.join(reportsDir.path, fileName);
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Share the file
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(filePath)],
        subject: 'House Binder Report - ${property.name}',
      ),
    );

    return filePath;
  }

  pw.Widget _tocItem(String title, int count) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 5),
      child: pw.Row(
        children: [
          pw.Text(title),
          pw.Expanded(
            child: pw.Container(
              margin: const pw.EdgeInsets.symmetric(horizontal: 10),
              decoration: const pw.BoxDecoration(
                border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey400)),
              ),
            ),
          ),
          pw.Text('$count items'),
        ],
      ),
    );
  }
}
