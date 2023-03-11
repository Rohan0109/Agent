import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/voter.dart';

class Shared {
  static Future<bool> setShared(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Authorization', 'Bearer ${data['Authorization']}');
    prefs.setBool('session', data['session']);
    prefs.setString('data', jsonEncode(data['data']).toString());
    return true;
  }

  static Future<bool> setAuthShared(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Authorization', 'Bearer ${data['Authorization']}');
    prefs.setBool('session', data['session']);
    return true;
  }

  static Future<bool> setPhonenumber(String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('phoneNumber', phone);
  }

  static updatedSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('session', 'UPDATED');
  }

  static Future<String> getPhonenumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phoneNumber').toString();
  }

  static Future<Voter> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return voterFromJson(prefs.getString('data').toString())[0];
  }

  static Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('Authorization').toString();
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
