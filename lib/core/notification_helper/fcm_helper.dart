import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'notification_onTap.dart';
import 'notification_service.dart';

class FCMHelper {
  static var messaging = FirebaseMessaging.instance;
  static String? notificationToken;
  static bool? subscribedSaleTopic;
  static bool? subscribedResaleTopic;
  static bool? subscribedRentalTopic;
  static RemoteMessage? initialMessage;

  static Future<void> init() async {
    //Request Permissions (primarily for iOS):
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    await messaging.getToken().then((value) {
      notificationToken = value;
      if (kDebugMode) {
        print('notification token :$value');
      }
      return null;
    });
  }

  static void subscribeToTopic({String? topic}) {
    try {
      messaging.subscribeToTopic(topic ?? 'global');
    } catch (e) {
      if (kDebugMode) {
        print('error to subscribe topic $e');
      }
    }
  }

  static void unsubscribeFromTopic({required String topic}) {
    try {
      messaging.unsubscribeFromTopic(topic);
    } catch (e) {
      if (kDebugMode) {
        print('error to subscribe topic $e');
      }
    }
  }

  static void onMessageListener({String? topic}) {
    FirebaseMessaging.onMessage.listen((event) {
      if (Platform.isAndroid) {
        NotificationsService.showNotification(
          notificationLayout: NotificationLayout.BigPicture,
          bigPicture: event.notification?.android?.imageUrl ??
              event.notification?.apple?.imageUrl,
          channelKey: 'firebase key',
          title: event.notification?.title,
          body: event.notification?.body,
          payload: {
            'case': event.data["case"] ?? "",
            'info': event.data["info"] ?? "",
          },
        );
      }
    });
  }

  static void onBackgroundListener({String? topic}) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  static void onMessageOpenedAppHandler({BuildContext? context}) {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      notificationOnTap(
          info: event.data['info'], type: event.data['case'], ctx: context);
    });
  }

  static Future<void> initialMessageHandler({BuildContext? context}) async {
    initialMessage = await messaging.getInitialMessage(); // may be null
    // listening for notifications when the app is opened (foreground)
    if (initialMessage != null) {
      await Future.delayed(const Duration(seconds: 1));
      notificationOnTap(
          ctx: context,
          type: initialMessage?.data['case'].toString(),
          info: initialMessage?.data['info'].toString());
      initialMessage = null;
    }
  }
}

// this annotation to mark a function (or other entities, as classes) to indicate to the compiler that it will be used from native code.
// this solves problem of receiving notifications when app closed in release mode.
@pragma('vm:entry-point')
//when app is in background or closed write what to do here in this method
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print('notifications on background received');
  }
}
