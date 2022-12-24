import 'dart:convert';

import 'package:ez_tale/EZNetworking.dart';
import 'package:ez_tale/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez_tale/widgets/Widgets.dart';
import '../constants.dart';

// ignore: must_be_immutable
class CowritersScreen extends StatelessWidget {
  TextEditingController emailController = new TextEditingController();
  TextEditingController codeController = new TextEditingController();
  var coWriters;
  CowritersScreen() {
    coWriters = MyApp.bookManager.getCoWriters();
  }

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
    return Scaffold(
        drawer: EZDrawer(),
        appBar: AppBar(
          title: const Text('Co-Writers'),
          foregroundColor: Colors.grey,
          backgroundColor: kBackgroundColor,
        ),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 2500),
                child: Container(
                  child: Column(children: [
                    Center(
                      child: Row(children: [
                        EZTextButton(
                            buttonName: 'Invite co-writer via email',
                            onTap: () {
                              getUserByEmail(emailController.text)
                                  .then((value) {
                                var userToAdd;
                                final data = jsonDecode(value);

                                userToAdd = data['username'];
                                if (data['success'] && userToAdd != null)
                                  addCoWriter(
                                          emailController.text,
                                          MyApp.bookManager.getBookName(),
                                          MyApp.userManager
                                              .getCurrentUsername(),
                                          userToAdd)
                                      .then(
                                    (val) {
                                      final secondData = jsonDecode(val);
                                      showAlertDiaglog(context, 'Add Co-Writer',
                                          secondData['msg'], () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  CowritersScreen()),
                                        );
                                      });
                                    },
                                  );
                                else {
                                  showAlertDiaglog(context, 'Email not found!',
                                      'Email not found!', () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              CowritersScreen()),
                                    );
                                  });
                                }
                              });
                            },
                            bgColor: bgColor,
                            textColor: Colors.white),
                        SizedBox(width: 16),
                        EZTextField(
                            hintText: 'Email',
                            inputType: TextInputType.emailAddress,
                            controller: emailController),
                      ]),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            SizedBox(width: 50),
                            EZComboBox(['rick', 'morty']),
                            SizedBox(width: 400),
                            BuildTable(
                                nameOfTable: 'Co-writers',
                                tableContent: [
                                  {'task': 'rick', 'deadline': '5/5/23'},
                                  {'task': 'morty', 'deadline': '10/10/10'}
                                ]),
                          ],
                        )),
                  ]),
                ))));
  }
}
