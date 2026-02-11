import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scan_item.dart';
import '../models/scan_history_item.dart';
import '../services/hive_service.dart';

/// A provider that manages the scan history state using a Notifier.
final historyProvider =
    NotifierProvider<HistoryNotifier, List<ScanHistoryItem>>(() {
      return HistoryNotifier();
    });

/// A notifier that manages the list of `ScanHistoryItem` objects and interacts with the storage service.
class HistoryNotifier extends Notifier<List<ScanHistoryItem>> {
  @override
  List<ScanHistoryItem> build() {
    // Initialize the state with all scans retrieved from storage.
    return HiveService.getAllScans();
  }

  /// Adds a new scan to storage and updates the current state.
  Future<void> addScan(ScanItem item) async {
    await HiveService.addScan(item);
    state = HiveService.getAllScans();
  }

  /// Deletes a scan from storage by its key and updates the current state.
  Future<void> deleteScan(dynamic key) async {
    await HiveService.deleteScan(key);
    state = HiveService.getAllScans();
  }

  /// Clears all scan history from storage and updates the current state.
  Future<void> clearAll() async {
    await HiveService.clearHistory();
    state = HiveService.getAllScans();
  }
}
