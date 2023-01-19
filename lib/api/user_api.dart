import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String _apiUrl = 'http://10.0.2.2:8000';

Future<void> signUpUser(String userUUID) async {
  debugPrint("Signing up user: $userUUID");
  try {
    final response =
        await http.post(Uri.parse('$_apiUrl/api/new_user?user_id=$userUUID'));
    if (response.statusCode == 200) {
      debugPrint('User signed up successfully');
    } else {
      debugPrint('Failed to sign up user');
    }
  } catch (e) {
    debugPrint("Failed to sign up user $e");
    debugPrint('Failed to sign up user');
  }
}

Future<bool> authenticateUser(String userUUID) async {
  try {
    debugPrint("Authenticating user: $userUUID");
    final response =
        await http.get(Uri.parse('$_apiUrl/api/auth?user_id=$userUUID'));
    if (response.statusCode == 200) {
      debugPrint('User authenticated successfully');
      return true;
    } else {
      debugPrint('Failed to authenticate user');
      return false;
    }
  } catch (e) {
    debugPrint('Failed to authenticate user');
    return false;
  }
}
