

import 'dart:convert';

import 'package:ez_tale/EZNetworking.dart';
import 'package:ez_tale/screens/TablesScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import '../constants.dart';
import '../widgets/EZBuildButton.dart';
import '../widgets/Widgets.dart';


class EditorScreen extends StatefulWidget {

    EditorScreen({
    key,
    this.bookName,
  });
  final bookName;

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  quill.QuillController _controller = quill.QuillController.basic();
  Color repeatedWordsColor = Colors.red, tenseTrackingColor = Colors.red, turningPointsColor = Colors.red;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: EZDrawer(),
      appBar: AppBar(
        title: Text('book1'),
      ), //TODO: correct the name
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child:Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BuildButton(
                          name: 'Characters',
                          bgColor: Color.fromRGBO(0, 173, 181, 100),
                          textColor: Colors.black87,
                          onTap: (){
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => TablesScreen(
                                        tableOfContents: null,
                                        nameOfTable: 'Characters',
                                  )
                              )
                            );
                          }
                        ),
                        SizedBox(height: 16),
                        BuildButton(
                          name: 'Locations',
                          bgColor: Color.fromRGBO(0, 173, 181, 100),
                          textColor: Colors.black87,
                          onTap: (){
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => TablesScreen(
                                        tableOfContents: null,
                                        nameOfTable: 'Locations',
                                  )
                              )
                            );
                          }
                        ),
                        SizedBox(height: 16),
                        BuildButton(
                          name: 'Conversations',
                          bgColor: Color.fromRGBO(0, 173, 181, 100),
                          textColor: Colors.black87,
                          onTap: (){
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => TablesScreen(
                                        tableOfContents: null,
                                        nameOfTable: 'Conversations',
                                  )
                              )
                            );
                          }
                        ),
                        SizedBox(height: 16),
                        BuildButton(
                          name: 'Custom',
                          bgColor: Color.fromRGBO(0, 173, 181, 100),
                          textColor: Colors.black87,
                          onTap: (){
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => TablesScreen(
                                        tableOfContents: null,
                                        nameOfTable: 'Custom',
                                  )
                              )
                            );
                          }
                        ),
                        SizedBox(height: 16),
                        BuildButton(
                          name: 'Attribute Templates',
                          bgColor: Color.fromRGBO(0, 173, 181, 100),
                          textColor: Colors.black87,
                          onTap: (){
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => TablesScreen(
                                        tableOfContents: null,
                                        nameOfTable: 'Attribute Templates',
                                  )
                              )
                            );
                          }
                        ),
                        SizedBox(height: 16),
                        BuildButton(
                          name: 'Events',
                          bgColor: Color.fromRGBO(0, 173, 181, 100),
                          textColor: Colors.black87,
                          onTap: (){
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => TablesScreen(
                                        tableOfContents: null,
                                        nameOfTable: 'Events',
                                  )
                              )
                            );
                          }
                        ),
                        SizedBox(height: 16),
                        BuildButton(
                          name: 'Co-Writers',
                          bgColor: Color.fromRGBO(0, 173, 181, 100),
                          textColor: Colors.black87,
                          onTap: (){}
                        ),
                      ]),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BuildButton(
                                  name: 'Send',
                                  bgColor: Color.fromRGBO(0, 173, 181, 100),
                                  textColor: Colors.black87,
                                  onTap: (){},
                                  width: 100,
                                ),
                                SizedBox(width: 16),
                                BuildButton(
                                  name: 'Update',
                                  bgColor: Color.fromRGBO(0, 173, 181, 100),
                                  textColor: Colors.black87,
                                  onTap: (){},
                                  width: 100,
                                ),
                                SizedBox(width: 16),
                                BuildButton(
                                  name: 'Merge Requests',
                                  bgColor: Color.fromRGBO(0, 173, 181, 100),
                                  textColor: Colors.black87,
                                  onTap: (){},
                                  width: 100,
                                ),
                                Spacer(
                                  flex: 3
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
                              ]),
                            ),
                            SizedBox(height: 16),
                            quill.QuillToolbar.basic(
                              controller: _controller,
                              showFontFamily: false,
                              showFontSize: false,
                            ),
                            SizedBox(height: 16),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 5, color: Colors.blue),
                                  color: Colors.white
                                ),
                                child: quill.QuillEditor.basic(
                                  controller: _controller,
                                  readOnly: false, // true for view only mode
                                ),
                              ),
                            ),
                    ])
                    )
                  ]),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 450,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(width: 5, color: Colors.blue),
                        color: Colors.white
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 7),
                          Text('Editor Options:'),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BuildButton(
                                name: 'Repeated Words',
                                bgColor: repeatedWordsColor,
                                textColor: Colors.black87,
                                onTap: (){
                                  setState(() {
                                    if(repeatedWordsColor == Colors.red)
                                      repeatedWordsColor = Colors.green;
                                    else
                                      repeatedWordsColor = Colors.red;
                                  });
                                },
                                width: 100,
                              ),
                              SizedBox(width: 16),
                              BuildButton(
                                name: 'Tense Tracking',
                                bgColor: tenseTrackingColor,
                                textColor: Colors.black87,
                                onTap: (){
                                  setState(() {
                                    if(tenseTrackingColor == Colors.red)
                                      tenseTrackingColor = Colors.green;
                                    else
                                      tenseTrackingColor = Colors.red;
                                  });
                                },
                                width: 100,
                              ),
                              SizedBox(width: 16),
                              BuildButton(
                                name: 'Turning Points',
                                bgColor: turningPointsColor,
                                textColor: Colors.black87,
                                onTap: (){
                                  setState(() {
                                    if(turningPointsColor == Colors.red)
                                      turningPointsColor = Colors.green;
                                    else
                                      turningPointsColor = Colors.red;
                                  });
                                },
                                width: 100,
                              )
                          ])
                        ],
                      )
                    ),
                    SizedBox(width: 16),
                    BuildButton(
                      name: 'Manual Save',
                      bgColor: Color.fromRGBO(0, 173, 181, 100),
                      textColor: Colors.black87,
                      onTap: (){},
                      height: 100,
                    ),
                  ])
              )
          ]),
        )
      )
    );

  }
}