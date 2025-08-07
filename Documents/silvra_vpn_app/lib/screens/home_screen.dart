import 'dart:async';
import 'package:flutter/material.dart';
import 'settings_screen.dart';
import 'server_list_screen.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final void Function(bool) toggleTheme;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isConnected = false;
  int _seconds = 0;
  Timer? _timer;

  void toggleConnection() {
    setState(() {
      isConnected = !isConnected;
    });

    if (isConnected) {
      _seconds = 0;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _seconds++;
        });
      });
    } else {
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get formattedDuration {
    final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Silvra VPN'),
        centerTitle: true,
        actions: [
          if (!isConnected)
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.workspace_premium, color: Colors.amber),
            ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SettingsScreen(
                    isDarkMode: widget.isDarkMode,
                    toggleTheme: widget.toggleTheme,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shield_rounded, size: 100, color: Colors.blue),
          const SizedBox(height: 20),
          Text(
            isConnected ? 'Connected' : 'Disconnected',
            style: TextStyle(
              fontSize: 20,
              color: isConnected ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text('IP: 192.168.43.1 (dummy)', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          Text('Duration: $formattedDuration', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: toggleConnection,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              backgroundColor: isConnected ? Colors.red : Colors.green,
            ),
            child: Text(
              isConnected ? 'DISCONNECT' : 'CONNECT',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ServerListScreen()),
              );
            },
            child: const Text('View Server List'),
          ),
          const SizedBox(height: 40),
          if (!isConnected)
            Container(
              height: 50,
              color: Colors.grey[300],
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: const Text('Ad Banner Placeholder'),
            ),
        ],
      ),
    );
  }
}
