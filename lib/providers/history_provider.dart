import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scan_item.dart';
import '../models/scan_history_item.dart';
import '../services/hive_service.dart';

final historyProvider =
    NotifierProvider<HistoryNotifier, List<ScanHistoryItem>>(() {
      return HistoryNotifier();
    });

class HistoryNotifier extends Notifier<List<ScanHistoryItem>> {
  @override
  List<ScanHistoryItem> build() {
    return HiveService.getAllScans();
  }

  Future<void> addScan(ScanItem item) async {
    await HiveService.addScan(item);
    state = HiveService.getAllScans();
  }

  Future<void> deleteScan(dynamic key) async {
    await HiveService.deleteScan(key);
    state = HiveService.getAllScans();
  }

  Future<void> clearAll() async {
    await HiveService.clearHistory();
    state = HiveService.getAllScans();
  }
}
