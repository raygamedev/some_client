import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class User {
  Future<String> get _localPath async {
    debugPrint("Getting directory");
    final directory = await getApplicationDocumentsDirectory()
        .timeout(const Duration(seconds: 5));
    return directory.path;
  }

  String generateUserUUID() {
    return const Uuid().v4();
  }

  Future<File> writeUserUUID(String userUUID) async {
    final path = await _localPath;
    final file = File('$path/userUUID.txt');
    return file.writeAsString(userUUID);
  }

  Future<String> getUserUUID() async {
    final path = await _localPath;
    try {
      final file = File('$path/userUUID.txt');
      debugPrint("Getting userUUID");
      return await file.readAsString();
    } on FileSystemException {
      debugPrint("UserUUID not found");
      return '';
    }
  }
}
