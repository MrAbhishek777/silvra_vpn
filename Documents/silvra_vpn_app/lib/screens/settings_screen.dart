import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final void Function(bool) toggleTheme;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _toggleDarkMode(bool value) {
    widget.toggleTheme(value);
  }

  void _shareApp() {
    Share.share('Check out Silvra VPN: https://play.google.com/store/apps/details?id=com.silvra.vpn');
  }

  void _rateApp() async {
    final url = Uri.parse("https://play.google.com/store/apps/details?id=com.silvra.vpn");
    if (await canLaunchUrl(url)) {
      launchUrl(url);
    }
  }

  void _openPrivacyPolicy() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const StaticPageScreen(
          title: "Privacy Policy",
          content: "This is the privacy policy content.",
        ),
      ),
    );
  }

  void _openTerms() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const StaticPageScreen(
          title: "Terms & Conditions",
          content: "These are the terms & conditions.",
        ),
      ),
    );
  }

  void _signOut() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sign out tapped (not implemented yet)')),
    );
    // TODO: Add Firebase logout functionality here later
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: widget.isDarkMode,
            onChanged: _toggleDarkMode,
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            onTap: _openPrivacyPolicy,
          ),
          ListTile(
            title: const Text('Terms & Conditions'),
            onTap: _openTerms,
          ),
          ListTile(
            title: const Text('Share App'),
            onTap: _shareApp,
          ),
          ListTile(
            title: const Text('Rate App'),
            onTap: _rateApp,
          ),
          const Divider(),
          ListTile(
            title: const Text('Sign Out'),
            leading: const Icon(Icons.logout),
            textColor: Colors.red,
            iconColor: Colors.red,
            onTap: _signOut,
          ),
        ],
      ),
    );
  }
}

class StaticPageScreen extends StatelessWidget {
  final String title;
  final String content;

  const StaticPageScreen({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(content, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
