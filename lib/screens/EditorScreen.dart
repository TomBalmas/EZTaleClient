import 'dart:convert';

import 'package:ez_tale/EZNetworking.dart';
import 'package:ez_tale/constants.dart';
import 'package:ez_tale/screens/HomeScreen.dart';
import 'package:ez_tale/screens/TablesScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import '../widgets/EZBuildButton.dart';
import '../widgets/Widgets.dart';
import 'package:ez_tale/main.dart';

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
  quill.QuillController quillController = quill.QuillController.basic();
  Color repeatedWordsColor = Colors.red,
      tenseTrackingColor = Colors.red,
      turningPointsColor = Colors.red,
      saveButtonColor = Color.fromRGBO(0, 173, 181, 100);
  String saveButtonName = 'Save';
  Text pageNumber = Text('1');
  Text lastPageNumber = Text('');
  bool newPageStateFlag = false;
  bool firstTimeFlag = true;

  @override
  Widget build(BuildContext context) {
    if (firstTimeFlag) {
      getNumberOfPages(MyApp.userManager.getCurrentUsername(),
              MyApp.bookManager.getBookName())
          .then((value) {
        final data = jsonDecode(value);
        lastPageNumber = Text(data['msg']);
        setState(() {});
      });
      getPage(MyApp.userManager.getCurrentUsername(),
              MyApp.bookManager.getBookName(), pageNumber.data)
          .then((value) {
        final data = jsonDecode(value);
        data['content'] =
            data['content'].substring(0, data['content'].length - 1);
        quillController.document.insert(0, data['content']);
      });
      firstTimeFlag = false;
    }
    return Scaffold(
        drawer: EZDrawer(),
        appBar: AppBar(
          title: Text(MyApp.bookManager.getBookName()),
        ),
        body: Container(
            child: Padding(
          padding: EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              flex: 2,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  BuildButton(
                      name: 'Characters',
                      bgColor: Color.fromRGBO(0, 173, 181, 100),
                      textColor: Colors.black87,
                      onTap: () {
                        getAllTypeEntities(
                                MyApp.bookManager.getBookName(),
                                MyApp.userManager.getCurrentUsername(),
                                'character')
                            .then((value) {
                          final data = jsonDecode(value);
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => TablesScreen(
                                        tableContent: data,
                                        nameOfTable: 'Characters',
                                      )));
                        });
                      }),
                  SizedBox(height: 16),
                  BuildButton(
                      name: 'Locations',
                      bgColor: Color.fromRGBO(0, 173, 181, 100),
                      textColor: Colors.black87,
                      onTap: () {
                        getAllTypeEntities(
                                MyApp.bookManager.getBookName(),
                                MyApp.userManager.getCurrentUsername(),
                                'location')
                            .then((value) {
                          final data = jsonDecode(value);
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => TablesScreen(
                                        tableContent: data,
                                        nameOfTable: 'Locations',
                                      )));
                        });
                      }),
                  SizedBox(height: 16),
                  BuildButton(
                      name: 'Custom',
                      bgColor: Color.fromRGBO(0, 173, 181, 100),
                      textColor: Colors.black87,
                      onTap: () {
                        getAllTypeEntities(
                                MyApp.bookManager.getBookName(),
                                MyApp.userManager.getCurrentUsername(),
                                'userDefined')
                            .then((value) {
                          final data = jsonDecode(value);
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => TablesScreen(
                                        tableContent: data,
                                        nameOfTable: 'Custom',
                                      )));
                        });
                      }),
                  SizedBox(height: 16),
                  BuildButton(
                      name: 'Attribute Templates',
                      bgColor: Color.fromRGBO(0, 173, 181, 100),
                      textColor: Colors.black87,
                      onTap: () {
                        getAllTypeEntities(
                                MyApp.bookManager.getBookName(),
                                MyApp.userManager.getCurrentUsername(),
                                'atrributeTemplate')
                            .then((value) {
                          final data = jsonDecode(value);
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => TablesScreen(
                                        tableContent: data,
                                        nameOfTable: 'Attribute Templates',
                                      )));
                        });
                      }),
                  SizedBox(height: 16),
                  BuildButton(
                      name: 'Events',
                      bgColor: Color.fromRGBO(0, 173, 181, 100),
                      textColor: Colors.black87,
                      onTap: () {
                        getAllTypeEntities(MyApp.bookManager.getBookName(),
                                MyApp.userManager.getCurrentUsername(), 'storyEvent')
                            .then((value) {
                          final data = jsonDecode(value);
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => TablesScreen(
                                        tableContent: data,
                                        nameOfTable: 'Events',
                                      )));
                        });
                      }),
                ]),
                SizedBox(width: 16),
                Expanded(
                    child: Column(children: [
                  Expanded(
                    flex: 0,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BuildButton(
                            name: 'Send',
                            bgColor: Color.fromRGBO(0, 173, 181, 100),
                            textColor: Colors.black87,
                            onTap: () {},
                            width: 100,
                          ),
                          SizedBox(width: 16),
                          BuildButton(
                            name: 'Update',
                            bgColor: Color.fromRGBO(0, 173, 181, 100),
                            textColor: Colors.black87,
                            onTap: () {},
                            width: 100,
                          ),
                          SizedBox(width: 16),
                          BuildButton(
                            name: 'Merge Requests',
                            bgColor: Color.fromRGBO(0, 173, 181, 100),
                            textColor: Colors.black87,
                            onTap: () {},
                            width: 100,
                          ),
                          Spacer(flex: 3),
                          BuildButton(
                            name: 'Back',
                            bgColor: Color.fromRGBO(0, 173, 181, 100),
                            textColor: Colors.black87,
                            onTap: () {
                              MyApp.bookManager.exitBook();
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => HomeScreen(
                                          booksList: MyApp.userManager
                                              .getUserStoriesList())));
                            },
                            width: 100,
                          )
                        ]),
                  ),
                  SizedBox(height: 16),
                  quill.QuillToolbar.basic(controller: quillController),
                  SizedBox(height: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 5, color: Colors.black87),
                          color: kBackgroundColor),
                      child: quill.QuillEditor.basic(
                        controller: quillController,
                        readOnly: false, // true for view only mode
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                      flex: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BuildButton(
                            name: '<',
                            bgColor: Color.fromRGBO(0, 173, 181, 100),
                            textColor: Colors.black87,
                            onTap: () {
                              int num = int.parse(pageNumber.data);
                              if (num == 1) return;
                              if (newPageStateFlag) {
                                newPageStateFlag = false;
                                saveButtonColor =
                                    Color.fromRGBO(0, 173, 181, 100);
                                saveButtonName = 'Save';
                              }
                              String page =
                                  quillController.document.toPlainText();
                              savePage(
                                      MyApp.userManager.getCurrentUsername(),
                                      MyApp.bookManager.getBookName(),
                                      pageNumber.data,
                                      page)
                                  .then((value) {
                                num--;
                                pageNumber = Text(num.toString());
                                getPage(
                                        MyApp.userManager.getCurrentUsername(),
                                        MyApp.bookManager.getBookName(),
                                        pageNumber.data)
                                    .then((value) {
                                  final data = jsonDecode(value);
                                  quillController.clear();
                                  data['content'] = data['content']
                                      .substring(0, data['content'].length - 1);
                                  quillController.document
                                      .insert(0, data['content']);
                                  setState(() {});
                                });
                              });
                            },
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(width: 16),
                          pageNumber,
                          Text('/'),
                          lastPageNumber,
                          SizedBox(width: 16),
                          BuildButton(
                            name: '>',
                            bgColor: Color.fromRGBO(0, 173, 181, 100),
                            textColor: Colors.black87,
                            onTap: () {
                              int pageNum = int.parse(pageNumber.data);
                              int lastPageNum = int.parse(lastPageNumber.data);
                              if (pageNum == (lastPageNum + 1)) return;
                              savePage(
                                      MyApp.userManager.getCurrentUsername(),
                                      MyApp.bookManager.getBookName(),
                                      pageNumber.data,
                                      quillController.document.toPlainText())
                                  .then((value) {
                                if (pageNum == lastPageNum) {
                                  newPageStateFlag = true;
                                  saveButtonColor = Colors.red;
                                  saveButtonName = 'Add new page';
                                  quillController.clear();
                                  pageNum++;
                                  pageNumber = Text(pageNum.toString());
                                  setState(() {});
                                } else if (pageNum <= lastPageNum) {
                                  pageNum++;
                                  pageNumber = Text(pageNum.toString());
                                  quillController.clear();
                                  getPage(
                                          MyApp.userManager
                                              .getCurrentUsername(),
                                          MyApp.bookManager.getBookName(),
                                          pageNumber.data)
                                      .then((value) {
                                    final data = jsonDecode(value);
                                    data['content'] = data['content'].substring(
                                        0, data['content'].length - 1);
                                    quillController.document
                                        .insert(0, data['content']);
                                    setState(() {});
                                  });
                                }
                              });
                            },
                            width: 50,
                            height: 50,
                          ),
                        ],
                      ))
                ]))
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
                          border: Border.all(width: 5, color: Colors.black87),
                          color: kBackgroundColor),
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
                                  onTap: () {
                                    setState(() {
                                      if (repeatedWordsColor == Colors.red)
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
                                  onTap: () {
                                    setState(() {
                                      if (tenseTrackingColor == Colors.red)
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
                                  onTap: () {
                                    setState(() {
                                      if (turningPointsColor == Colors.red)
                                        turningPointsColor = Colors.green;
                                      else
                                        turningPointsColor = Colors.red;
                                    });
                                  },
                                  width: 100,
                                )
                              ])
                        ],
                      )),
                  SizedBox(width: 16),
                  BuildButton(
                    name: saveButtonName,
                    bgColor: saveButtonColor,
                    textColor: Colors.black87,
                    onTap: () {
                      savePage(
                              MyApp.userManager.getCurrentUsername(),
                              MyApp.bookManager.getBookName(),
                              pageNumber.data,
                              quillController.document.toPlainText())
                          .then((value) {
                        saveButtonName = 'Save';
                        saveButtonColor = Color.fromRGBO(0, 173, 181, 100);
                        if (newPageStateFlag) {
                          int lastPageNum = int.parse(lastPageNumber.data);
                          lastPageNum++;
                          lastPageNumber = Text(lastPageNum.toString());
                          newPageStateFlag = false;
                        }
                        setState(() {});
                      });
                    },
                    height: 100,
                  )
                ]))
          ]),
        )));
  }
}
