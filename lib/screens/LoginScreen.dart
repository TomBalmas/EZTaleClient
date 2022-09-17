import 'package:ez_tale/EZNetworking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'EditorScreen.dart';
import 'HomeScreen.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({key,this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset('assets/EZTaleLogo.png'),
        ElevatedButton(
          child: const Text('Login'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditorScreen()),
            );
          }
        )
          ],
        ),
      ),
    );
  }

}

