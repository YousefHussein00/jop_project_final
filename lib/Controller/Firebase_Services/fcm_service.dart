import 'package:firebase_messaging/firebase_messaging.dart';

class FcmService {
  static void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      // Handle foreground messages
      if (message.notification != null) {
        print("Foreground Notification: ${message.notification!.title}");
        print("Foreground Notification: ${message.notification!.body}");
      }
    });

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // Handle background messages
    if (message.notification != null) {
      print("Background Notification: ${message.notification!.title}");
      print("Background Notification: ${message.notification!.body}");
    }
  }
}