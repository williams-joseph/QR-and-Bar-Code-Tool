import 'package:hive/hive.dart';

part 'scan_item.g.dart';

@HiveType(typeId: 0)
class ScanItem {
  @HiveField(0)
  final String content;

  @HiveField(1)
  final String type; // 'qr' or 'barcode'

  @HiveField(2)
  final String format; // EAN_13, QR_CODE, etc.

  @HiveField(3)
  final DateTime timestamp;

  @HiveField(4)
  final String category; // 'URL', 'WIFI', 'CONTACT', etc.

  ScanItem({
    required this.content,
    required this.type,
    required this.format,
    required this.timestamp,
    required this.category,
  });
}
