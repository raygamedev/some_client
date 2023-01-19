import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:some_client/core/error_handling/exceptions.dart';

import '../models/models.dart';

const String _apiUrl = 'http://10.0.2.2:8000';

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
    debugPrint('Failed to request card');
    return CardModel.error();
  }
}

Future<CardModel> getActiveCard(String userUUID, String merchantId) async {
  try {
    final response = await http.get(Uri.parse(
        '$_apiUrl/api/active_card?user_id=$userUUID&merchant_id=$merchantId'));
    if (response.statusCode == 200) {
      return CardModel.fromJson(jsonDecode(response.body));
    } else {
      debugPrint('Failed to authenticate user');
      return CardModel.error();
    }
  } catch (e) {
    debugPrint('Failed to authenticate user');
    return CardModel.error();
  }
}

Future<CardModel> markCard(
    String userUUID, String merchantId, int markIndex) async {
  try {
    print(userUUID + "lols");
    final response = await http.put(Uri.parse(
        '$_apiUrl/api/add_mark?user_id=$userUUID&merchant_id=$merchantId&mark_index=$markIndex'));
    if (response.statusCode == 200) {
      return CardModel.fromJson(jsonDecode(response.body));
    }
  } catch (e) {
    debugPrint("err handling MarkCard $e");
  }
  throw GetCardError();
}
