import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'create_qr_input_screen.dart';

class GenerateScreen extends StatelessWidget {
  const GenerateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'label': 'URL', 'icon': FontAwesomeIcons.link, 'color': Colors.blue},
      {
        'label': 'Text',
        'icon': FontAwesomeIcons.alignLeft,
        'color': Colors.orange,
      },
      {'label': 'WiFi', 'icon': FontAwesomeIcons.wifi, 'color': Colors.purple},
      {
        'label': 'Contact',
        'icon': FontAwesomeIcons.user,
        'color': Colors.green,
      },
      {
        'label': 'Email',
        'icon': FontAwesomeIcons.envelope,
        'color': Colors.red,
      },
      {'label': 'SMS', 'icon': FontAwesomeIcons.message, 'color': Colors.teal},
      {
        'label': 'Phone',
        'icon': FontAwesomeIcons.phone,
        'color': Colors.indigo,
      },
      {
        'label': 'Geo',
        'icon': FontAwesomeIcons.locationDot,
        'color': Colors.amber,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Create QR Code')),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CreateQrInputScreen(type: item['label']),
                ),
              );
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: item['color'].withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(item['icon'], color: item['color'], size: 28),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item['label'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
