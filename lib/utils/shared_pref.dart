import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  static final SharePref _instance = SharePref._internal();
  factory SharePref() => _instance;
  SharePref._internal();
  static String selectedLanguage = Platform.localeName.split('_')[0];

  Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
