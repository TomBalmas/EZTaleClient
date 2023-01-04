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
    print(MyApp.bookManager.getBookMergeRequests());
    return Scaffold(
        drawer: EZDrawer(),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Merge Requests'),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          child: BuildTable(
            nameOfTable: 'MergeRequests',
            tableContent: MyApp.bookManager.getBookMergeRequests(),
          ),
        ));
  }
}
