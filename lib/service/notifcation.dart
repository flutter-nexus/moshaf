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
  log('Notification tapped in the foreground: ${details.payload}');
}

class FlutterLocalNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotification =
      FlutterLocalNotificationsPlugin();

  // Initialization
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

  // Creating a notification channel
  AndroidNotificationDetails _createChannel({
    required String channelId,
    required String channelName,
    String channelDescription = 'Default channel description',
    Importance importance = Importance.max,
    Priority priority = Priority.high,
    String sound = 'default',
  }) {
    return AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: importance,
      priority: priority,
      sound: sound == 'default'
          ? null
          : RawResourceAndroidNotificationSound(sound.split('.').first),
      playSound: sound != 'default',
    );
  }

  // Show a simple notification
  Future<void> showNotification({
    required int id,
    required String channelId,
    required String channelName,
    String title = 'Notification title',
    String body = 'Notification body',
    String payload = 'default_payload',
    String sound = 'default',
    Importance importance = Importance.max,
    Priority priority = Priority.high,
  }) async {
    var androidDetails = _createChannel(
      channelId: channelId,
      channelName: channelName,
      importance: importance,
      priority: priority,
      sound: sound,
    );

    await flutterLocalNotification.show(
      id,
      title,
      body,
      NotificationDetails(android: androidDetails),
      payload: payload,
    );
  }

  // Show a periodic notification
  Future<void> showPeriodicNotification({
    required int id,
    required String channelId,
    required String channelName,
    RepeatInterval interval = RepeatInterval.everyMinute,
    String title = 'Notification title',
    String body = 'Notification body',
    String payload = 'default_payload',
    String sound = 'default',
    Importance importance = Importance.max,
    Priority priority = Priority.high,
  }) async {
    var androidDetails = _createChannel(
      channelId: channelId,
      channelName: channelName,
      importance: importance,
      priority: priority,
      sound: sound,
    );

    await flutterLocalNotification.periodicallyShow(
      id,
      title,
      body,
      interval,
      NotificationDetails(android: androidDetails),
      androidAllowWhileIdle: true,
      payload: payload,
    );
  }

  // Schedule a notification
  Future<void> showScheduledNotification({
    required int id,
    required String channelId,
    required String channelName,
    required DateTime scheduledTime,
    String title = 'Scheduled Notification',
    String body = 'This notification is scheduled.',
    String payload = 'default_payload',
    String sound = 'default',
    Importance importance = Importance.max,
    Priority priority = Priority.high,
  }) async {
    var androidDetails = _createChannel(
      channelId: channelId,
      channelName: channelName,
      importance: importance,
      priority: priority,
      sound: sound,
    );

    await flutterLocalNotification.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      NotificationDetails(android: androidDetails),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  // Cancel a notification
  Future<void> cancelNotification({required int id}) async {
    await flutterLocalNotification.cancel(id);
  }

  // Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotification.cancelAll();
  }
}
