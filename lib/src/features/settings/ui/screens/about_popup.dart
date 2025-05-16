import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPopup extends StatefulWidget {
  const AboutPopup({super.key});

  @override
  State<AboutPopup> createState() => _AboutPopupState();
}

class _AboutPopupState extends State<AboutPopup> {
  String version = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      version = "${info.version} (${info.buildNumber})";
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.deepPurple),
          const SizedBox(width: 8),
          Text('About', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Mood Journal',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text('Version $version', style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 12),
            Text(
              'Why Mood Tracking Matters',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(
              'Tracking your mood daily helps you reflect, build emotional awareness, and take better care of your mental health.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Text(
              'Developer Info',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(
              'Developed with ❤️ by Amine - AppDevPlatform',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.email_outlined, size: 18),
                const SizedBox(width: 6),
                Text('support@amineamine.com', style: TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.language, size: 18),
                const SizedBox(width: 6),
                Text('www.dailymood.app', style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Close', style: TextStyle()),
        ),
      ],
    );
  }
}
