import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
          _buildSection('Appearance', [
            ListTile(
              title: const Text('Dark Theme'),
              trailing: const Icon(Icons.brightness_4),
              onTap: () {
                // TODO: Switch theme
              },
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection('About', [
            const ListTile(title: Text('Version'), subtitle: Text('1.0.0')),
            const ListTile(title: Text('Privacy Policy')),
          ]),
        ],
      ),
    );
  }

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

  Widget _buildToggle(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
