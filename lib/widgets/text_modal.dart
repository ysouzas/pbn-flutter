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
            Text(
              text,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _copyText(context, text),
                  child: Text('Copy'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _shareText(context, text),
                  child: Text('Share'),
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
      SnackBar(content: Text('Copied to clipboard')),
    );
    Navigator.pop(context);
  }

  void _shareText(BuildContext context, String text) {
    Share.share(text);
    Navigator.pop(context);
  }
}
