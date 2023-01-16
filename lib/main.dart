import 'package:flutter/material.dart';
import 'package:some_client/homepage.dart';

void main() async {
  runApp(Some());
}

class Some extends StatefulWidget {
  const Some({super.key});

  @override
  State<Some> createState() => _SomeState();
}

class _SomeState extends State<Some> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
