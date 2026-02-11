import 'package:hive_flutter/hive_flutter.dart';
import '../models/scan_item.dart';
import '../models/scan_history_item.dart';

class HiveService {
  static const String scanBoxName = 'history';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ScanItemAdapter());
    await Hive.openBox<ScanItem>(scanBoxName);
  }

  static Box<ScanItem> getScanBox() => Hive.box<ScanItem>(scanBoxName);

  static List<ScanHistoryItem> getAllScans() {
    final box = getScanBox();
    return box.keys
        .map((key) {
          final item = box.get(key) as ScanItem;
          return ScanHistoryItem(key: key, item: item);
        })
        .toList()
        .reversed
        .toList();
  }

  static Future<int> addScan(ScanItem item) async {
    return await getScanBox().add(item);
  }

  static Future<void> deleteScan(dynamic key) async {
    await getScanBox().delete(key);
  }

  static Future<void> clearHistory() async {
    await getScanBox().clear();
  }
}
