import 'package:flutter/material.dart';
import 'package:jop_project/components/background.dart';
import 'package:jop_project/l10n/l10n.dart';

import '../../size_config.dart';

class Message {
  final String senderName;
  final String content;
  final String time;
  final String avatarPath;
  final bool isRead;

  Message({
    required this.senderName,
    required this.content,
    required this.time,
    required this.avatarPath,
    this.isRead = false,
  });
}

class MessagesScreen extends StatelessWidget {
  final List<Message> messages;

  const MessagesScreen({
    super.key,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Background(
      height: SizeConfig.screenH! / 4.5,
      title: l10n.messages,
      child: ListView.builder(
        itemCount: messages.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final message = messages[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(message.avatarPath),
                  ),
                  if (!message.isRead)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
              title: Text(
                message.senderName,
                textAlign: TextAlign.right,
              ),
              subtitle: Text(
                message.content,
                textAlign: TextAlign.right,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(message.time),
              onTap: () {
                // فتح المحادثة
              },
            ),
          );
        },
      ),
    );
  }
}
