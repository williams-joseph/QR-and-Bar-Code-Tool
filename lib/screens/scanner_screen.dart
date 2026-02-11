import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../models/scan_item.dart';
import '../providers/history_provider.dart';
import 'result_screen.dart';

class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  ConsumerState<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen> {
  final MobileScannerController controller = MobileScannerController();
  bool _isScanning = true;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _processBarcode(String code, BarcodeFormat format) async {
    final scanItem = ScanItem(
      content: code,
      type: format == BarcodeFormat.qrCode ? 'qr' : 'barcode',
      format: format.name,
      timestamp: DateTime.now(),
      category: _getCategory(code),
    );

    // Save to history
    await ref.read(historyProvider.notifier).addScan(scanItem);

    if (!mounted) return;

    // Navigate to result
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultScreen(item: scanItem)),
    );
  }

  void _onDetect(BarcodeCapture capture) async {
    if (!_isScanning) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final barcode = barcodes.first;
      final String code = barcode.rawValue ?? "";

      if (code.isNotEmpty) {
        setState(() => _isScanning = false);
        await _processBarcode(code, barcode.format);
        setState(() => _isScanning = true);
      }
    }
  }

  Future<void> _scanFromGallery() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final barcodes = await controller.analyzeImage(image.path);
      if (barcodes != null && barcodes.barcodes.isNotEmpty) {
        final barcode = barcodes.barcodes.first;
        final String code = barcode.rawValue ?? "";
        if (code.isNotEmpty) {
          if (!mounted) return;
          await _processBarcode(code, barcode.format);
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No QR code found in image')),
          );
        }
      }
    }
  }

  String _getCategory(String content) {
    if (content.startsWith('http')) return 'URL';
    if (content.startsWith('WIFI:')) return 'WIFI';
    if (content.startsWith('BEGIN:VCARD')) return 'CONTACT';
    if (content.startsWith('mailto:')) return 'EMAIL';
    if (content.startsWith('tel:')) return 'PHONE';
    if (content.startsWith('smsto:')) return 'SMS';
    return 'TEXT';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(controller: controller, onDetect: _onDetect),
          // Viewfinder Overlay
          _buildViewfinder(context),
          // Controls
          _buildControls(context),
        ],
      ),
    );
  }

  Widget _buildViewfinder(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.5),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            // Corner Accents
            ..._buildCorners(context),
            // Scanning Line Animation would go here
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCorners(BuildContext context) {
    const double length = 30;
    const double thickness = 4;
    final color = Theme.of(context).primaryColor;

    return [
      Positioned(
        top: 0,
        left: 0,
        child: Container(width: length, height: thickness, color: color),
      ),
      Positioned(
        top: 0,
        left: 0,
        child: Container(width: thickness, height: length, color: color),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: Container(width: length, height: thickness, color: color),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: Container(width: thickness, height: length, color: color),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: Container(width: length, height: thickness, color: color),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: Container(width: thickness, height: length, color: color),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(width: length, height: thickness, color: color),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(width: thickness, height: length, color: color),
      ),
    ];
  }

  Widget _buildControls(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _circularButton(Icons.image, _scanFromGallery),
                _circularButton(Icons.flash_on, () {
                  controller.toggleTorch();
                }),
              ],
            ),
            const Spacer(),
            Text(
              'Align the code within the frame',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                shadows: [Shadow(color: Colors.black, blurRadius: 4)],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _circularButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}
