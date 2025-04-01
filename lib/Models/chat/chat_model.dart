import 'package:jop_project/Models/chat/message_model.dart';

class ChatModel {
  String? chatId; // معرف المحادثة (مثل "searcherId_companyId")
  String? searcherId; // معرف المستخدم
  bool? searcherIsConect; // معرف المستخدم
  String? companyId; // معرف الشركة
  bool? companyIsConect; // معرف الشركة
  List<MessageModel>? messages; // قائمة الرسائل في المحادثة

  ChatModel({
    this.chatId,
    this.searcherId,
    this.companyId,
    this.messages,
    this.companyIsConect,
    this.searcherIsConect,
  });

  // تحويل البيانات من JSON إلى كائن ChatModel
  ChatModel.fromJson(Map<Object?, dynamic> json, String chatID) {
    chatId = chatID;
    searcherId = json['searcherId'];
    companyId = json['companyId'];
    searcherIsConect = json['searcherIsConect'];
    companyIsConect = json['companyIsConect'];
    if (json['messages'] != null) {
      messages = [];
      json['messages'].forEach((key, value) {
        messages!.add(MessageModel.fromJson(value, key));
      });
      // ترتيب الرسائل حسب التاريخ والوقت
      messages!.sort((a, b) =>
          a.timestamp!.compareTo(b.timestamp!)); // من الأقدم إلى الأحدث
    }
  }

  // تحويل الكائن ChatModel إلى JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['searcherId'] = searcherId;
    data['companyId'] = companyId;
    data['searcherIsConect'] = searcherIsConect;
    data['companyIsConect'] = companyIsConect;
    if (messages != null) {
      data['messages'] = {};
      for (var message in messages!) {
        data['messages'][message.messageId] = message.toJson();
      }
    }
    return data;
  }
}
