import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const SilvraVpnApp());
}

class SilvraVpnApp extends StatelessWidget {
  const SilvraVpnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Silvra VPN',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system, // Will be controlled from settings later
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
