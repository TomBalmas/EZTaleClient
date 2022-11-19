import 'dart:convert';

import 'package:ez_tale/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../EZNetworking.dart';
import '../constants.dart';
import '../utils/Responsive.dart';
import '../widgets/EZBuildButton.dart';
import '../widgets/EZTableBuilder.dart';
import '../widgets/Widgets.dart';

class TablesScreen extends StatefulWidget {

  TablesScreen({
    key,
    @required this.tableOfContents,
    @required this.nameOfTable,
  });
  final tableOfContents;
  final nameOfTable;

  @override
  State<TablesScreen> createState() => _TablesScreenState();
}

class _TablesScreenState extends State<TablesScreen> {
  var buttonColor = Color.fromRGBO(0, 173, 181, 100);
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
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(widget.nameOfTable == 'Characters')
                    //TODO: Color change
                        BuildButton(
                          name: 'Characters',
                          bgColor: buttonColor,
                          textColor: Colors.black87,
                          onTap: (){},
                        ),
                        SizedBox(height: 16),
                        BuildButton(
                          name: 'Locations',
                          bgColor: buttonColor,
                          textColor: Colors.black87,
                          onTap: (){}
                        ),
                        SizedBox(height: 16),
                        BuildButton(
                          name: 'Conversations',
                          bgColor: buttonColor,
                          textColor: Colors.black87,
                          onTap: (){}
                        ),
                        SizedBox(height: 16),
                        BuildButton(
                          name: 'Custom',
                          bgColor: buttonColor,
                          textColor: Colors.black87,
                          onTap: (){}
                        ),
                        SizedBox(height: 16),
                        BuildButton(
                          name: 'Attribute Templates',
                          bgColor: buttonColor,
                          textColor: Colors.black87,
                          onTap: (){}
                        ),
                        SizedBox(height: 16),
                        BuildButton(
                          name: 'Events',
                          bgColor: buttonColor,
                          textColor: Colors.black87,
                          onTap: (){}
                        ),
                ]),
                SizedBox(width: 80),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BuildButton(
                            name: 'New Character',
                            bgColor: Color.fromRGBO(0, 173, 181, 100),
                            textColor: Colors.black87,
                            onTap: (){},
                          ),
                          BuildButton(
                            name: 'Back',
                            bgColor: Color.fromRGBO(0, 173, 181, 100),
                            textColor: Colors.black87,
                            onTap: (){
                              Navigator.pop(context);
                            },
                            width: 100,
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                      BuildTable()
                    ],
                  ))
            ])
          )
        )
    );
  }
}

