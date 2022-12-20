import 'package:flutter/material.dart';
import 'package:ez_tale/widgets/Widgets.dart';
import '../constants.dart';

// ignore: must_be_immutable
class CowritersScreen extends StatelessWidget {
  TextEditingController emailController = new TextEditingController();
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
                            onTap: () {},
                            bgColor: bgColor,
                            textColor: Colors.white),
                        SizedBox(width: 16),
                        EZTextField(
                            hintText: 'email',
                            inputType: TextInputType.emailAddress,
                            controller: emailController),
                      ]),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            SizedBox(width: 50),
                            EZComboBox(['kaki', 'pipi']),
                            SizedBox(width: 400),
                            BuildTable(
                                nameOfTable: 'Co-writers',
                                tableContent: [
                                  {'task': 'bla', 'deadline': '5/5/23'},
                                  {'task': 'morty', 'deadline': '10/10/10'}
                                ]),
                          ],
                        )),
                  ]),
                ))));
  }
}
