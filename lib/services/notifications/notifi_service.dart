import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static int _notificationIdCounter = 0;

  /// ✅ Generates a unique notification ID automatically
  static int _generateNotificationId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }

  /// ✅ Initialize Notifications (Foreground & Background)
  static Future<void> initialize() async {
    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings iosInitSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    
    );

    final InitializationSettings initSettings =
        InitializationSettings(android: androidInitSettings, iOS: iosInitSettings);

    await _flutterLocalNotificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) async {
      if (response.payload != null) {
        await logNotificationClick(response.payload!);
      }
    });

    tz.initializeTimeZones();
  }

  /// ✅ Show Simple Notification (Auto-ID)
  static Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    int id = _generateNotificationId();

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'default_channel',
      'General Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      id, title, body, platformDetails, payload: payload,
    );
  }

  /// ✅ Show Notification with Image (Auto-ID)
  static Future<void> showImageNotification({
    required String title,
    required String body,
    required String imageUrl,
    String? payload,
  }) async {
    int id = _generateNotificationId();
    final String imagePath = await _downloadAndSaveImage(imageUrl, 'image.jpg');

    final BigPictureStyleInformation bigPictureStyle = BigPictureStyleInformation(
      FilePathAndroidBitmap(imagePath),
      // largeIcon: FilePathAndroidBitmap(imagePath),
      contentTitle: title,
      summaryText: body,

    );

    final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'image_channel',
      'Image Notifications',
      styleInformation: bigPictureStyle,
      importance: Importance.high,
      priority: Priority.high,

      fullScreenIntent: true,
      // icon: "'@mipmap/ic_launcher'",
    );

    final NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      id, title, body, platformDetails, payload: payload,
    );
  }

  /// ✅ Show Notification with Action Buttons (Auto-ID)
  static Future<void> showActionNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    int id = _generateNotificationId();

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'action_channel',
      'Action Notifications',
      importance: Importance.high,
      priority: Priority.high,
      actions: [
        AndroidNotificationAction('open_action', 'Open', showsUserInterface: true),
        AndroidNotificationAction('dismiss_action', 'Dismiss', cancelNotification: true),
      ],
    );

    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails,);

    await _flutterLocalNotificationsPlugin.show(
      id, title, body, platformDetails, payload: payload,
    );
  }

  /// ✅ Schedule a Notification (Auto-ID)
  static Future<void> scheduleNotification({
    required String title,
    required String body,
    required Duration delay,
    String? payload,
  }) async {
    int id = _generateNotificationId();

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(delay),
      const NotificationDetails(
        android: AndroidNotificationDetails('scheduled_channel', 'Scheduled Notifications'),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
  }

  /// ✅ Cancel Notification by ID
  static Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  /// ✅ Cancel All Notifications
  static Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  /// ✅ Log Notification Clicks & Store in a File
  static Future<void> logNotificationClick(String payload) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File logFile = File('${directory.path}/notification_logs.txt');

    final String logEntry = "${DateTime.now()} - Clicked Notification: $payload\n";
    await logFile.writeAsString(logEntry, mode: FileMode.append);
    
    print("Logged Notification Click: $logEntry");
  }

  /// ✅ Download & Save Image
  static Future<String> _downloadAndSaveImage(String url, String fileName) async {
    final response = await http.get(Uri.parse(url));
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$fileName');
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  /// ✅ Set Application Icon Badge (iOS)
  static Future<void> setBadge(int count) async {
    if (Platform.isIOS) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    }
  }

  /// ✅ Reset Badge to 0
  static Future<void> resetBadge() async {
    if (Platform.isIOS) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    }
  }
}
