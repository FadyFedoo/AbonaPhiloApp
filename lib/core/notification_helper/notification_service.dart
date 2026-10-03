import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationsService {
  static Future<void> initializeNotifications(
      {bool reqPerMission = false}) async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'firebase key',
            channelName: 'Firebase channel',
            channelDescription: 'firebase notification',
            playSound: true,
            channelShowBadge: true,
            importance: NotificationImportance.High,
            enableVibration: true,
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.white),
      ],
    );
    if (reqPerMission) {
      await AwesomeNotifications()
          .isNotificationAllowed()
          .then((isAllowed) async {
        if (!isAllowed) {
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });
    }
  }

  static Future<void> showNotification({
    final String? title,
    final String? body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? notificationCategory,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
    final Color? backgroundColor,
    required final String channelKey,
  }) async {
    assert(!scheduled || (scheduled && interval != null));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: channelKey,
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: notificationCategory,
        payload: payload,
        bigPicture: bigPicture,
        largeIcon: bigPicture,
        backgroundColor: backgroundColor,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
              interval: null,
              timeZone:
                  await AwesomeNotifications().getLocalTimeZoneIdentifier(),
              preciseAlarm: true,
            )
          : null,
    );
  }
}
