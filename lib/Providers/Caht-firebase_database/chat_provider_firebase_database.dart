import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:jop_project/Models/chat/chat_model.dart';
import 'package:jop_project/Models/chat/message_model.dart';
import 'package:intl/intl.dart';

class ChatProvider with ChangeNotifier {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  DatabaseReference get databaseReference => _databaseReference;
  bool companyIsConect = false;
  bool searcherIsConect = false;
  List<ChatModel> _chats = [];
  List<MessageModel> _messages = [];

  List<MessageModel> get messages => _messages;
  List<ChatModel> get chats => _chats;

  Future<void> createChat(String searcherId, String companyId,
      bool companyIsConect, bool searcherIsConect) async {
    String chatId = '${searcherId}_$companyId';

    // التحقق من وجود الدردشة
    final snapshot = await _databaseReference.child('chats/$chatId').once();
    if (snapshot.snapshot.value == null) {
      // الدردشة غير موجودة، نقوم بإنشائها
      await _databaseReference.child('chats/$chatId').set({
        'searcherId': searcherId,
        'companyId': companyId,
        'searcherIsConect': searcherIsConect,
        "companyIsConect": companyIsConect,
        'messages': {}, // قائمة الرسائل الفارغة
      });
      log('Chat created successfully.');
    } else {
      if (companyIsConect) {
        await _databaseReference
            .child('chats/$chatId/companyIsConect')
            .set(true);
      } else if (searcherIsConect) {
        await _databaseReference
            .child('chats/$chatId/searcherIsConect')
            .set(true);
      }
      // getChatsById(chatId);
      // الدردشة موجودة بالفعل
      log('Chat already exists.');
    }
  }

  Future<void> getChatsById(String chatId) async {
    _databaseReference.child('chats/$chatId').onValue.listen(
      (event) {
        if (event.snapshot.value != null) {
          Map<dynamic, dynamic> chatsData =
              event.snapshot.value as Map<dynamic, dynamic>;
          ChatModel hhh = ChatModel.fromJson(chatsData, chatId);

          companyIsConect = hhh.companyIsConect ?? false;
          searcherIsConect = hhh.searcherIsConect ?? false;
          // log(companyIsConect.toString(), name: 'companyIsConect');
          // log(searcherIsConect.toString(), name: 'searcherIsConect');
        } else {
          ChatModel hhh = ChatModel();

          companyIsConect = hhh.companyIsConect ?? false;
          searcherIsConect = hhh.searcherIsConect ?? false;
        }
      },
    );
    // notifyListeners();
  }

  Future<void> disConnect(
      String chatId, bool companyIsConect, bool searcherIsConect) async {
    if (companyIsConect) {
      await _databaseReference
          .child('chats/$chatId/companyIsConect')
          .set(false);
    } else if (searcherIsConect) {
      await _databaseReference
          .child('chats/$chatId/searcherIsConect')
          .set(false);
    }
  }

  // جلب جميع الدردشات الخاصة بمستخدم معين
  Stream<List<ChatModel>> getChatsBySearcherId(String searcherId) {
    return _databaseReference
        .child('chats')
        .orderByChild('searcherId')
        .equalTo(searcherId)
        .onValue
        .map((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> chatsData =
            event.snapshot.value as Map<dynamic, dynamic>;
        _chats = chatsData.entries.map((entry) {
          log(entry.key, name: 'entry.key');
          return ChatModel.fromJson(entry.value, entry.key);
        }).toList();
        // notifyListeners();
        // ترتيب الدردشات بناءً على آخر رسالة
        _chats.sort((a, b) {
          if (a.messages!.isEmpty || b.messages!.isEmpty) return 0;
          return b.messages!.last.timestamp!
              .compareTo(a.messages!.last.timestamp!); // من الأحدث إلى الأقدم
        });

        // notifyListeners();
        return _chats;
      }
      return [];
    });
  }

  // جلب جميع الدردشات الخاصة بشركة معينة
  Stream<List<ChatModel>> getChatsByCompanyId(String companyId) {
    return _databaseReference
        .child('chats')
        .orderByChild('companyId')
        .equalTo(companyId)
        .onValue
        .map((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> chatsData =
            event.snapshot.value as Map<dynamic, dynamic>;

        _chats = chatsData.entries.map((entry) {
          // log(entry.key, name: 'entry.key');
          return ChatModel.fromJson(entry.value, entry.key);
        }).toList();

        // ترتيب الدردشات بناءً على آخر رسالة
        _chats.sort((a, b) {
          if (a.messages!.isEmpty || b.messages!.isEmpty) return 0;
          return b.messages!.last.timestamp!
              .compareTo(a.messages!.last.timestamp!); // من الأحدث إلى الأقدم
        });

        return _chats;
      }
      return [];
    });
  }

  void getChatsByCompanyIdLignth(String companyId) {
    getChatsByCompanyId(companyId).listen((event) {
      if (event.isNotEmpty) {
        _chats = event;
        // log(_chats.length.toString(), name: 'event length');
        notifyListeners();
      }
    }).onData(
      (data) {
        if (data.isNotEmpty) {
          // log(data.length.toString(), name: 'data length');
          _chats = data;
          notifyListeners();
        }
      },
    );

    // notifyListeners();
  }

  // جلب الدردشات باستخدام Stream
  // Stream<List<ChatModel>> getChatsStream(String userId) {
  //   return _databaseReference
  //       .child('chats')
  //       .orderByChild('searcherId')
  //       .equalTo(userId)
  //       .onValue
  //       .map((event) {
  //     if (event.snapshot.value != null) {
  //       Map<dynamic, dynamic> chatsData =
  //           event.snapshot.value as Map<dynamic, dynamic>;
  //       _chats = chatsData.entries.map((entry) {
  //         return ChatModel.fromJson(entry.value, entry.key);
  //       }).toList();
  //       // ترتيب الدردشات بناءً على آخر رسالة
  //       _chats.sort((a, b) {
  //         if (a.messages!.isEmpty || b.messages!.isEmpty) return 0;
  //         return b.messages!.last.timestamp!
  //             .compareTo(a.messages!.last.timestamp!); // من الأحدث إلى الأقدم
  //       });
  //       notifyListeners();
  //       return _chats;
  //     }
  //     return [];
  //   });
  // }

  // دالة للحصول على Stream للرسائل
  Stream<List<MessageModel>> getMessagesStream(String chatId) {
    return _databaseReference
        .child('chats/$chatId/messages')
        .onValue
        .map((event) {
      if (event.snapshot.value != null) {
        // تحويل Map<dynamic, dynamic> إلى Map<String, dynamic>
        Map<dynamic, dynamic> messagesData =
            event.snapshot.value as Map<dynamic, dynamic>;
        // log(messagesData.toString(), name: 'messagesData');
        // Map<String, dynamic> convertedMessagesData =
        //     convertToMapStringDynamic(messagesData);
        // log(messagesData.toString(), name: 'convertedMessagesData');

        _messages = messagesData.entries.map((entry) {
          return MessageModel.fromJson(entry.value, entry.key);
        }).toList();

        _messages.sort((a, b) {
          if (a.timestamp != null || b.timestamp != null) return 0;
          return b.timestamp!.compareTo(a.timestamp!); // من الأحدث إلى الأقدم
        });

        // تحويل البيانات إلى List<MessageModel>
        return _messages;

        // notifyListeners();
        // return _messages;
      }
      return [];
    });
  }

  // إضافة رسالة جديدة
  Future<void> addMessage(
      String chatId, MessageModel message, String readerId) async {
    // إنشاء معرف فريد للرسالة
    // String messageId =
    //     _databaseReference.child('chats/$chatId/messages').push().key!;
    // message.messageId = messageId;
    message.isRead = {
      // 'searcherId': false, // غير مقروءة من قبل المستخدم
      '$readerId-$readerId': false, // غير مقروءة من قبل الشركة
    };

    // إضافة الرسالة إلى قاعدة البيانات
    await _databaseReference
        .child('chats/$chatId/messages/${message.messageId}')
        .set(message.toJson());
  }

  // دالة لتحديث حالة القراءة للرسالة.
  Future<void> markAsRead(
      String chatId, String messageId, String readerId) async {
    await _databaseReference
        .child('chats/$chatId/messages/$messageId/isRead/$readerId-$readerId')
        .set(true);
    // log('dddddddd');
  }

  Future<void> markAsReadSendNotification(
      String chatId, String messageId) async {
    await _databaseReference
        .child('chats/$chatId/messages/$messageId/sendNotification')
        .set(true);
  }

  // إضافة رسالة جديدة
  // Future<void> addMessage(String chatId, MessageModel message) async {
  //   await _databaseReference.child('chats/$chatId').set(message.toJson());
  // }

  // تعديل رسالة
  Future<void> updateMessage(String chatId, MessageModel message) async {
    await _databaseReference
        .child('chats/$chatId/messages/${message.messageId}')
        .update(message.toJson());
  }

  // حذف رسالة
  Future<void> deleteMessage(String chatId, String messageId) async {
    await _databaseReference
        .child('chats/$chatId/messages/$messageId')
        .remove();
  }

  // البحث عن رسائل تحتوي على نص معين
  Future<List<MessageModel>> searchMessages(String chatId, String query) async {
    final snapshot =
        await _databaseReference.child('chats/$chatId/messages').once();
    if (snapshot.snapshot.value != null) {
      Map<dynamic, dynamic> messagesData =
          snapshot.snapshot.value as Map<dynamic, dynamic>;
      return messagesData.entries
          .map((entry) {
            return MessageModel.fromJson(entry.value, entry.key);
          })
          .where((message) =>
              message.text!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    return [];
  }

  // Map<String, dynamic> convertToMapStringDynamic(
  //     Map<dynamic, dynamic> originalMap) {
  //   Map<String, dynamic> newMap = {};
  //   originalMap.forEach((key, value) {
  //     newMap[key.toString()] = value;
  //   });
  //   return newMap;
  // }

  String formatTimestamp(DateTime timestamp) {
    // تنسيق التاريخ والوقت
    final dateFormat = DateFormat('yyyy/MM/dd hh:mm a'); // 'ar' للغة العربية
    return dateFormat.format(timestamp);
  }
}
