import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scan_history_item.dart';
import '../screens/result_screen.dart';
import '../providers/history_provider.dart';

class HistoryList extends ConsumerWidget {
  final List<ScanHistoryItem> history;

  const HistoryList({super.key, required this.history});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (context, index) {
        final historyItem = history[index];
        final item = historyItem.item;
        return ListTile(
          title: Text(item.content),
          subtitle: Text(item.format),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              ref.read(historyProvider.notifier).deleteScan(historyItem.key);
            },
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultScreen(item: item),
              ),
            );
          },
        );
      },
    );
  }
}
