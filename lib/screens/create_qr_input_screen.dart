import 'package:flutter/material.dart';
import 'qr_preview_screen.dart';

class CreateQrInputScreen extends StatefulWidget {
  final String type;

  const CreateQrInputScreen({super.key, required this.type});

  @override
  State<CreateQrInputScreen> createState() => _CreateQrInputScreenState();
}

class _CreateQrInputScreenState extends State<CreateQrInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    switch (widget.type) {
      case 'URL':
        _controllers['url'] = TextEditingController(text: 'https://');
        break;
      case 'Text':
        _controllers['text'] = TextEditingController();
        break;
      case 'WiFi':
        _controllers['ssid'] = TextEditingController();
        _controllers['password'] = TextEditingController();
        break;
      case 'Contact':
        _controllers['name'] = TextEditingController();
        _controllers['phone'] = TextEditingController();
        _controllers['email'] = TextEditingController();
        break;
      case 'Email':
        _controllers['to'] = TextEditingController();
        _controllers['subject'] = TextEditingController();
        _controllers['body'] = TextEditingController();
        break;
      case 'SMS':
        _controllers['phone'] = TextEditingController();
        _controllers['message'] = TextEditingController();
        break;
      default:
        _controllers['data'] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  String _generateContent() {
    switch (widget.type) {
      case 'URL':
        return _controllers['url']!.text;
      case 'Text':
        return _controllers['text']!.text;
      case 'WiFi':
        return 'WIFI:S:${_controllers['ssid']!.text};T:WPA;P:${_controllers['password']!.text};;';
      case 'Contact':
        return 'BEGIN:VCARD\nVERSION:3.0\nN:${_controllers['name']!.text}\nTEL:${_controllers['phone']!.text}\nEMAIL:${_controllers['email']!.text}\nEND:VCARD';
      case 'Email':
        return 'mailto:${_controllers['to']!.text}?subject=${Uri.encodeComponent(_controllers['subject']!.text)}&body=${Uri.encodeComponent(_controllers['body']!.text)}';
      case 'SMS':
        return 'smsto:${_controllers['phone']!.text}:${_controllers['message']!.text}';
      default:
        return _controllers['data']?.text ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New ${widget.type} QR')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ..._buildFields(),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QrPreviewScreen(
                          content: _generateContent(),
                          label: widget.type,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Generate QR Code',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFields() {
    List<Widget> fields = [];
    _controllers.forEach((key, controller) {
      fields.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: key.toUpperCase(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
            ),
            validator: (value) =>
                (value == null || value.isEmpty) ? 'Required' : null,
          ),
        ),
      );
    });
    return fields;
  }
}
