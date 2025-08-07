import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'This is your Privacy Policy...\n\n1. We do not log your activity.\n2. Your data is secure.\n3. We don’t sell your information.\n\n(Add your full legal details.)',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
