import 'package:hive/hive.dart';

part 'scan_item.g.dart';

/// Data model for a scanned QR code or barcode, annotated for Hive storage.
@HiveType(typeId: 0)
class ScanItem {
  /// The raw content of the scanned code (e.g., a URL or plain text).
  @HiveField(0)
  final String content;

  /// The broad type of the scanned item, typically 'qr' or 'barcode'.
  @HiveField(1)
  final String type;

  /// The specific format of the scanned code (e.g., 'QR_CODE', 'EAN_13').
  @HiveField(2)
  final String format;

  /// The date and time when the scan was performed.
  @HiveField(3)
  final DateTime timestamp;

  /// The categorized content of the scan (e.g., 'URL', 'WIFI', 'CONTACT').
  @HiveField(4)
  final String category;

  ScanItem({
    required this.content,
    required this.type,
    required this.format,
    required this.timestamp,
    required this.category,
  });
}
