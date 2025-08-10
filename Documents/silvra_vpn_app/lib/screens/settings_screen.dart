import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../gen_l10n/app_localizations.dart';
import 'language_selection_screen.dart';
import 'privacy_policy.dart';
import 'terms_conditions.dart';
import 'help_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final void Function(bool) toggleTheme;
  final void Function(Locale) updateLocale;
  final bool isPremiumUser;
  final void Function(bool)? updatePremiumStatus;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
    required this.updateLocale,
    required this.isPremiumUser,
    this.updatePremiumStatus,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _killSwitchEnabled = false;
  bool _dnsLeakProtectionEnabled = false;
  String _selectedProtocol = 'WireGuard';
  late bool _isPremium;

  final List<String> _protocols = ['WireGuard', 'OpenVPN', 'IKEv2'];

  @override
  void initState() {
    super.initState();
    _isPremium = widget.isPremiumUser;
    _loadSecuritySettings();
  }

  Future<void> _loadSecuritySettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _killSwitchEnabled = prefs.getBool('kill_switch') ?? false;
      _dnsLeakProtectionEnabled = prefs.getBool('dns_leak_protection') ?? false;
      _selectedProtocol = prefs.getString('vpn_protocol') ?? 'WireGuard';
    });
  }

  Future<void> _updateKillSwitch(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('kill_switch', value);
    setState(() => _killSwitchEnabled = value);
  }

  Future<void> _updateDnsLeakProtection(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dns_leak_protection', value);
    setState(() => _dnsLeakProtectionEnabled = value);
  }

  Future<void> _updateProtocol(String value) async {
    if (!_isProtocolAllowed(value)) {
      _showSubscribeDialog();
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('vpn_protocol', value);
    setState(() => _selectedProtocol = value);
  }

  bool _isProtocolAllowed(String protocol) {
    return _isPremium || protocol == 'WireGuard';
  }

  void _showSubscribeDialog() {
    final lang = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(lang.subscriptionRequired),
        content: Text(lang.premiumProtocolUpgradeMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to subscription page
            },
            child: Text(lang.upgradeNow),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(lang.cancel),
          ),
        ],
      ),
    );
  }

  void _changeLanguage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LanguageSelectionScreen(
          selectedLocale: Localizations.localeOf(context),
          onLocaleSelected: widget.updateLocale,
        ),
      ),
    );
  }

  void _togglePremiumUser(bool value) {
    setState(() => _isPremium = value);
    widget.updatePremiumStatus?.call(value);
  }

  void _openPrivacyPolicy() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()));
  }

  void _openTerms() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const TermsConditionsScreen()));
  }

  void _openHelp() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpScreen()));
  }

  void _shareApp() {
    Share.share('Check out Silvra VPN app! Download it now.');
  }

  Future<void> _rateApp() async {
    final url = Uri.parse('https://play.google.com/store/apps/details?id=com.yourapp.package');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the app store.')),
      );
    }
  }

  void _signOut() {
    // Sign-out logic here
    debugPrint('User signed out');
  }

  String _getCurrentLanguageLabel(String code) {
    const langMap = {
      'en': 'English',
      'hi': 'हिन्दी (Hindi)',
      'mr': 'मराठी (Marathi)',
      'ur': 'اردو (Urdu)',
      'ta': 'தமிழ் (Tamil)',
      'te': 'తెలుగు (Telugu)',
      'gu': 'ગુજરાતી (Gujarati)',
      'bn': 'বাংলা (Bengali)',
      'pa': 'ਪੰਜਾਬੀ (Punjabi)',
      'kn': 'ಕನ್ನಡ (Kannada)',
      'ja': '日本語 (Japanese)',
      'fr': 'Français (French)',
      'es': 'Español (Spanish)',
      'de': 'Deutsch (German)',
    };
    return langMap[code] ?? code;
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(lang.settings)),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(lang.darkMode),
            value: widget.isDarkMode,
            onChanged: widget.toggleTheme,
          ),
          SwitchListTile(
            title: const Text('Kill Switch'),
            subtitle: const Text('Disconnect internet if VPN drops'),
            value: _killSwitchEnabled,
            onChanged: _updateKillSwitch,
          ),
          SwitchListTile(
            title: const Text('DNS Leak Protection'),
            subtitle: const Text('Prevent DNS queries outside VPN tunnel'),
            value: _dnsLeakProtectionEnabled,
            onChanged: _updateDnsLeakProtection,
          ),
          ListTile(
            title: const Text('Preferred Protocol'),
            subtitle: Text(_selectedProtocol),
            trailing: DropdownButton<String>(
              value: _selectedProtocol,
              underline: const SizedBox(),
              onChanged: (value) {
                if (value != null) _updateProtocol(value);
              },
              items: _protocols.map((protocol) {
                final isPremium = protocol != 'WireGuard';
                return DropdownMenuItem(
                  value: protocol,
                  child: Row(
                    children: [
                      Text(protocol),
                      if (isPremium)
                        const Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: Icon(Icons.star, color: Colors.amber, size: 16),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: Text(lang.appLanguage),
            subtitle: Text(_getCurrentLanguageLabel(Localizations.localeOf(context).languageCode)),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: _changeLanguage,
          ),
          SwitchListTile(
            title: const Text('Premium User (testing)'),
            subtitle: const Text('Toggle to simulate premium status'),
            value: _isPremium,
            onChanged: _togglePremiumUser,
          ),
          ListTile(title: Text(lang.privacyPolicy), onTap: _openPrivacyPolicy),
          ListTile(title: Text(lang.termsConditions), onTap: _openTerms),
          ListTile(title: Text(lang.helpCenter), onTap: _openHelp),
          ListTile(title: Text(lang.shareApp), onTap: _shareApp),
          ListTile(title: Text(lang.rateApp), onTap: _rateApp),
          const Divider(),
          ListTile(
            title: Text(lang.signOut),
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
