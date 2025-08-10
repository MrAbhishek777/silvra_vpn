// lib/screens/server_list_screen.dart
import 'package:flutter/material.dart';
import 'package:silvra_vpn/gen_l10n/app_localizations.dart';
import 'package:silvra_vpn/data/servers.dart';

class ServerListScreen extends StatelessWidget {
  const ServerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final isPremiumUser = ModalRoute.of(context)!.settings.arguments as bool? ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.selectServer ?? 'Select Server'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: allServers.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final server = allServers[index];
          final isPremium = server.isPremium;
          final canConnect = !isPremium || isPremiumUser;

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Icon(
              isPremium ? Icons.lock_outline : Icons.vpn_lock,
              color: isPremium ? Colors.amber : Theme.of(context).colorScheme.primary,
              size: 28,
            ),
            title: Text(
              server.name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: canConnect ? null : Colors.grey,
              ),
            ),
            subtitle: Text(
              isPremium ? lang.premiumTab ?? 'Premium' : lang.freeTab ?? 'Free',
              style: TextStyle(
                color: canConnect ? Colors.grey[600] : Colors.grey[400],
                fontSize: 13,
              ),
            ),
            trailing: canConnect
                ? TextButton(
                    onPressed: () => Navigator.pop(context, server),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    ),
                    child: Text(
                      lang.connect ?? 'Connect',
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                  )
                : Icon(Icons.lock, color: Colors.grey[400]),
            onTap: () {
              if (!canConnect) {
                _showUpgradeDialog(context, server);
              } else {
                Navigator.pop(context, server);
              }
            },
          );
        },
      ),
    );
  }

  void _showUpgradeDialog(BuildContext context, Server server) {
    final lang = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(lang.subscriptionRequired),
        content: Text('${server.name} is ${lang.premiumTab ?? 'Premium'} only.\n${lang.premiumProtocolUpgradeMessage}'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(lang.cancel)),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Upgrade flow not implemented')),
              );
            },
            child: Text(lang.upgradeNow),
          ),
        ],
      ),
    );
  }
}
