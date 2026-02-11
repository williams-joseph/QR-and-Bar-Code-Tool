import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scan_master/providers/theme_provider.dart';

/// A screen that provides various configuration options for the application.
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  // Local state for toggling various scanner settings.
  bool _autofocus = true;
  bool _vibrate = true;
  bool _beep = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Section for scanner-specific configuration.
          _buildSection('App Settings', [
            _buildToggle(
              'Autofocus',
              _autofocus,
              (v) => setState(() => _autofocus = v),
            ),
            _buildToggle(
              'Vibrate on Scan',
              _vibrate,
              (v) => setState(() => _vibrate = v),
            ),
            _buildToggle(
              'Beep on Scan',
              _beep,
              (v) => setState(() => _beep = v),
            ),
          ]),
          const SizedBox(height: 24),
          // Section for theme and appearance configuration.
          _buildSection('Appearance', [
            ListTile(
              title: const Text('Dark Theme'),
              trailing: const Icon(Icons.brightness_4),
              onTap: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
            ),
          ]),
          const SizedBox(height: 24),
          // Section for general application information.
          _buildSection('About', [
            const ListTile(title: Text('Version'), subtitle: Text('1.0.0')),
            const ListTile(title: Text('Privacy Policy')),
          ]),
        ],
      ),
    );
  }

  /// Helper widget to build a titled section of settings items grouped in a card.
  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        Card(child: Column(children: children)),
      ],
    );
  }

  /// Helper widget to build a simple switch list tile for toggling settings.
  Widget _buildToggle(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
