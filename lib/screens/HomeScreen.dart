import 'package:ez_tale/EZNetworking.dart';
import 'package:ez_tale/screens/EditorScreen.dart';
import 'package:ez_tale/widgets/EZDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'LoginScreen.dart';
import '../constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: EZDrawer(),
      appBar: AppBar(
        title: const Text('Home'),
        foregroundColor: Colors.grey,
        backgroundColor: kBackgroundColor,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
