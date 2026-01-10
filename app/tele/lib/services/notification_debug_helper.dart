import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tele/services/notification_service.dart';

class NotificationDebugHelper {
  static Future<void> showDebugInfo(BuildContext context) async {
    final history = await NotificationService.getNotificationHistory();
    final prefs = await SharedPreferences.getInstance();
    final userType = prefs.getString('userType');
    final authToken = prefs.getString('auth_token');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Notification Debug Info'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('User Type: ${userType ?? 'Not set'}'),
              Text('Auth Token: ${authToken != null ? 'Set' : 'Not set'}'),
              SizedBox(height: 16),
              Text('Recent Notifications:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              ...history.map((notification) => Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Time: ${notification['timestamp']}'),
                      Text('Type: ${notification['data']['type'] ?? 'Unknown'}'),
                      Text('Data: ${jsonEncode(notification['data'])}'),
                    ],
                  ),
                ),
              )).toList(),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await NotificationService.clearAllNotificationData();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Debug data cleared')),
              );
            },
            child: Text('Clear Debug Data'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
  
  static Future<void> logNotificationEvent(String event, Map<String, dynamic>? data) async {
    print('🔔 NOTIFICATION DEBUG: $event');
    if (data != null) {
      print('📱 Data: ${jsonEncode(data)}');
    }
    print('⏰ Time: ${DateTime.now().toIso8601String()}');
    print('---');
  }
}