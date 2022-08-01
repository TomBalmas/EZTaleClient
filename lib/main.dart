import 'screens/LoginScreen.dart';
import 'package:flutter/material.dart';

void main() {
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EZTale',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(title: 'EZTale'),
    );
  }
}
