import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:some_client/main.dart';
import 'package:some_client/user.dart';

void main() {
  testWidgets("description", (widgetTester) async {
    await widgetTester.pumpWidget(Some(user: User()));
    debugPrint("lol");
    await User().getUserUUID();
  });
}
