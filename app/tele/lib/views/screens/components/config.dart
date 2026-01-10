import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tele/services/StorageService.dart';

class Config {
  static final String baseUrl = dotenv.env['BASE_URL'] ?? 'http://localhost:5000';
  static final int appId = int.tryParse(dotenv.env['APPID'] ?? '0') ?? 0;
  static final String appSign = dotenv.env['APPSING'] ?? '';
  static final String firebaseapkey = dotenv.env['FIREBASE_API_KEY'] ?? '';
  static final String firebaseappid = dotenv.env['FIREBASE_APP_ID'] ?? '';
  static final String firebasemessagingsenderid = dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '';
  static final String firebaseprojectid = dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
   static Future<String?> getUserId() async {
    Map<String, String?> userData = await StorageService.getUserData();
    return userData["userId"];
  }
  static Future<String?> getUserType() async {
    Map<String, String?> userData = await StorageService.getUserData();
    return userData["userType"];
  }
  static Future<String?> getUserName() async {
    Map<String, String?> userData = await StorageService.getUserData();
    return userData["username"];
  }
 static Future<String?> getUserToken() async {
  Map<String, String?> userData = await StorageService.getUserData();
  return userData["token"];
}

}
