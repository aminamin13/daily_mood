import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSupportPopup extends StatelessWidget {
  const ContactSupportPopup({super.key});

  final String email = 'support@amineamine.com';
  final String website = 'https://www.dailymood.app';

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Support%20Request&body=Hi%20Daily%20Mood%20Team,',
    );
    if (!await launchUrl(emailUri)) {}
    await launchUrl(emailUri);
  }

  Future<void> _launchWebsite() async {
    final Uri url = Uri.parse(website);
    if (!await launchUrl(url)) {}
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.support_agent_outlined, color: Colors.deepPurple),
          const SizedBox(width: 8),
          Text(
            'Contact Support',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Need help? We’re here for you!',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.email_outlined, size: 20),
              const SizedBox(width: 8),
              InkWell(
                onTap: _launchEmail,
                child: Text(email, style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.language, size: 20),
              const SizedBox(width: 8),
              InkWell(
                onTap: _launchWebsite,
                child: Text(website, style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _launchEmail,
          child: Text('Email Us', style: TextStyle()),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Close', style: TextStyle()),
        ),
      ],
    );
  }
}
