import 'package:ez_tale/EZNetworking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'LoginScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Theme(
        data: Theme.of(context).copyWith(
          // Set the transparency here
          canvasColor: Colors.grey.withOpacity(0.5)
        ),
        child: Drawer( // add drawer to seperete file
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
                child: Text('EZTale'),
              ),
              ListTile(
                title: const Text('Home'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Editor'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Home'),
        foregroundColor: Colors.black,
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //createUser("tom");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
