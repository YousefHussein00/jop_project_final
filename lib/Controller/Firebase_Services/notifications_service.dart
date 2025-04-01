// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:jop_project/Screens/ChatScreen/company_chats_screen.dart';
import 'package:jop_project/Screens/ChatScreen/searcher_chats_screen.dart';
import 'package:jop_project/Screens/CompanyScreen/applicants_screen.dart';
import 'package:jop_project/Screens/JopScreen/Home/home_screen.dart';
import 'package:jop_project/Screens/JopScreen/OrderScreen/order_screen.dart';

class NotificationsService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // for notification request
  Future requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('user granted permision');
      log('user granted permision');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('user provisional granted permision');
      log('user provisional granted permision');
    } else {
      Get.snackbar(
        'Notification permision denies',
        'Please allow notifications to receive updates.',
        snackPosition: SnackPosition.BOTTOM,
      );
      Future.delayed(const Duration(seconds: 2), () {
        AppSettings.openAppSettings(type: AppSettingsType.notification);
      });
    }
  }

  // get Device Token for Push Notifications
  Future<String?> getDeviceToken() async {
    try {
      // ignore: unused_local_variable
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      String? token = await messaging.getToken();
      // print('token=> $token');
      // log('token=> $token');
      return token;
    } catch (e) {
      return null;
      // rethrow;
    }
  }

  // init

  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    const AndroidInitializationSettings androidInitSetting =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    const DarwinInitializationSettings iosInitSetting =
        DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: androidInitSetting,
      iOS: iosInitSetting,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        handleMessage(context, message);
      },
    );
  }

  // firebase init
  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen(
      (message) {
        RemoteNotification? notification = message.notification;
        // AndroidNotification? android = message.notification!.android;

        if (kDebugMode) {
          print('notification title: ${notification!.title}');
          log('notification title: ${notification.title}');
          print('notification body: ${notification.body}');
          log('notification body: ${notification.body}');
        }

        //ios
        if (Platform.isIOS) {
          iosForgroundMessage();
        }

        //android
        if (Platform.isAndroid) {
          initLocalNotifications(context, message);
          // handleMessage(context, message);
          showNotifications(message);
        }
      },
    );
  }

  // function to show notifications
  Future<void> showNotifications(RemoteMessage message) async {
    // Channel Setting
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.tag.toString(),
      importance: Importance.max,
      showBadge: true,
      playSound: true,
    );

    // Android Setting
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'البحث عن وظيفة',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      sound: channel.sound,
    );

    //Ios setting
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    // marge settings
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    // show notification
    await Future.delayed(
      Duration.zero,
      () async {
        await _flutterLocalNotificationsPlugin.show(
          message.notification!.hashCode,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails,
          payload: message.data['screen'] ?? "my_data",
        );
      },
    );
  }

  // background and terminates
  Future<void> setupInteractMessage(BuildContext context) async {
    // background state
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        handleMessage(context, message);
      },
    );

    // terminates state
    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? message) {
        if (message != null && message.data.isNotEmpty) {
          handleMessage(context, message);
        }
      },
    );
  }

  // Future<Map<String, dynamic>> getUserDataAndType() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //   final userType = prefs.getString('userType');
  //   final userId = prefs.getInt('userId');
  //   // Companies
  //   final cachedDataCompanies = prefs.getString('Companies');
  //   // Searchers
  //   final cachedDataSearchers = prefs.getString('Searchers');
  //   //
  //   if (token != null &&
  //       userType == "Admin" &&
  //       userId != null &&
  //       cachedDataCompanies != null) {
  //     log(cachedDataCompanies.toString(), name: 'cachedDataCompanies');
  //     final decodedData = json.decode(cachedDataCompanies);
  //     return {
  //       'userType': userType ?? 'Admin',
  //       'Object': CompanyModel.fromJson(decodedData)
  //     };
  //   } else if (token != null &&
  //       userType == "Searchers" &&
  //       userId != null &&
  //       cachedDataSearchers != null) {
  //     final dynamic decodedData = json.decode(cachedDataSearchers);
  //     return {
  //       'userType': userType ?? 'Searchers',
  //       'Object': SearchersModel.fromJson(decodedData)
  //     };
  //   } else {
  //     return {
  //       'userType': '',
  //       'other': SearchersModel(),
  //     };
  //   }
  // }

  // handle message

  Future<void> handleMessage(
      BuildContext context, RemoteMessage message) async {
    if (message.data['screen'] == 'Chat' &&
        message.data['userType'] == 'Admin') {
      await Get.to(
        duration: const Duration(seconds: 3),
        () => CompanyChatsScreen(
          companyId: message.data['userId'],
        ),
      );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => CompanyChatsScreen(
      //       companyId: message.data['userId'],
      //     ),
      //   ),
      // );
    } else if (message.data['screen'] == 'Chat' &&
        message.data['userType'] == 'Searcher') {
      Get.to(
        () => SearcherChatsScreen(
          searcherId: message.data['userId'],
        ),
      );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => SearcherChatsScreen(
      //       searcherId: message.data['userId'],
      //     ),
      //   ),
      // );
    } else if (message.data['screen'] == 'OrderScreen' &&
        message.data['userType'] == 'Searcher') {
      Get.to(
        () => const OrderScreen(),
      );
    } else if (message.data['screen'] == 'OrderScreen' &&
        message.data['userType'] == 'Admin') {
      Get.to(
        () => const ApplicantsScreen(),
      );
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    }
    // final getUserDataAndTypes = await getUserDataAndType();
    // log(getUserDataAndTypes.toString(), name: 'getUserDataAndTypes');
    // final companySigninLoginProvider =
    //     CompanySigninLoginProvider().currentCompany;
    // final searcherSigninLoginProvider =
    //     SearcherSigninLoginProvider().currentSearcher;
    // // if (getUserDataAndTypes != null) {
    // //
    // log(message.data['userType'].toString(), name: 'userType');
    // if (message.data['screen'] == 'JobAdvertisement') {
    //   if (message.data['userType'] == 'Admin') {
    //     CompanyModel company = getUserDataAndTypes['Object'];
    //     JobsProvider jobsProvider = JobsProvider();
    //     await jobsProvider.getJobs();
    //     final job = jobsProvider.jobs
    //         .where((element) => element.companyId == company.id)
    //         .toList();
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => ApplicantsScreen(
    //           job: job[0],
    //         ),
    //       ),
    //     );
    //     //
    //   } else if (getUserDataAndTypes['userType'] == 'Searchers') {
    //     // navigate to order screen
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => const OrderScreen(),
    //         ));
    //     //
    //   }
    // }
    // //
    // else if (message.data['screen'] == 'Chat') {
    //   if (companySigninLoginProvider != null &&
    //       getUserDataAndTypes['userType'] == 'Admin') {
    //     CompanyModel company = getUserDataAndTypes['copany'];
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) =>
    //               CompanyChatsScreen(companyId: company.id.toString()),
    //         ));
    //   } else if (searcherSigninLoginProvider != null &&
    //       getUserDataAndTypes['userType'] == 'Searchers') {
    //     SearchersModel searcher = getUserDataAndTypes['searcher'];
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) =>
    //               SearcherChatsScreen(searcherId: searcher.id.toString()),
    //         ));
    //   } else {
    //     Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const LoginScreen(),
    //       ),
    //       (route) => false,
    //     );
    //   }
    // } else {
    //   if (companySigninLoginProvider != null &&
    //       getUserDataAndTypes['userType'] == 'Admin') {
    //     CompanyModel company = getUserDataAndTypes['copany'];
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => CompanyDashboardScreen(company: company),
    //         ));
    //   } else if (searcherSigninLoginProvider != null &&
    //       getUserDataAndTypes['userType'] == 'Searchers') {
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => const HomeScreen(),
    //         ));
    //   } else {
    //     Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const LoginScreen(),
    //       ),
    //       (route) => false,
    //     );
    //   }
    // }
  }

  // ios message
  Future iosForgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
