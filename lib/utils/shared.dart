import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  static Future<bool> setShared(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', data['accessToken']);
    prefs.setString('session', data['session']);
    return true;
  }

  static updatedSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('session', 'UPDATED');
  }

  static getPhonenumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phoneNumber');
  }

  static getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  static getStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isUpdated', true);
  }

  static removeAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
