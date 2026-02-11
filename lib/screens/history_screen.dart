import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/history_provider.dart';
import '../widgets/history_list.dart';
import '../widgets/banner_ad_widget.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () => ref.read(historyProvider.notifier).clearAll(),
          ),
        ],
      ),
      body: history.isEmpty
          ? const Center(child: Text('No history yet.'))
          : HistoryList(history: history),
      bottomNavigationBar: const BannerAdWidget(),
    );
  }
}
