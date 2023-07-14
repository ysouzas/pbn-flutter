import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

class TextModal extends StatelessWidget {
  final String text;

  const TextModal({required this.text});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _copyText(context, text),
                  child: const Text('Copy'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _shareText(context, text),
                  child: const Text('Share'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _copyText(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
    Navigator.pop(context);
  }

  void _shareText(BuildContext context, String text) {
    Share.share(text);
    Navigator.pop(context);
  }
}
