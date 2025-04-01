class MessageModel {
  String? messageId; // معرف الرسالة
  String? senderId; // معرف المرسل (مثل "searcherId" أو "companyId")
  String? text; // نص الرسالة
  bool? sendNotification; // نص الرسالة
  DateTime? timestamp; // وقت إرسال الرسالة
  Map<String, bool>? isRead; // حقل لتتبع حالة القراءة

  MessageModel({
    this.messageId,
    this.senderId,
    this.text,
    this.timestamp,
    this.isRead,
    required this.sendNotification,
  });

  // تحويل البيانات من JSON إلى كائن MessageModel
  MessageModel.fromJson(Map<Object?, dynamic> json, String messageId) {
    this.messageId = messageId;
    senderId = json['senderId'];
    text = json['text'];
    sendNotification = json['sendNotification'];
    timestamp = DateTime.parse(json['timestamp']); // تحويل String إلى DateTime
    isRead = Map<String, bool>.from(json['isRead']);
  }

  // تحويل الكائن MessageModel إلى JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['senderId'] = senderId;
    data['text'] = text;
    data['timestamp'] =
        timestamp!.toIso8601String(); // تحويل DateTime إلى String
    data['isRead'] = isRead; // إضافة حقل isRead إلى JSON
    data['sendNotification'] = sendNotification; // إضافة حقل isRead إلى JSON
    return data;
  }
}
