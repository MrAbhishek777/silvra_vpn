import 'package:flutter/material.dart';
import 'package:silvra_vpn/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/chat_bubble.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _customQuestionController = TextEditingController();

  // Chat messages list: each is map with keys 'isUser' and 'text'
  final List<Map<String, dynamic>> _chatMessages = [];

  void _askAssistant(String question) {
    if (question.trim().isEmpty) return;

    final lang = AppLocalizations.of(context)!;
    final lowerQ = question.trim().toLowerCase();

    String answer;
    if ((lowerQ.contains('how') && lowerQ.contains('connect')) ||
        lowerQ.contains('कनेक्ट')) {
      answer = lang.assistantConnect;
    } else if (lowerQ.contains('not connecting') ||
        lowerQ.contains('connect nahi ho') ||
        lowerQ.contains('जोडले')) {
      answer = lang.assistantNotConnecting;
    } else if (lowerQ.contains('free') ||
        lowerQ.contains('फ्री') ||
        lowerQ.contains('मुफ्त')) {
      answer = lang.assistantFree;
    } else if (lowerQ.contains('vpn')) {
      answer = lang.assistantGeneric;
    } else {
      answer = lang.assistantNonVpn;
    }

    setState(() {
      // Add user question
      _chatMessages.add({'isUser': true, 'text': question.trim()});
      // Add assistant answer
      _chatMessages.add({'isUser': false, 'text': answer});
    });

    _customQuestionController.clear();
  }

  void _contactByEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@silvra.app',
      query: Uri.encodeFull(
          'subject=Silvra VPN Support&body=Please describe your issue here...'),
    );
    launchUrl(emailLaunchUri);
  }

  @override
  void dispose() {
    _customQuestionController.dispose();
    super.dispose();
  }

  Widget _buildChatBubble(String text, bool isUser, BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = isUser
        ? (theme.brightness == Brightness.dark
            ? Colors.blueAccent.shade700
            : Colors.blue.shade300)
        : (theme.brightness == Brightness.dark
            ? Colors.grey.shade700
            : Colors.grey.shade300);
    final textColor = isUser ? Colors.white : theme.textTheme.bodyMedium?.color;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isUser ? 18 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(1, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(lang.helpCenterTitle)),
      body: SafeArea(
        child: Column(
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () => _askAssistant(lang.connectVPN),
                  child: Text(lang.connectVPN),
                ),
                ElevatedButton(
                  onPressed: () => _askAssistant(lang.notConnecting),
                  child: Text(lang.notConnecting),
                ),
                ElevatedButton(
                  onPressed: () => _askAssistant(lang.isItFree),
                  child: Text(lang.isItFree),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Chat messages list
            Expanded(
  child: ListView.builder(
    padding: const EdgeInsets.symmetric(vertical: 8),
    itemCount: _chatMessages.length,
    itemBuilder: (context, index) {
      final msg = _chatMessages[index];
      return ChatBubble(
        message: msg['text'],
        isUser: msg['isUser'],
      );
    },
  ),
),

            // Input area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _customQuestionController,
                      decoration: InputDecoration(
                        hintText: lang.otherQuestion,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      onSubmitted: _askAssistant,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _askAssistant(_customQuestionController.text),
                    child: const Icon(Icons.send),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(14),
                      minimumSize: const Size(40, 40),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),
            const SizedBox(height: 8),

            Text(
              lang.needMoreHelp,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.email),
              label: Text(lang.contactEmail),
              onPressed: _contactByEmail,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
