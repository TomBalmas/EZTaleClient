import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/Widgets.dart';

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
        
      )
    );
  }
}
