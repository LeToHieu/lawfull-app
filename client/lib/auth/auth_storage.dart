import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const String jwtKey = 'jwt';

  // Save JWT token to local storage
  static Future<void> saveJwt(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(jwtKey, token);
  }

  // Get JWT token from local storage
  static Future<String?> getJwt() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(jwtKey);
  }

  // Remove JWT token from local storage
  static Future<void> removeJwt() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(jwtKey);
  }
}
