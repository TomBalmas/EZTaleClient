import 'dart:convert';

import 'package:ez_tale/main.dart';
import 'package:ez_tale/screens/Screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../EZNetworking.dart';
import '../constants.dart';

class EZDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          // Set the transparency here
          canvasColor: kTextFieldFill),
      child: Drawer(
        // add drawer to seperete file
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: kTextFieldFill,
              ),
              child: Text('EZTale', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.white30),
              title: const Text('Home', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => HomeScreen(
                            booksList: MyApp.userManager.getUserStoriesList(),
                          )),
                );
              },
            ),
            if (MyApp.bookManager.getBookName() != null)
              ListTile(
                leading: Icon(Icons.book, color: Colors.white30),
                title: const Text('Co-Writers',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  getDeadLines(MyApp.userManager.getCurrentUsername(),
                          MyApp.bookManager.getBookName())
                      .then(
                    (value) {
                      final data = jsonDecode(value);
                      print(data);
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => CowritersScreen(data)),
                      );
                    },
                  );

                  // Update the state of the app.
                  // ...
                },
              ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white30),
              title: const Text('User Settings',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => UserSettingsScreen()),
                );
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.white30),
              title:
                  const Text('Logout', style: TextStyle(color: Colors.white)),
              onTap: () {
                MyApp.userManager.logout();
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => LoginScreen()),
                );
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }
}
