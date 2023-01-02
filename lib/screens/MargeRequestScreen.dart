import 'package:ez_tale/main.dart';
import 'package:flutter/material.dart';

import '../widgets/Widgets.dart';

class MargeRequestScreen extends StatefulWidget {
  @override
  State<MargeRequestScreen> createState() => _MargeRequestScreenState();
}

class _MargeRequestScreenState extends State<MargeRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: EZDrawer(),
        appBar: AppBar(
          title: Text('Marge Requests'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: BuildTable(nameOfTable: 'MargeRequests',
            tableContent: MyApp.bookManager.getBookMargeRequests(),
          ),


        ));
  }
}
