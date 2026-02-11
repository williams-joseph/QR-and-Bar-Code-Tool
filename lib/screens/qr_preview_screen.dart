import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'dart:typed_data';

/// A screen that displays a generated QR code and provides options to save or share it.
class QrPreviewScreen extends StatefulWidget {
  final String content; // The formatted string content of the QR code.
  final String label;   // A descriptive label for the QR code type.

  const QrPreviewScreen({
    super.key,
    required this.content,
    required this.label,
  });

  @override
  State<QrPreviewScreen> createState() => _QrPreviewScreenState();
}

class _QrPreviewScreenState extends State<QrPreviewScreen> {
  // Key used to capture the QR code image from the widget tree for sharing.
  final GlobalKey _qrKey = GlobalKey();

  /// Captures the QR code as an image and opens the system share dialog.
  Future<void> _shareQr() async {
    try {
      // Find the render object associated with the QR code's RepaintBoundary.
      RenderRepaintBoundary boundary =
          _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      
      // Convert the render object to an image with a high pixel ratio for quality.
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      
      // Convert the image to PNG byte data.
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Save the PNG bytes to a temporary file.
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/qr_code.png').create();
      await file.writeAsBytes(pngBytes);

      // Share the file using the share_plus package.
      await SharePlus.instance.share(ShareParams(
          files: [XFile(file.path)],
          text: 'Check out this QR code generated via Scan Master!'),);
    } catch (e) {
      if (!mounted) return;
      // Show an error message if the sharing process fails.
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error sharing QR code: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.label} QR Code')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Use RepaintBoundary to allow capturing the child widget as an image.
              RepaintBoundary(
                key: _qrKey,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: QrImageView(
                    data: widget.content,
                    version: QrVersions.auto,
                    size: 280.0,
                    gapless: false,
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: Colors.black,
                    ),
                    dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Button to simulate saving the QR code to the device disk.
                  _actionButton(context, 'Save to Disk', Icons.save_alt, () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Saved to Gallery! (Mocked)'),
                      ),
                    );
                  }, isPrimary: false),
                  const SizedBox(width: 16),
                  // Button to trigger the sharing flow.
                  _actionButton(
                    context,
                    'Share Code',
                    Icons.share,
                    _shareQr,
                    isPrimary: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper widget to create consistent action buttons on this screen.
  Widget _actionButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onTap, {
    required bool isPrimary,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary
            ? Theme.of(context).primaryColor
            : Colors.grey.shade200,
        foregroundColor: isPrimary ? Colors.white : Colors.black87,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
      ),
    );
  }
}
