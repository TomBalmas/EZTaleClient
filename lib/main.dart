import 'package:ez_tale/EZNetworking.dart';
import 'package:ez_tale/utils/EZUserManager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'screens/Screens.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

// Main Function
class MyApp extends StatelessWidget {
  static final EZUserManager userManager =
      new EZUserManager(); //singleton for current user info
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EZTale',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        scaffoldBackgroundColor: kBackgroundColor,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}
