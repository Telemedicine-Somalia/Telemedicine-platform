// background_message_handler.dart

import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_callkit_incoming_yoer/flutter_callkit_incoming.dart';
import 'package:flutter_callkit_incoming_yoer/entities/entities.dart';
import 'package:uuid/uuid.dart';
import 'package:tele/services/background_call_handler.dart';

@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  try {
    print('🔔 Background message received: ${message.messageId}');
    print('🔔 Background message data: ${message.data}');

    final data = message.data;

    if (data.isEmpty || message.messageId == null || message.messageId == 'null') {
      print('🔔 Ignoring empty/invalid message from ZPNs');
      return;
    }

    if (data['type'] == null || data['type'].toString().isEmpty) {
      print('🔔 Ignoring message without valid type');
      return;
    }

    if (data['type'] == 'call_invitation') {
      await _showBackgroundCallKitDirect(data);
    } else if (data['type'] == 'call_end') {
      await _endBackgroundCallDirect();
    } else {
      await _showBackgroundNotification(message);
    }
  } catch (e) {
    print('❌ Error in background message handler: $e');
    await BackgroundCallHandler.handleBackgroundCall(message);
  }
}

@pragma('vm:entry-point')
Future<void> _showBackgroundCallKitDirect(Map<String, dynamic> data) async {
  try {
    final uuid = const Uuid().v4();

    final picture = data['picture'] ?? '';
    final avatarUrl = picture.startsWith('http')
        ? picture
        : picture.isNotEmpty
            ? 'https://api.tayohealthcare.com/$picture'
            : '';

    final params = CallKitParams(
      id: uuid,
      nameCaller: data['callerName'] ?? 'Unknown Caller',
      appName: 'Tayo healthcare',
      avatar: avatarUrl,
      handle: data['callerPhone'] ?? '',
      type: int.tryParse(data['callType'] ?? '0') ?? 0,
      duration: 30000,
      textAccept: 'Accept',
      textDecline: 'Decline',
      extra: {
        'roomId': data['roomId'] ?? '',
        'callerToken': data['callerToken'] ?? '',
        'calleeToken': data['calleeToken'] ?? '',
        'callType': data['callType'] ?? '0',
        'doctor_id': data['doctor_id'] ?? '',
        'patient_id': data['patient_id'] ?? '',
        'isIncoming': 'true',
        'isCaller': 'false',
      },
      headers: <String, dynamic>{'apiKey': 'Abc@123'},
    );

    await FlutterCallkitIncoming.showCallkitIncoming(params);
    print('🔔 Background CallKit shown successfully with ID: $uuid');
  } catch (e) {
    print('❌ Error showing background CallKit: $e');
  }
}

@pragma('vm:entry-point')
Future<void> _endBackgroundCallDirect() async {
  try {
    await FlutterCallkitIncoming.endAllCalls();
    print('🔔 Background call ended successfully');
  } catch (e) {
    print('❌ Error ending background call: $e');
  }
}

@pragma('vm:entry-point')
Future<void> _showBackgroundNotification(RemoteMessage message) async {
  try {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidNotificationChannel defaultChannel = AndroidNotificationChannel(
      'default_channel',
      'Default',
      description: 'General notifications',
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(defaultChannel);

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'default_channel',
      'Default',
      channelDescription: 'General notifications',
      importance: Importance.high,
      priority: Priority.high,
      enableVibration: true,
      playSound: true,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    final title = message.data['title'] ??
        message.notification?.title ??
        'New Notification';
    final body = message.data['body'] ??
        message.notification?.body ??
        'You have a new notification';

    await flutterLocalNotificationsPlugin.show(
      message.hashCode,
      title,
      body,
      platformChannelSpecifics,
      payload: jsonEncode(message.data),
    );

    print('🔔 Background notification shown successfully');
  } catch (e) {
    print('❌ Error showing background notification: $e');
  }
}
