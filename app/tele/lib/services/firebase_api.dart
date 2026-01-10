import 'dart:convert';
import 'package:tele/services/access_token_service.dart';
import 'package:tele/views/screens/components/config.dart';
import 'package:http/http.dart' as http;

class FirebaseApis {
  static final url = Config.baseUrl;

  Future<void> sendCallFCM(
    String token,
    String callerName,
    String roomId,
    String callerPhone,
    String picture,
    String callType,
    String callerToken,
    String calleeToken,
    String doctorId,
    String pateintId,
  ) async {
    final accessToken = await AccessTokenService().getAccessToken();
    final projectId = Config.firebaseprojectid;

    final url = Uri.parse(
      'https://fcm.googleapis.com/v1/projects/$projectId/messages:send',
    );
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        "message": {
          "token": token,
          "android": {
            "priority": "high",
            "notification": {
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              "channel_id": "call_channel",
              "sound": "default",
              "tag": "call_invitation",
              "sticky": false,
            }
          },
          "data": {
            "type": "call_invitation",
            "callerName": callerName,
            "roomId": roomId,
            "callerPhone": callerPhone,
            "picture": picture,
            "callType": callType,
            "callerToken": callerToken,
            "calleeToken": calleeToken,
            "doctor_id": doctorId,
            "patient_id": pateintId,
            "title": "Incoming Call",
            "body": "$callerName is calling you",
          }
        }
      }),
    );
    print("FCM send response: ${response.statusCode} ${response.body}");
  }

  Future<void> sendCallAcceptedFCM(
    String token,
    String doctorId,
    String patientId,
  ) async {
    try {
      final accessToken = await AccessTokenService().getAccessToken();
      final projectId = Config.firebaseprojectid;

      final url = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/$projectId/messages:send',
      );

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          "message": {
            "token": token,
            "data": {
              "type": "call_accepted",
              "doctor_id": doctorId,
              "patient_id": patientId,
            },
          }
        }),
      );

      print("FCM call_accepted response: ${response.statusCode} ${response.body}");
    } catch (e) {
      print('Error sending call_accepted FCM: $e');
    }
  }

  Future<void> sendCallEndFCM(
    String token,
    String doctorId,
    String patientId,
    String callId,
  ) async {
    try {
      final accessToken = await AccessTokenService().getAccessToken();
      final projectId = Config.firebaseprojectid;

      final url = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/$projectId/messages:send',
      );

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          "message": {
            "token": token,
            "notification": {
              "title": "Call Ended",
              "body": "The call has been ended",
            },
            "data": {
              "type": "call_end",
              "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
              "patient_id": patientId,
              "doctor_id": doctorId,
              "call_id": callId,
            },
            "android": {
              "priority": "high",
              "notification": {
                "click_action": "FLUTTER_NOTIFICATION_CLICK",
                "channel_id": "call_channel",
                "sound": "default"
              }
            },
          }
        }),
      );

      print("FCM send call_end response: ${response.statusCode} ${response.body}");
      if (response.statusCode != 200) {
        throw Exception('Failed to send call end FCM');
      }
    } catch (e) {
      print('Error sending call end FCM: $e');
      rethrow;
    }
  }

  Future<void> sendCallEndToBothFCM(
    String callerToken,
    String calleeToken,
    String doctorId,
    String patientId,
    String callId,
  ) async {
    await Future.wait([
      sendCallEndFCM(callerToken, doctorId, patientId, callId),
      sendCallEndFCM(calleeToken, doctorId, patientId, callId),
    ]);
  }
}
// import 'dart:convert';
// import 'package:tele/services/access_token_service.dart';
// import 'package:tele/views/screens/components/config.dart';
// import 'package:http/http.dart' as http;

// class FirebaseApis {
//   static final url = Config.baseUrl;

//   Future<void> sendCallFCM(
//     String token,
//     String callerName,
//     String roomId,
//     String callerPhone,
//     String picture,
//     String callType,
//     String callerToken,
//     String calleeToken,
//     String doctorId,
//     String pateintId,
//   ) async {
//     final accessToken = await AccessTokenService().getAccessToken();
//     final projectId = Config.firebaseprojectid;

//     final url = Uri.parse(
//       'https://fcm.googleapis.com/v1/projects/$projectId/messages:send',
//     );

//     final payload = {
//       "message": {
//         "token": token,
//         "android": {
//           "priority": "high"
//         },
//         "data": {
//           "type": "call_invitation",
//           "callerName": callerName,
//           "roomId": roomId,
//           "callerPhone": callerPhone,
//           "picture": picture,
//           "callType": callType,
//           "callerToken": callerToken,
//           "calleeToken": calleeToken,
//           "doctor_id": doctorId,
//           "patient_id": pateintId,
//           "title": "Incoming Call",
//           "body": "$callerName is calling you"
//         }
//       }
//     };

//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $accessToken',
//       },
//       body: jsonEncode(payload),
//     );

//     print("FCM call_invitation response: ${response.statusCode} ${response.body}");
//   }

//   Future<void> sendCallAcceptedFCM(
//     String token,
//     String doctorId,
//     String patientId,
//   ) async {
//     final accessToken = await AccessTokenService().getAccessToken();
//     final projectId = Config.firebaseprojectid;

//     final url = Uri.parse(
//       'https://fcm.googleapis.com/v1/projects/$projectId/messages:send',
//     );

//     final payload = {
//       "message": {
//         "token": token,
//         "android": {
//           "priority": "high"
//         },
//         "data": {
//           "type": "call_accepted",
//           "doctor_id": doctorId,
//           "patient_id": patientId,
//           "title": "Call Accepted",
//           "body": "Call accepted by other party"
//         }
//       }
//     };

//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $accessToken',
//       },
//       body: jsonEncode(payload),
//     );

//     print("FCM call_accepted response: ${response.statusCode} ${response.body}");
//   }

//   Future<void> sendCallEndFCM(
//     String token,
//     String doctorId,
//     String patientId,
//     String callId,
//   ) async {
//     final accessToken = await AccessTokenService().getAccessToken();
//     final projectId = Config.firebaseprojectid;

//     final url = Uri.parse(
//       'https://fcm.googleapis.com/v1/projects/$projectId/messages:send',
//     );

//     final payload = {
//       "message": {
//         "token": token,
//         "android": {
//           "priority": "high"
//         },
//         "data": {
//           "type": "call_end",
//           "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
//           "doctor_id": doctorId,
//           "patient_id": patientId,
//           "call_id": callId,
//           "title": "Call Ended",
//           "body": "The call has ended"
//         }
//       }
//     };

//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $accessToken',
//       },
//       body: jsonEncode(payload),
//     );

//     print("FCM call_end response: ${response.statusCode} ${response.body}");
//     if (response.statusCode != 200) {
//       throw Exception('Failed to send call end FCM');
//     }
//   }

//   Future<void> sendCallEndToBothFCM(
//     String callerToken,
//     String calleeToken,
//     String doctorId,
//     String patientId,
//     String callId,
//   ) async {
//     await Future.wait([
//       sendCallEndFCM(callerToken, doctorId, patientId, callId),
//       sendCallEndFCM(calleeToken, doctorId, patientId, callId),
//     ]);
//   }
// }
