import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jop_project/Controller/Firebase_Services/send_notification_service.dart';
import 'package:jop_project/Models/chat/message_model.dart';
import 'package:jop_project/Models/company_model.dart';
import 'package:jop_project/Models/searcher_model.dart';
import 'package:jop_project/Providers/Caht-firebase_database/chat_provider_firebase_database.dart';
import 'package:jop_project/Providers/SignUp/company_signin_login_provider.dart';
import 'package:jop_project/Providers/SignUp/searcher_signin_login_provider.dart';
import 'package:jop_project/components/background.dart';
import 'package:jop_project/constants.dart';
import 'package:jop_project/l10n/l10n.dart';
import 'package:jop_project/responsive.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';

class ChatScreen extends StatefulWidget {
  final CompanyModel? companyModel;
  final SearchersModel? searchersModel;
  final String chatId;
  final String readerId;

  const ChatScreen({
    super.key,
    this.companyModel,
    this.searchersModel,
    required this.chatId,
    required this.readerId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  // final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final idChat = widget.chatId.split('_');
      final searcherId = idChat[0];
      final companyId = idChat[1];
      Provider.of<ChatProvider>(context, listen: false)
          .getChatsById(widget.chatId);
      Provider.of<ChatProvider>(context, listen: false).createChat(
          searcherId,
          companyId,
          widget.companyModel == null ? true : false,
          widget.searchersModel == null ? true : false);
    });
// if(mounted)
    super.initState();
  }

  void markMessagesAsRead(
      String chatId, List<MessageModel> messages, String readerId) async {
    // التمرير إلى الأسفل بعد بناء الواجهة لأول مرة
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    // });
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    final idChat = widget.chatId.split('_');
    final searcherId = idChat[0];
    final companyId = idChat[1];
    for (var message in messages) {
      if (message.senderId != readerId) {
        if (message.isRead?['$searcherId-$searcherId'] == false ||
            message.isRead?['$companyId-$companyId'] == false) {
          await chatProvider.markAsRead(chatId, message.messageId!, readerId);
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    ChatProvider().disConnect(
      widget.chatId,
      widget.companyModel == null ? true : false,
      widget.searchersModel == null ? true : false,
    );
    // _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    return Scaffold(
      body: Background(
        height: SizeConfig.screenH! / 6,
        userImage: context
                .read<CompanySigninLoginProvider>()
                .currentCompany
                ?.img ??
            context.read<SearcherSigninLoginProvider>().currentSearcher?.img ??
            '',
        userName: context
                .read<CompanySigninLoginProvider>()
                .currentCompany
                ?.nameCompany ??
            context.read<SearcherSigninLoginProvider>().currentSearcher?.img ??
            '',
        isCompany:
            context.read<SearcherSigninLoginProvider>().currentSearcher?.img ==
                    null
                ? true
                : false,
        showListNotiv: true,
        title: widget.companyModel?.nameCompany ??
            widget.searchersModel?.fullName ??
            '______',
        child: Responsive(
          mobile: Column(
            children: [
              Expanded(
                child: StreamBuilder<List<MessageModel>>(
                  stream: chatProvider.getMessagesStream(
                      widget.chatId), // استخدام Provider للحصول على Stream
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      log('Error: ${snapshot.error}');
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              child: ListTile(
                                title: Text(
                                  widget.companyModel?.nameCompany ??
                                      widget.searchersModel?.fullName ??
                                      '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                leading: const Icon(Icons.person),
                                trailing: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                        child: Text(
                                      '12:00',
                                      style: TextStyle(fontSize: 11),
                                      textDirection: TextDirection.ltr,
                                    )),
                                    Expanded(
                                        child: Text(
                                      'Typing ...',
                                      style: TextStyle(fontSize: 11),
                                      textDirection: TextDirection.ltr,
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Text('No messages available'),
                        ],
                      ));
                    } else {
                      List<MessageModel> messages = snapshot.data!;

                      // ترتيب الرسائل من الأحدث إلى الأقدم
                      messages
                          .sort((a, b) => b.timestamp!.compareTo(a.timestamp!));

                      // تحديث حالة القراءة عند فتح الشاشة
                      markMessagesAsRead(
                          widget.chatId, messages, widget.readerId);
                      return ListView.builder(
                        shrinkWrap: true,
                        reverse: true, // عرض الرسائل من الأسفل
                        // controller: _scrollController,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          MessageModel message = messages[index];
                          bool isRead = false;
                          if (widget.searchersModel != null) {
                            isRead = message.isRead?[
                                    '${widget.searchersModel!.id}-${widget.searchersModel!.id}'] ??
                                false;
                          } else {
                            isRead = message.isRead?[
                                    '${widget.companyModel!.id}-${widget.companyModel!.id}'] ??
                                false;
                          }
                          return Column(
                            children: [
                              if (index == messages.length - 1) ...[
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: ListTile(
                                      title: Text(
                                        widget.companyModel?.nameCompany ??
                                            widget.searchersModel?.fullName ??
                                            '',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      leading: const Icon(Icons.person),
                                      trailing: const Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Flexible(
                                              child: Text(
                                            '12:00',
                                            style: TextStyle(fontSize: 11),
                                            textDirection: TextDirection.ltr,
                                          )),
                                          Expanded(
                                              child: Text(
                                            'Typing ...',
                                            style: TextStyle(fontSize: 11),
                                            textDirection: TextDirection.ltr,
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              MessageBubble(
                                  time: chatProvider
                                      .formatTimestamp(message.timestamp!),
                                  subtitle: (message.senderId ==
                                          widget.readerId)
                                      ? '${message.senderId} - ${isRead ? 'Read' : 'Unread'}'
                                      : '',
                                  message: message,
                                  isMy: (widget.companyModel?.id ==
                                          int.parse(message.senderId!))
                                      ? true
                                      : (widget.searchersModel?.id ==
                                              int.parse(message.senderId!))
                                          ? true
                                          : false),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.attach_file),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Enter your message here',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      color: kPrimaryColor,
                      onPressed: () async {
                        if (_messageController.text.isNotEmpty) {
                          String messageId = chatProvider.databaseReference
                              .child('chats/${widget.chatId}/messages')
                              .push()
                              .key!;
                          MessageModel messageModel = MessageModel(
                            sendNotification: false,
                            messageId: messageId,
                            senderId: widget.companyModel != null
                                ? Provider.of<SearcherSigninLoginProvider>(
                                        context,
                                        listen: false)
                                    .currentSearcher
                                    ?.id
                                    .toString()
                                : widget.searchersModel != null
                                    ? Provider.of<CompanySigninLoginProvider>(
                                            context,
                                            listen: false)
                                        .currentCompany
                                        ?.id
                                        .toString()
                                    : '11', // استبدل بمعرف المستخدم الفعلي
                            text: _messageController.text,
                            timestamp: DateTime.now(),
                          );

                          chatProvider.addMessage(
                              widget.chatId, messageModel, widget.readerId);
                          _messageController.clear();
                          if (chatProvider.companyIsConect == false) {
                            final companyId =
                                widget.companyModel?.id.toString();
                            await SendNotificationsService
                                .sendNotificationForSingleUserUsingApi(
                                    token:
                                        widget.companyModel?.tokenNotification,
                                    title: l10n.havemessage,
                                    body: "محتوى الرسالة ${messageModel.text}",
                                    data: {
                                  "screen": 'Chat',
                                  "userType": 'Admin',
                                  "userId": companyId
                                });
                            await chatProvider.markAsReadSendNotification(
                                widget.chatId, messageId);
                          }
                          if (chatProvider.searcherIsConect == false) {
                            final searcherId =
                                widget.searchersModel?.id.toString();
                            await SendNotificationsService
                                .sendNotificationForSingleUserUsingApi(
                                    token: widget
                                        .searchersModel?.tokenNotification,
                                    title: l10n.havemessage,
                                    body: "محتوى الرسالة ${messageModel.text}",
                                    data: {
                                  "screen": 'Chat',
                                  "userType": 'Searcher',
                                  "userId": searcherId
                                });
                            await chatProvider.markAsReadSendNotification(
                                widget.chatId, messageId);
                            // log(
                            //     widget.searchersModel!.tokenNotification
                            //         .toString(),
                            //     name:
                            //         'widget.searchersModel?.tokenNotification');
                          }

                          // final idChat = widget.chatId.split('_');
                          // final searcherId = idChat[0];
                          // final companyId = idChat[1];
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          desktop: Column(
            children: [
              Expanded(
                child: StreamBuilder<List<MessageModel>>(
                  stream: chatProvider.getMessagesStream(
                      widget.chatId), // استخدام Provider للحصول على Stream
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No messages available'));
                    } else {
                      List<MessageModel> messages = snapshot.data!;

                      markMessagesAsRead(
                          widget.chatId, messages, widget.readerId);

                      // ترتيب الرسائل من الأحدث إلى الأقدم
                      messages
                          .sort((a, b) => b.timestamp!.compareTo(a.timestamp!));

                      return ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          MessageModel message = messages[index];
                          bool isRead = message.isRead?[
                                  '${widget.readerId}-${widget.readerId}'] ??
                              false;
                          return MessageBubble(
                              time: chatProvider
                                  .formatTimestamp(message.timestamp!),
                              subtitle: (message.senderId != widget.readerId)
                                  ? '${message.senderId} - ${isRead ? 'Read' : 'Unread'}'
                                  : '',
                              message: message,
                              isMy:
                                  (widget.companyModel != null) ? true : false);
                          // ListTile(
                          //   title: Text(message.text!),
                          //   subtitle: Text(
                          //       '${message.senderId} - ${message.timestamp}'),
                          // );
                        },
                      );
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.attach_file),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Enter your message here',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      color: kPrimaryColor,
                      onPressed: () {
                        if (_messageController.text.isNotEmpty) {
                          MessageModel message = MessageModel(
                            sendNotification: false,
                            messageId: '',
                            senderId: widget.companyModel != null
                                ? Provider.of<SearcherSigninLoginProvider>(
                                        context,
                                        listen: false)
                                    .currentSearcher
                                    ?.id
                                    .toString()
                                : Provider.of<CompanySigninLoginProvider>(
                                        context,
                                        listen: false)
                                    .currentCompany
                                    ?.id
                                    .toString(), // استبدل بمعرف المستخدم الفعلي
                            text: _messageController.text,
                            timestamp: DateTime.now(),
                          );
                          chatProvider.addMessage(
                              widget.chatId, message, widget.readerId);
                          _messageController.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMy;
  final String subtitle;
  final String time;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMy,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMy ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: isMy ? kPrimaryColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text.toString(),
              style: TextStyle(
                color: isMy ? Colors.white : Colors.black,
              ),
            ),
            Text(
              time,
              // '${DateTime.parse(message.timestamp.toString()).year}/${DateTime.parse(message.timestamp.toString()).month.toString().padLeft(2, '0')}/${DateTime.parse(message.timestamp.toString()).day.toString().padLeft(2, '0')} ${DateTime.parse(message.timestamp.toString()).hour.toString().padLeft(2, '0')}:${DateTime.parse(message.timestamp.toString()).minute.toString().padLeft(2, '0')} ',
              style: TextStyle(
                fontSize: 12,
                color: isMy ? Colors.white70 : Colors.black54,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 9,
                color: isMy ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
