import 'dart:convert';

import 'package:ez_tale/screens/NewEntityScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../EZNetworking.dart';
import '../main.dart';
import '../widgets/EZBuildButton.dart';
import '../widgets/Widgets.dart';

// ignore: must_be_immutable
class ChooseRelation extends StatefulWidget {
  ChooseRelation({
    key,
    this.tableContent,
    this.nameOfTable,
  });
  var tableContent;
  var nameOfTable;

  @override
  State<ChooseRelation> createState() => _ChooseRelationState();
}

class _ChooseRelationState extends State<ChooseRelation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: EZDrawer(),
        appBar: AppBar(
          title: Text(widget.nameOfTable),
        ),
        body: Container(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Choose an entity to relate:',
                          style: TextStyle(fontSize: 64, color: Colors.grey),
                        ),
                        BuildButton(
                          name: 'Back',
                          bgColor: Color.fromRGBO(0, 173, 181, 100),
                          textColor: Colors.black87,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          width: 100,
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    Expanded(
                        child: ListView(children: [
                      BuildTable(
                          nameOfTable: widget.nameOfTable,
                          tableContent: widget.tableContent)
                    ]))
                  ],
                ))));
  }
}
