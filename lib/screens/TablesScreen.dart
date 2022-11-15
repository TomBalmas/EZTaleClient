import 'dart:convert';

import 'package:flutter/material.dart';
import '../EZNetworking.dart';
import '../constants.dart';
import '../utils/Responsive.dart';
import '../widgets/Widgets.dart';

class TablesScreen extends StatelessWidget {
  const TablesScreen({key,@required this.tableOfContents});
  final tableOfContents;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: EZDrawer(),
        appBar: AppBar(
          title: const Text('Home'),
          foregroundColor: Colors.grey,
          backgroundColor: kBackgroundColor,
        ),
        body: Container(
          
        )
    );
  }
}