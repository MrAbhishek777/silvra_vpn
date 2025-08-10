import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'gen_l10n/app_localizations.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/server_list_screen.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  Locale _selectedLocale = const Locale('en');
  bool isPremiumUser = false;

  void toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  void updateLocale(Locale newLocale) {
    setState(() {
      _selectedLocale = newLocale;
    });
  }

  void updatePremiumStatus(bool value) {
    setState(() {
      isPremiumUser = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _selectedLocale,
      supportedLocales: const [
        Locale('en'), Locale('hi'), Locale('mr'), Locale('ur'),
        Locale('ta'), Locale('te'), Locale('gu'), Locale('bn'),
        Locale('pa'), Locale('kn'), Locale('ja'), Locale('fr'),
        Locale('es'), Locale('de'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: lightTheme.copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
      ),
      darkTheme: darkTheme.copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(
              isDarkMode: isDarkMode,
              toggleTheme: toggleTheme,
              updateLocale: updateLocale,
              isPremiumUser: isPremiumUser,
            ),
        '/settings': (context) => SettingsScreen(
              isDarkMode: isDarkMode,
              toggleTheme: toggleTheme,
              updateLocale: updateLocale,
              isPremiumUser: isPremiumUser,
              updatePremiumStatus: updatePremiumStatus,
            ),
        '/servers': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final premiumStatus = args is bool ? args : isPremiumUser;
          return ServerListScreen(
            key: UniqueKey(),
            // premiumStatus can be used here if needed
          );
        },
      },
    );
  }
}
