
import 'package:ez_tale/screens/NewEntityScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/EZBuildButton.dart';
import '../widgets/EZTableBuilder.dart';
import '../widgets/Widgets.dart';

// ignore: must_be_immutable
class TablesScreen extends StatefulWidget {

  TablesScreen({
    key,
    this.tableOfContents,
    this.nameOfTable,
  });
  var tableOfContents;
  var nameOfTable;

  @override
  State<TablesScreen> createState() => _TablesScreenState();
}

class _TablesScreenState extends State<TablesScreen> {
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
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                        BuildButton(
                          name: 'Characters',
                          bgColor: colorButtonGrey(widget.nameOfTable, 'Characters'),
                          textColor: Colors.black87,
                          onTap: (){
                            setState(() {
                              widget.nameOfTable = 'Characters';
                            });
                          },
                        ),
                        SizedBox(height: 16),
                        BuildButton(
                          name: 'Locations',
                          bgColor: colorButtonGrey(widget.nameOfTable, 'Locations'),
                          textColor: Colors.black87,
                          onTap: (){
                            setState(() {
                              widget.nameOfTable = 'Locations';
                            });
                          }
                        ),
                        SizedBox(height: 16),
                        BuildButton(
                          name: 'Conversations',
                          bgColor: colorButtonGrey(widget.nameOfTable, 'Conversations'),
                          textColor: Colors.black87,
                          onTap: (){
                            setState(() {
                              widget.nameOfTable = 'Conversations';
                            });
                          }
                        ),
                        SizedBox(height: 16),
                        BuildButton(
                          name: 'Custom',
                          bgColor: colorButtonGrey(widget.nameOfTable, 'Custom'),
                          textColor: Colors.black87,
                          onTap: (){
                            setState(() {
                              widget.nameOfTable = 'Custom';
                            });
                          }
                        ),
                        SizedBox(height: 16),
                        BuildButton(
                          name: 'Attribute Templates',
                          bgColor: colorButtonGrey(widget.nameOfTable, 'Attribute Templates'),
                          textColor: Colors.black87,
                          onTap: (){
                            setState(() {
                              widget.nameOfTable = 'Attribute Templates';
                            });
                          }
                        ),
                        SizedBox(height: 16),
                        BuildButton(
                          name: 'Events',
                          bgColor: colorButtonGrey(widget.nameOfTable, 'Events'),
                          textColor: Colors.black87,
                          onTap: (){
                            setState(() {
                              widget.nameOfTable = 'Events';
                            });
                          }
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
                            name: nameOfNewEntityButton(widget.nameOfTable), // new entity's name
                            bgColor: Color.fromRGBO(0, 173, 181, 100),
                            textColor: Colors.black87,
                            onTap: (){
                              Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => NewEntityScreen(
                                    nameOfEntity: nameOfNewEntityButton(widget.nameOfTable))
                              )
                            );
                            },
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

Color colorButtonGrey(String nameOfTable, String nameOfButton){
  if(nameOfTable == nameOfButton)
    return Colors.grey;
  else
    return Color.fromRGBO(0, 173, 181, 100);
}

/*
Removes the last character of a given string.
This function is specific for the entity buttons on this screen.
*/ 
String nameOfNewEntityButton(String str){
  if(str == 'Custom')
    return 'New ' + str + ' Entity';
  else if (str != null && str.length > 0) 
    return 'New ' + str.substring(0, str.length - 1);
  return str;
}