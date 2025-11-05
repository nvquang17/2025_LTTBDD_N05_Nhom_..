import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await _notificationsPlugin.initialize(settings);
  }

  /// Gửi thông báo ngay lập tức
  static Future<void> showInstantNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'water_channel',
      'Water Reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails details =
        NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(0, title, body, details);
  }

  /// Lên lịch nhắc uống nước mỗi 2 giờ
  static Timer? _timer;

  static void startWaterReminder() {
    _timer?.cancel(); // hủy nếu có timer cũ
    _timer = Timer.periodic(const Duration(hours: 2), (timer) async {
      await showInstantNotification(
        'Nhắc uống nước 💧',
        'Nhắc uống nước 💧',
      );
    });
  }

  static void stopWaterReminder() {
    _timer?.cancel();
  }
}
