import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tele/services/firebase_notification_handler.dart';
import 'package:tele/services/notification_debug_helper.dart';

class NotificationTestHelper {
  static Future<void> simulateNotification(
    FirebaseNotificationHandler handler,
    String type,
  ) async {
    // Create a fake RemoteMessage for testing
    final testMessage = RemoteMessage(
      messageId: 'test_${DateTime.now().millisecondsSinceEpoch}',
      data: {'type': type},
      // The notification field is omitted because RemoteMessageNotification cannot be constructed directly.
    );

    await NotificationDebugHelper.logNotificationEvent(
      'Simulating notification', 
      {'type': type}
    );

    // Simulate handling the notification data directly
    await handler.handleNotificationNavigation(testMessage.data);
  }

  static Future<void> testAllNotificationTypes(
    FirebaseNotificationHandler handler,
  ) async {
    final types = [
      'appointment_booking',
      'appointment_completed',
      're_appointment',
      'new_prescription',
      'lab_upload',
      'Test',
      'remmembaring_appointment',
    ];

    for (final type in types) {
      await simulateNotification(handler, type);
      await Future.delayed(Duration(seconds: 2)); // Wait between notifications
    }
  }
}