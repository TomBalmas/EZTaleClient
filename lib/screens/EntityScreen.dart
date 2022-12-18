import 'dart:convert';

import 'package:flutter/material.dart';

import '../EZNetworking.dart';
import '../main.dart';
import '../widgets/EZBuildButton.dart';
import '../widgets/EZDrawer.dart';
import '../widgets/EZNewEntityTextField.dart';
import 'NewEntityScreen.dart';

class EntityScreen extends StatelessWidget {
  EntityScreen({
    key,
    this.type,
    this.content,
  });
  final String type;
  final List<DataCell> content; // List<DataCell>, content[0] = name cell

  @override
  Widget build(BuildContext context) {
    Text name = content[0].child;
    return buildCharacterScreen(context, type + ': ' + name.data);
    //TODO: create a screen for every entity type
  }

  Widget buildCharacterScreen(BuildContext context, String title) {
    TextEditingController nameController = new TextEditingController();
    TextEditingController sureNameController = new TextEditingController();
    TextEditingController genderController = new TextEditingController();
    TextEditingController traitsController = new TextEditingController();
    TextEditingController appearanceController = new TextEditingController();
    TextEditingController ageController = new TextEditingController();
    Text name = content[0].child;
    getEntity(MyApp.userManager.getCurrentUsername(),
            MyApp.bookManager.getBookName(), name.data)
        .then((value) {
      final data = jsonDecode(value);
      nameController.text = data['name'];
      sureNameController.text = data['surename'];
      if (data['age'] != null) ageController.text = data['age'].toString();
      genderController.text = data['gender'];
      traitsController.text = data['personalityTraits'];
      appearanceController.text = data['appearanceTraits'];
    });
    return Scaffold(
        drawer: EZDrawer(),
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 64, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    flex: 6,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Name:'),
                                    SizedBox(width: 50),
                                    EZEntityTextField(
                                        hintText: 'Name',
                                        readOnly: true,
                                        inputType: TextInputType.name,
                                        controller: nameController),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Surname:'),
                                    SizedBox(width: 33),
                                    EZEntityTextField(
                                        hintText: 'Surename',
                                        inputType: TextInputType.name,
                                        controller: sureNameController),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Age:'),
                                    SizedBox(width: 63),
                                    EZEntityTextField(
                                        hintText: 'age',
                                        inputType: TextInputType.name,
                                        controller: ageController),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Gender:'),
                                    SizedBox(width: 43),
                                    EZEntityTextField(
                                        hintText: 'Gender',
                                        inputType: TextInputType.name,
                                        controller: genderController),
                                  ],
                                ),
                              ]),
                          Column(children: [
                            Row(
                              children: [
                                Text('Traits:'),
                                SizedBox(width: 57),
                                EZEntityTextField(
                                    hintText: 'Personality Traits',
                                    inputType: TextInputType.name,
                                    controller: traitsController,
                                    width: 500),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Appearance:'),
                                SizedBox(width: 16),
                                EZEntityTextField(
                                    hintText: 'Appearance',
                                    inputType: TextInputType.name,
                                    controller: appearanceController,
                                    width: 500),
                              ],
                            ),
                          ])
                        ]),
                  ),
                  Expanded(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BuildButton(
                            name: 'Back',
                            bgColor: Color.fromRGBO(0, 173, 181, 100),
                            textColor: Colors.black87,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            width: 100,
                          ),
                          BuildButton(
                              name: 'Save',
                              bgColor: Color.fromRGBO(0, 173, 181, 100),
                              textColor: Colors.black87,
                              width: 100,
                              onTap: () {})
                        ]),
                  ),
                ]))));
  }
}
