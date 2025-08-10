import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatefulWidget {
  final Locale selectedLocale;
  final Function(Locale) onLocaleSelected;

  const LanguageSelectionScreen({
    super.key,
    required this.selectedLocale,
    required this.onLocaleSelected,
  });

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  late Locale _currentLocale;

  final Map<String, String> languageNames = {
    'en': 'English',
    'hi': 'हिन्दी',
    'mr': 'मराठी',
    'ur': 'اردو',
    'ta': 'தமிழ்',
    'te': 'తెలుగు',
    'gu': 'ગુજરાતી',
    'bn': 'বাংলা',
    'pa': 'ਪੰਜਾਬੀ',
    'kn': 'ಕನ್ನಡ',
    'ja': '日本語',
    'fr': 'Français',
    'es': 'Español',
    'de': 'Deutsch',
  };

  @override
  void initState() {
    super.initState();
    _currentLocale = widget.selectedLocale;
  }

  void _selectLocale(String languageCode) {
    setState(() {
      _currentLocale = Locale(languageCode);
    });
    widget.onLocaleSelected(_currentLocale);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose App Language"),
      ),
      body: ListView(
        children: languageNames.entries.map((entry) {
          final languageCode = entry.key;
          final languageLabel = entry.value;
          return RadioListTile(
            title: Text(languageLabel),
            value: languageCode,
            groupValue: _currentLocale.languageCode,
            onChanged: (value) => _selectLocale(value!),
          );
        }).toList(),
      ),
    );
  }
}
