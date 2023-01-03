import 'package:ez_tale/main.dart';
import 'package:flutter/material.dart';

import '../widgets/Widgets.dart';

class MergeRequestScreen extends StatefulWidget {
  @override
  State<MergeRequestScreen> createState() => _MergeRequestScreenState();
}

class _MergeRequestScreenState extends State<MergeRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: EZDrawer(),
        appBar: AppBar(
          title: Text('Merge Requests'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: BuildTable(nameOfTable: 'MergeRequests',
            tableContent: MyApp.bookManager.getBookMergeRequests(),
          ),


        ));
  }
}
