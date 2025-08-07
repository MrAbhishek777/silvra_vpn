import 'package:flutter/material.dart';

class ServerListScreen extends StatelessWidget {
  const ServerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final freeServers = [
  'India',
  'USA',
  'Singapore',
  'Netherlands',
  'Brazil',
  'UK',
  'Canada'
];

final premiumServers = [
  'Germany',
  'France',
  'Japan',
  'Australia',
  'Switzerland',
  'South Korea',
  'Sweden'
];


    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select Server'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Free'),
              Tab(text: 'Premium'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Free servers
            ListView.builder(
              itemCount: freeServers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.vpn_lock),
                  title: Text(freeServers[index]),
                  trailing: TextButton(
                    child: const Text('Connect'),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Connecting to ${freeServers[index]} (Dummy)')),
                      );
                    },
                  ),
                );
              },
            ),
            // Premium servers (locked for now)
            ListView.builder(
              itemCount: premiumServers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.lock),
                  title: Text(premiumServers[index]),
                  trailing: const Icon(Icons.lock_outline, color: Colors.grey),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
