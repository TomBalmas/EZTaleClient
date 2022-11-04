import 'package:ez_tale/screens/Screens.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class EZDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          // Set the transparency here
          canvasColor: kBackgroundColor),
      child: Drawer(
        // add drawer to seperete file
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: kBackgroundColor,
              ),
              child: Text('EZTale'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('New Story'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewStoryScreen()),
                );
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('User Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserSettingsScreen()),
                );
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserSettingsScreen()),
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
