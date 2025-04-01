import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:jop_project/Controller/Firebase_Services/get_service_key.dart';

class SendNotificationsService {
  //
  // send notification for single user
  static Future<void> sendNotificationForSingleUserUsingApi({
    required String? token,
    required String? title,
    required String? body,
    required Map<String, dynamic>? data,
  }) async {
    // Get Token to http response
    String serverKey = await GetServerKey().getServerKeyToken();
    // log(serverKey, name: 'sendNotificationForSingleUser');
    // https url from googleapis
    String url =
        'https://fcm.googleapis.com/v1/projects/jop-project-6e8d3/messages:send';

    // Headers
    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverKey',
    };

    // message-Body
    Map<String, dynamic> message = {
      "message": {
        "token": token,
        "notification": {"body": body, "title": title},
        "data": data
      }
    };

    try {
      // hit api
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        debugPrint("Notification Send Successfully!");
        log("Notification Send Successfully!");
      } else {
        debugPrint("Notification not send!");
        log("Notification not send!");
      }
    } catch (e) {
      debugPrint("Notification catch error! not send!");
      print('not send notification: $e' 'sendNotificationForSingleUser');
    }
  }
}
