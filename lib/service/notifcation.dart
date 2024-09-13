import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize(Function(String?) onSelectNotification) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        if (notificationResponse.payload != null) {
          onSelectNotification(notificationResponse.payload);
        }
      },
    );
  }

  static Future<void> showAzanNotification(String prayerName) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'azan_channel',
      'Azan Notifications',
      channelDescription: 'Notifications for prayer times',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _notificationsPlugin.show(
      0, // ID الإشعار
      'وقت الصلاة',
      'حان وقت صلاة $prayerName',
      platformChannelSpecifics,
      payload: prayerName, // تمرير اسم الصلاة هنا
    );
  }
}
