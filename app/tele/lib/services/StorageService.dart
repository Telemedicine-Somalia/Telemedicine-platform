
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static Future<void> saveUserData(
    String token, String userId, String username,int type,
    String email, String address,String gender, int age, String phone, String picture, String nickname
    ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setString('userId', userId);
    await prefs.setString('username', username);
    await prefs.setString('userType', type.toString());
    await prefs.setString('email', email);
    await prefs.setString('address', address);
    await prefs.setString('gender', gender);
    await prefs.setString('age', age.toString());
    await prefs.setString('phone', phone);
    await prefs.setString('picture', picture);
    await prefs.setString('nickname', nickname);
  }
  static Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      "token": prefs.getString('auth_token'),
      "userId": prefs.getString('userId'),
      "username": prefs.getString('username'),
      'userType': prefs.getString('userType'),
      'email': prefs.getString('email'),
      'address': prefs.getString('address'),
      'gender': prefs.getString('gender'),
      'age': prefs.getString('age'),
      'phone': prefs.getString('phone'),
      'picture': prefs.getString('picture'),
      'nickname': prefs.getString('nickname'),
    };
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('userId');
    await prefs.remove('username');
    await prefs.remove('userType');
    await prefs.remove('email');
    await prefs.remove('address');
    await prefs.remove('gender');
    await prefs.remove('age');
    await prefs.remove('phone');
    await prefs.remove('picture');
    await prefs.remove('nickname');
  }
  static Future<void> updateUserField(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

  // Language storage methods
  static Future<void> saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', languageCode);
  }

  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('selected_language') ?? 'en';
  }
  static Future<void> removeLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('selected_language');
    print('Saved language removed');
  }

}
