import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

const String _apiUrl = 'http://localhost:8000';

Future<CardModel> requestNewCard(String userUUID, String merchantId) async {
  debugPrint("Requesting card for: $userUUID, merchantId: $merchantId");
  try {
    final response = await http.put(Uri.parse(
        '$_apiUrl/api/new_card?user_id=$userUUID&merchant_id=$merchantId'));
    if (response.statusCode == 200) {
      return CardModel.fromJson(jsonDecode(response.body));
    } else {
      debugPrint('Failed to request card');
      return CardModel.error();
    }
  } catch (e) {
    print(e);
    debugPrint('Failed to request card');
    return CardModel.error();
  }
}

Future<bool> authenticateUser(String userUUID) async {
  try {
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
