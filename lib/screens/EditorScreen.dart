import 'dart:convert';

import 'package:ez_tale/EZNetworking.dart';
import 'package:ez_tale/constants.dart';
import 'package:ez_tale/screens/HomeScreen.dart';
import 'package:ez_tale/screens/MergeRequestScreen.dart';
import 'package:ez_tale/screens/TablesScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import '../widgets/EZBuildButton.dart';
import '../widgets/Widgets.dart';
import 'package:ez_tale/main.dart';

class EditorScreen extends StatefulWidget {
  EditorScreen(
      {key,
      this.bookName,
      @required this.isWatch,
      @required this.isCoBook,
      this.coWriterName});
  final isWatch;
  final bookName;
  final isCoBook;
  final coWriterName;

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  quill.QuillController quillController = quill.QuillController.basic();
  Color repeatedWordsColor = Colors.red,
      tenseTrackingColor = Colors.red,
      turningPointsColor = Colors.red,
      saveButtonColor = Color.fromRGBO(0, 173, 181, 100);
  bool repeatedWordsFlag = false;
  String saveButtonName = 'Save';
  Text pageNumber = Text('1');
  Text lastPageNumber = Text('');
  bool newPageStateFlag = false;
  bool firstTimeFlag = true;
  bool accepted = false;

  showAlertDiaglog(
      BuildContext context, String alt, String desc, Function func) async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(alt),
        content: Text(desc),
        actions: <Widget>[
          TextButton(
            onPressed: func,
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (firstTimeFlag) {
      if (!widget.isCoBook) {
        getNumberOfPages(MyApp.bookManager.getOwnerUsername(),
                MyApp.bookManager.getBookName())
            .then((value) {
          final data = jsonDecode(value);
          lastPageNumber = Text(data['msg']);
          setState(() {});
        });
        getPage(MyApp.bookManager.getOwnerUsername(),
                MyApp.bookManager.getBookName(), pageNumber.data)
            .then((value) {
          final data = jsonDecode(value);
          data['content'] =
              data['content'].substring(0, data['content'].length - 1);
          quillController.document.insert(0, data['content']);
        });
        firstTimeFlag = false;
      } else {
        getCowtiternumberofpages(MyApp.bookManager.getOwnerUsername(),
                MyApp.bookManager.getBookName(), widget.coWriterName)
            .then((value) {
          final data = jsonDecode(value);
          lastPageNumber = Text(data['msg']);
          checkMergeAccepted(MyApp.bookManager.getOwnerUsername(),
                  MyApp.bookManager.getBookName(), widget.coWriterName)
              .then((source) {
            final dataAccepted = jsonDecode(source);
            accepted = dataAccepted['msg'] == 'found';
            setState(() {});
          });
        });
        getCowriterPage(
                MyApp.bookManager.getOwnerUsername(),
                MyApp.bookManager.getBookName(),
                pageNumber.data,
                widget.coWriterName)
            .then((value) {
          final data = jsonDecode(value);
          data['content'] =
              data['content'].substring(0, data['content'].length - 1);
          quillController.document.insert(0, data['content']);
        });
        firstTimeFlag = false;
      }
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
                                MyApp.bookManager.getOwnerUsername(),
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
                                MyApp.bookManager.getOwnerUsername(),
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
                                MyApp.bookManager.getOwnerUsername(),
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
                                MyApp.bookManager.getOwnerUsername(),
                                'attributeTemplate')
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
                        getAllTypeEntities(
                                MyApp.bookManager.getBookName(),
                                MyApp.bookManager.getOwnerUsername(),
                                'storyEvent')
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
                  SizedBox(height: 100),
                  if (!widget.isWatch)
                    BuildButton(
                      name: saveButtonName,
                      bgColor: saveButtonColor,
                      textColor: Colors.black87,
                      onTap: () {
                        if (widget.isCoBook)
                          saveCowriterPage(
                                  MyApp.bookManager.getOwnerUsername(),
                                  MyApp.bookManager.getBookName(),
                                  pageNumber.data,
                                  quillController.document.toPlainText(),
                                  widget.coWriterName)
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
                        else
                          savePage(
                                  MyApp.bookManager.getOwnerUsername(),
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
                    ),
                ]),
                SizedBox(width: 16),
                Expanded(
                    child: Column(children: [
                  Expanded(
                    flex: 0,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (MyApp.userManager.getCurrentUsername() !=
                                  MyApp.bookManager.getOwnerUsername() &&
                              !widget.isWatch &&
                              !accepted)
                            BuildButton(
                              name: 'Send Merge request',
                              bgColor: Color.fromRGBO(0, 173, 181, 100),
                              textColor: Colors.black87,
                              width: 150,
                              onTap: () {
                                sendMergeRequest(
                                        MyApp.bookManager.getOwnerUsername(),
                                        MyApp.bookManager.getBookName(),
                                        widget.coWriterName)
                                    .then((value) {
                                  final data = jsonDecode(value);
                                  if (data['success']) {
                                    showAlertDiaglog(context, 'Merge sent!',
                                        'Merge sent successfully', () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) => HomeScreen(
                                                    booksList: MyApp.userManager
                                                        .getUserStoriesList(),
                                                  )));
                                    });
                                  }
                                });
                              },
                            ),
                          SizedBox(width: 16),
                          if (!widget.isCoBook && !widget.isWatch)
                            BuildButton(
                              name: 'Merge Requests',
                              bgColor: Color.fromRGBO(0, 173, 181, 100),
                              textColor: Colors.black87,
                              width: 150,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            MergeRequestScreen()));
                              },
                            ),
                          Spacer(flex: 1),
                          BuildButton(
                            name: 'Back',
                            bgColor: Color.fromRGBO(0, 173, 181, 100),
                            textColor: Colors.black87,
                            width: 150,
                            onTap: () {
                              if (widget.isCoBook && widget.isWatch)
                                Navigator.pop(context);
                              else {
                                MyApp.bookManager.exitBook();
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => HomeScreen(
                                            booksList: MyApp.userManager
                                                .getUserStoriesList())));
                              }
                            },
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
                              int pageNum = int.parse(pageNumber.data);
                              int lastPageNum = int.parse(lastPageNumber.data);
                              if (pageNum == 1) return;
                              if (newPageStateFlag) {
                                newPageStateFlag = false;
                                saveButtonColor =
                                    Color.fromRGBO(0, 173, 181, 100);
                                saveButtonName = 'Save';
                              }
                              String page =
                                  quillController.document.toPlainText();

                              if (!widget.isWatch && !widget.isCoBook) {
                                if (pageNum <= lastPageNum) {
                                  savePage(
                                          MyApp.bookManager.getOwnerUsername(),
                                          MyApp.bookManager.getBookName(),
                                          pageNumber.data,
                                          page)
                                      .then((value) {
                                    pageNum--;
                                    pageNumber = Text(pageNum.toString());
                                    getPage(
                                      MyApp.bookManager.getOwnerUsername(),
                                      MyApp.bookManager.getBookName(),
                                      pageNumber.data,
                                    ).then((value) {
                                      final data = jsonDecode(value);
                                      quillController.clear();
                                      data['content'] = data['content']
                                          .substring(
                                              0, data['content'].length - 1);
                                      quillController.document
                                          .insert(0, data['content']);
                                      setState(() {});
                                    });
                                  });
                                } else {
                                  pageNum--;
                                  pageNumber = Text(pageNum.toString());
                                  getPage(
                                          MyApp.bookManager.getOwnerUsername(),
                                          MyApp.bookManager.getBookName(),
                                          pageNumber.data)
                                      .then((value) {
                                    final data = jsonDecode(value);
                                    quillController.clear();
                                    data['content'] = data['content'].substring(
                                        0, data['content'].length - 1);
                                    quillController.document
                                        .insert(0, data['content']);
                                    setState(() {});
                                  });
                                }
                              } else if (widget.isCoBook && widget.isWatch) {
                                pageNum--;
                                pageNumber = Text(pageNum.toString());
                                getCowriterPage(
                                        MyApp.bookManager.getOwnerUsername(),
                                        MyApp.bookManager.getBookName(),
                                        pageNumber.data,
                                        widget.coWriterName)
                                    .then((value) {
                                  final data = jsonDecode(value);
                                  quillController.clear();
                                  data['content'] = data['content']
                                      .substring(0, data['content'].length - 1);
                                  quillController.document
                                      .insert(0, data['content']);
                                  setState(() {});
                                });
                              } else if (widget.isCoBook && !widget.isWatch) {
                                if (pageNum <= lastPageNum) {
                                  saveCowriterPage(
                                          MyApp.bookManager.getOwnerUsername(),
                                          MyApp.bookManager.getBookName(),
                                          pageNumber.data,
                                          page,
                                          widget.coWriterName)
                                      .then((value) {
                                    pageNum--;
                                    pageNumber = Text(pageNum.toString());
                                    getCowriterPage(
                                            MyApp.bookManager
                                                .getOwnerUsername(),
                                            MyApp.bookManager.getBookName(),
                                            pageNumber.data,
                                            widget.coWriterName)
                                        .then((value) {
                                      final data = jsonDecode(value);
                                      quillController.clear();
                                      data['content'] = data['content']
                                          .substring(
                                              0, data['content'].length - 1);
                                      quillController.document
                                          .insert(0, data['content']);
                                      setState(() {});
                                    });
                                  });
                                } else {
                                  pageNum--;
                                  pageNumber = Text(pageNum.toString());
                                  getCowriterPage(
                                          MyApp.bookManager.getOwnerUsername(),
                                          MyApp.bookManager.getBookName(),
                                          pageNumber.data,
                                          widget.coWriterName)
                                      .then((value) {
                                    final data = jsonDecode(value);
                                    quillController.clear();
                                    data['content'] = data['content'].substring(
                                        0, data['content'].length - 1);
                                    quillController.document
                                        .insert(0, data['content']);
                                    setState(() {});
                                  });
                                }
                              } else {
                                pageNum--;
                                pageNumber = Text(pageNum.toString());
                                getPage(
                                        MyApp.bookManager.getOwnerUsername(),
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
                              }
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
                              if (!widget.isWatch && !widget.isCoBook) {
                                savePage(
                                        MyApp.bookManager.getOwnerUsername(),
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
                                            MyApp.bookManager
                                                .getOwnerUsername(),
                                            MyApp.bookManager.getBookName(),
                                            pageNumber.data)
                                        .then((value) {
                                      final data = jsonDecode(value);
                                      data['content'] = data['content']
                                          .substring(
                                              0, data['content'].length - 1);
                                      quillController.document
                                          .insert(0, data['content']);
                                      setState(() {});
                                    });
                                  }
                                });
                              } else if (widget.isCoBook && !widget.isWatch) {
                                saveCowriterPage(
                                        MyApp.bookManager.getOwnerUsername(),
                                        MyApp.bookManager.getBookName(),
                                        pageNumber.data,
                                        quillController.document.toPlainText(),
                                        widget.coWriterName)
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
                                    getCowriterPage(
                                            MyApp.bookManager
                                                .getOwnerUsername(),
                                            MyApp.bookManager.getBookName(),
                                            pageNumber.data,
                                            widget.coWriterName)
                                        .then((value) {
                                      final data = jsonDecode(value);
                                      data['content'] = data['content']
                                          .substring(
                                              0, data['content'].length - 1);
                                      quillController.document
                                          .insert(0, data['content']);
                                      setState(() {});
                                    });
                                  }
                                });
                              } else if (widget.isWatch && widget.isCoBook) {
                                pageNum++;
                                pageNumber = Text(pageNum.toString());
                                quillController.clear();
                                getCowriterPage(
                                        MyApp.bookManager.getOwnerUsername(),
                                        MyApp.bookManager.getBookName(),
                                        pageNumber.data,
                                        widget.coWriterName)
                                    .then((value) {
                                  final data = jsonDecode(value);
                                  data['content'] = data['content']
                                      .substring(0, data['content'].length - 1);
                                  quillController.document
                                      .insert(0, data['content']);
                                  setState(() {});
                                });
                              } else {
                                pageNum++;
                                pageNumber = Text(pageNum.toString());
                                quillController.clear();
                                getPage(
                                        MyApp.bookManager.getOwnerUsername(),
                                        MyApp.bookManager.getBookName(),
                                        pageNumber.data)
                                    .then((value) {
                                  final data = jsonDecode(value);
                                  data['content'] = data['content']
                                      .substring(0, data['content'].length - 1);
                                  quillController.document
                                      .insert(0, data['content']);
                                  setState(() {});
                                });
                              }
                            },
                            width: 50,
                            height: 50,
                          ),
                        ],
                      ))
                ]))
              ]),
            ),
          ]),
        )));
  }

  void repeatedWordsTracker(bool flag) {
    List<String> words = [];
    words = quillController.document.toPlainText().toLowerCase().split(' ');
    words.sort();
    print(words);
    if (flag) {
      if (words.isNotEmpty)
        for (final word in words) {
          words.remove(word);
          if (words.contains(word)) {
            quillController.document.changes.listen((event) {
              print(event.item1);
              print(event.item2);
              print(event.item3);
            });
          }
        }
    }
  }
}
