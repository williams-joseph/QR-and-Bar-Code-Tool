import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/scan_item.dart';
import '../services/ad_service.dart';

class ResultScreen extends StatefulWidget {
  final ScanItem item;

  const ResultScreen({super.key, required this.item});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final AdService _adService = AdService();

  @override
  void initState() {
    super.initState();
    _adService.loadInterstitialAd();
  }

  @override
  void dispose() {
    _adService.showInterstitialAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isUrl = widget.item.category == 'URL';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Result'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => SharePlus.instance.share(ShareParams(text: widget.item.content)),
      )],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(12),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    _getCategoryIcon(widget.item.category),
                    size: 64,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.item.category,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SelectionArea(
                    child: Text(
                      widget.item.content,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _actionButton(context, 'Copy', Icons.copy, () {
                        Clipboard.setData(ClipboardData(text: widget.item.content));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Copied to clipboard')),
                        );
                      }),
                      const SizedBox(width: 16),
                      if (isUrl) ...[
                        _actionButton(
                          context,
                          'Open',
                          Icons.open_in_browser,
                          () => launchUrl(
                            Uri.parse(widget.item.content),
                            mode: LaunchMode.inAppBrowserView,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  _infoRow('Format', widget.item.format),
                  const Divider(height: 32),
                  _infoRow(
                    'Date',
                    DateFormat('MMM dd, yyyy').format(widget.item.timestamp),
                  ),
                  const Divider(height: 32),
                  _infoRow(
                    'Time',
                    DateFormat('hh:mm a').format(widget.item.timestamp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'URL':
        return FontAwesomeIcons.link;
      case 'WIFI':
        return FontAwesomeIcons.wifi;
      case 'CONTACT':
        return FontAwesomeIcons.user;
      case 'EMAIL':
        return FontAwesomeIcons.envelope;
      case 'PHONE':
        return FontAwesomeIcons.phone;
      case 'SMS':
        return FontAwesomeIcons.message;
      default:
        return FontAwesomeIcons.alignLeft;
    }
  }
}
