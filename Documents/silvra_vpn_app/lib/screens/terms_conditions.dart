import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms & Conditions')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'These are your Terms & Conditions...\n\n1. Respect user privacy.\n2. Don’t misuse the VPN.\n3. Silvra VPN is not liable for third-party actions.\n\n(You can replace with your full content.)',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
