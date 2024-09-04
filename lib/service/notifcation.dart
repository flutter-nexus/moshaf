import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

Future<void> backgroundHandler(NotificationResponse details) async {
  log('Notification tapped in the background: ${details.payload}');
}
Future<void> frontHandler(NotificationResponse details) async {
  log('Notification tapped in the background: ${details.payload}');
}

class FlutterLocalNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotification =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    tz.initializeTimeZones();
    final timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotification.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: backgroundHandler,
      onDidReceiveNotificationResponse: frontHandler,
    );
  }

  Future<void> showNotification({
    required int id,
    String title = 'Notification title',
    String body = 'Notification body',
  }) async {
    await flutterLocalNotification.show(
      id,
      title,
      body,
      payload: 'body',
       NotificationDetails(
        android: AndroidNotificationDetails(
          'id1',
          'basic channel',
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('pop.wav'.split('.').first),
        ),
      ),
    );
  }

  Future<void> showNotificationPeriodically({
    required int id,
    RepeatInterval interval = RepeatInterval.everyMinute,
    String title = 'Notification title',
    String body = 'Notification body',
  }) async {
    await flutterLocalNotification.periodicallyShow(
      id,
      title,
      body,
      interval,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'id1',
          'basic channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
    );
  }

  Future<void> showScheduledNotification({
    required int id,
    String title = 'Scheduled Notification',
    String body = 'This notification is scheduled.',
    required DateTime scheduledTime,
  }) async {
    await flutterLocalNotification.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'id1',
          'basic channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelNotification({required int id}) async {
    await flutterLocalNotification.cancel(id);
  }
}