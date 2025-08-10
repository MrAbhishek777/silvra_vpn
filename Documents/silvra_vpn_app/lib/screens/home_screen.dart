import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) toggleTheme;
  final Function(Locale) updateLocale;
  final bool isPremiumUser;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
    required this.updateLocale,
    required this.isPremiumUser,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool isConnected = false;
  bool netShield = false;
  bool killSwitch = false;
  String protocol = "WireGuard";
  int seconds = 0;
  String currentIp = "192.168.0.101";
  String provider = "Not Connected";

  Timer? _timer;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: 0.95,
      upperBound: 1.05,
    )..repeat(reverse: true);
  }

  void _toggleConnection() {
    setState(() {
      isConnected = !isConnected;
      if (isConnected) {
        provider = "Germany - Berlin";
        currentIp = "85.214.132.117";
        _startTimer();
      } else {
        provider = "Not Connected";
        currentIp = "192.168.0.101";
        _stopTimer();
      }
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => seconds++);
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() => seconds = 0);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Row(
        children: [
          _buildLeftPanel(theme),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/map.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ScaleTransition(
                        scale: _pulseController,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isConnected ? Colors.red : Colors.green,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: _toggleConnection,
                          child: Text(
                            isConnected ? "DISCONNECT" : "CONNECT",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _formatTime(seconds),
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("IP: $currentIp",
                              style: const TextStyle(color: Colors.white)),
                          const SizedBox(width: 20),
                          Text("Provider: $provider",
                              style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildRightPanel(theme),
        ],
      ),
    );
  }

  Widget _buildLeftPanel(ThemeData theme) {
    final countries = [
      "Germany - Berlin",
      "USA - New York",
      "India - Mumbai",
      "France - Paris",
      "Japan - Tokyo",
      "UK - London"
    ];

    return Container(
      width: 250,
      color: theme.colorScheme.surfaceVariant,
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text("Servers",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search country",
                prefixIcon: const Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.flag),
                  title: Text(countries[index]),
                  onTap: () {
                    setState(() {
                      provider = countries[index];
                      isConnected = true;
                      currentIp = "85.214.${100 + index}.${50 + index}";
                      _startTimer();
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRightPanel(ThemeData theme) {
    return Container(
      width: 250,
      color: theme.colorScheme.surfaceVariant,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          SwitchListTile(
            title: const Text("NetShield"),
            value: netShield,
            onChanged: (val) => setState(() => netShield = val),
          ),
          SwitchListTile(
            title: const Text("Kill Switch"),
            value: killSwitch,
            onChanged: (val) => setState(() => killSwitch = val),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              value: protocol,
              items: ["WireGuard", "OpenVPN", "IKEv2"]
                  .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                  .toList(),
              onChanged: (val) => setState(() => protocol = val!),
              decoration: const InputDecoration(labelText: "Protocol"),
            ),
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }

  String _formatTime(int totalSeconds) {
    final hours = (totalSeconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((totalSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final secs = (totalSeconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$secs";
  }
}
