import 'package:flutter/material.dart';
import 'package:tele/services/firebase_api.dart';
import 'package:tele/services/StorageService.dart';

class CallTestHelper {
  static Future<void> testBackgroundCall() async {
    try {
      print('🧪 Testing background call functionality...');

      // Get current user data
      final userData = await StorageService.getUserData();
      final userId = userData['userId'] ?? '';

      if (userId.isEmpty) {
        print('❌ No user ID found. Please login first.');
        return;
      }

      // Test FCM token (you would need to get the actual FCM token of the target device)
      const testToken = 'clE_XhmtSH6f4iXSJ3DceO:APA91bGiO6RzwXALxlxWfJr0Q-pRzsWXGTG7y6dpF2Ft2-Mwv5XhDg2TmSrjgB88PD99N94Kz1suGGDAlzPTqf-TKwkouvHlGZJAA_zcwvugUpRJyb7_z94'; // Replace with actual token

      // Send a test call invitation
      await FirebaseApis().sendCallFCM(
        testToken,
        'Test Caller', // callerName
        'test_room_123', // roomId
        '+1234567890', // callerPhone
        '', // picture
        '0', // callType (0 for voice, 1 for video)
        'caller_token_123', // callerToken
        'callee_token_456', // calleeToken
        'doctor_123', // doctorId
        'patient_456', // patientId
      );

      print('✅ Test call invitation sent successfully!');
      print('📱 Check if CallKit appears on the target device');
    } catch (e) {
      print('❌ Error testing background call: $e');
    }
  }

  static Widget buildTestButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await testBackgroundCall();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Test call sent! Check console for details.'),
            duration: Duration(seconds: 3),
          ),
        );
      },
      child: const Text('Test Background Call'),
    );
  }

  static void showCallTestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Background Call Test'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('This will test the background call functionality.'),
              SizedBox(height: 10),
              Text('Steps to test:'),
              Text('1. Make sure the app is in background'),
              Text('2. Tap the test button'),
              Text('3. Check if CallKit appears'),
              SizedBox(height: 10),
              Text(
                  'Note: You need to replace the test FCM token with a real one.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await testBackgroundCall();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Test call sent! Check if CallKit appears.'),
                    duration: Duration(seconds: 3),
                  ),
                );
              },
              child: const Text('Send Test Call'),
            ),
          ],
        );
      },
    );
  }
}
