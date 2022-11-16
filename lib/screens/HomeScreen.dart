import 'package:flutter/material.dart';
import '../constants.dart';
import '../utils/Responsive.dart';
import '../widgets/Widgets.dart';
import 'home_screen_widgets/HomeScreenWidgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({key,@required this.booksList});
  final booksList;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        drawer: EZDrawer(),
        appBar: AppBar(
          title: const Text('Home'),
          foregroundColor: Colors.grey,
          backgroundColor: kBackgroundColor,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            primary: false,
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          MyBooks(
                            booksList: booksList,
                          ), // ----- change to books
                          SizedBox(height: defaultPadding),
                          //RecentFiles(),  -- change to recent books
                          if (Responsive.isMobile(context))
                            SizedBox(height: defaultPadding),
                          //if (Responsive.isMobile(context)) StarageDetails(),
                        ],
                      ),
                    ),
                    if (!Responsive.isMobile(context))
                      SizedBox(width: defaultPadding),
                    // On Mobile means if the screen is less than 850 we dont want to show it
                    // if (!Responsive.isMobile(context))
                    //   Expanded(
                    //     flex: 2,
                    //     child: StarageDetails(),
                    //   ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
