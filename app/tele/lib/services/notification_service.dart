import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static const String _pendingNotificationKey = 'pending_notification';
  static const String _notificationHistoryKey = 'notification_history';

  // Store notification data when app is terminated
  static Future<void> storePendingNotification(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_pendingNotificationKey, jsonEncode(data));
    
    // Also add to history for debugging
    await _addToHistory(data);
  }

  // Retrieve and clear pending notification
  static Future<Map<String, dynamic>?> getPendingNotification() async {
    final prefs = await SharedPreferences.getInstance();
    final pendingJson = prefs.getString(_pendingNotificationKey);
    
    if (pendingJson != null) {
      await prefs.remove(_pendingNotificationKey);
      return jsonDecode(pendingJson) as Map<String, dynamic>;
    }
    
    return null;
  }

  // Add notification to history for debugging
  static Future<void> _addToHistory(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_notificationHistoryKey) ?? '[]';
    final history = jsonDecode(historyJson) as List;
    
    history.add({
      'data': data,
      'timestamp': DateTime.now().toIso8601String(),
    });
    
    // Keep only last 10 notifications
    if (history.length > 10) {
      history.removeAt(0);
    }
    
    await prefs.setString(_notificationHistoryKey, jsonEncode(history));
  }

  // Get notification history for debugging
  static Future<List<Map<String, dynamic>>> getNotificationHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_notificationHistoryKey) ?? '[]';
    final history = jsonDecode(historyJson) as List;
    
    return history.cast<Map<String, dynamic>>();
  }

  // Clear all notification data
  static Future<void> clearAllNotificationData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_pendingNotificationKey);
    await prefs.remove(_notificationHistoryKey);
  }
}