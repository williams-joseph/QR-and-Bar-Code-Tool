import 'scan_item.dart';

/// Represents an item in the scan history, including its unique storage key.
class ScanHistoryItem {
  /// The unique key used to identify the item in local storage.
  final dynamic key;
  /// The actual scanned data and metadata.
  final ScanItem item;

  ScanHistoryItem({required this.key, required this.item});
}
