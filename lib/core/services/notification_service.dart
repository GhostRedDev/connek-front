import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    // Android Initialization
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    // iOS Initialization
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    // Request permissions for Android 13+
    if (!kIsWeb && Platform.isAndroid) {
      final androidImplementation = _localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      await androidImplementation?.requestNotificationsPermission();
    }

    _isInitialized = true;
    print('🔔 NotificationService initialized');
  }

  void _onNotificationTap(NotificationResponse response) {
    // Handle notification tap logic here
    // You can use a navigation service or global key to navigate
    print('🔔 Notification Tapped: ${response.payload}');
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'connek_notifications',
      'Connek Notifications',
      channelDescription: 'Main channel for app notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const iosDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(id, title, body, details, payload: payload);
  }

  // Parse Supabase Realtime Payload and show notification
  void handleRealtimeEvent(PostgresChangePayload payload) {
    try {
      if (payload.eventType == PostgresChangeEvent.insert) {
        final newRecord = payload.newRecord;

        // Safety check for required fields
        if (newRecord.containsKey('title') && newRecord.containsKey('body')) {
          showNotification(
            id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
            title: newRecord['title'],
            body: newRecord['body'],
            payload: jsonEncode(newRecord),
          );
        }
      }
    } catch (e) {
      print('❌ Error handling notification event: $e');
    }
  }
}
