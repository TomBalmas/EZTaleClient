import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import '../EZNetworking.dart';
import '../constants.dart';
import '../main.dart';
import '../widgets/EZBuildButton.dart';
import '../widgets/EZDrawer.dart';
import '../widgets/EZNewEntityTextField.dart';
import 'NewEntityScreen.dart';

Map<String, String> newEditMap = {
  "username": MyApp.userManager.getCurrentUsername(),
  "bookName": MyApp.bookManager.getBookName(),
};

class EntityScreen extends StatefulWidget {
  EntityScreen({
    key,
    this.type,
    this.content,
  });
  final String type;
  final List<DataCell> content; // List<DataCell>, content[0] = name cell
  @override
  State<EntityScreen> createState() => _EntityScreenState();
}

class _EntityScreenState extends State<EntityScreen> {
  quill.QuillController quillController = quill.QuillController.basic();
  bool firstTimeFlag = true;
  @override
  Widget build(BuildContext context) {
    Text name = widget.content[0].child;
    if (widget.type == 'Character')
      return buildCharacterScreen(context, widget.type + ': ' + name.data);
    if (widget.type == 'Location')
      return buildLocationScreen(context, widget.type + ': ' + name.data);
    //TODO: create a screen for every entity type
  }

/*
  Builds the "Character" screen
*/

  Widget buildCharacterScreen(BuildContext context, String title) {
    TextEditingController nameController = new TextEditingController();
    TextEditingController sureNameController = new TextEditingController();
    TextEditingController genderController = new TextEditingController();
    TextEditingController traitsController = new TextEditingController();
    TextEditingController appearanceController = new TextEditingController();
    TextEditingController ageController = new TextEditingController();
    Text name = widget.content[0].child;
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
                              onTap: () {
                                final Map<String, String> editMap = newEditMap;
                                editMap["type"] = "character";
                                editMap["name"] = nameController.text;
                                editMap["surename"] = sureNameController.text;
                                editMap["personalityTraits"] =
                                    traitsController.text;
                                editMap["appearanceTraits"] =
                                    appearanceController.text;
                                editMap["age"] = ageController.text;
                                editMap["gender"] = genderController.text;
                                deleteEntity(
                                    MyApp.userManager.getCurrentUsername(),
                                    MyApp.bookManager.getBookName(),
                                    editMap['name']);
                                saveEntity(editMap).then((value) {
                                  showAlertDiaglog(
                                      context,
                                      "Edit",
                                      "Character " +
                                          nameController.text +
                                          " has been edited.",
                                      () => {
                                            Navigator.pop(context, 'OK'),
                                            Navigator.pop(context),
                                          });
                                });
                              })
                        ]),
                  ),
                ]))));
  }

/*
  Builds the "Location" screen
*/

  Widget buildLocationScreen(BuildContext context, String title) {
    TextEditingController nameController = new TextEditingController();
    Text name = widget.content[0].child;
    getEntity(MyApp.userManager.getCurrentUsername(),
            MyApp.bookManager.getBookName(), name.data)
        .then((value) {
      final data = jsonDecode(value);
      nameController.text = data['name'];
      if (firstTimeFlag) {
        quillController.document.insert(0, data['vista']);
        setState(() {});
        firstTimeFlag = false;
      }
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
                                Text(
                                  'Description:',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      color: kBackgroundColor,
                                      border: Border.all(
                                          width: 3, color: Colors.black87),
                                    ),
                                    child: SizedBox(
                                      width: 700,
                                      height: 300,
                                      child: quill.QuillEditor.basic(
                                        controller: quillController,
                                        readOnly:
                                            false, // true for view only mode
                                      ),
                                    ))
                              ]),
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
                              onTap: () {
                                deleteEntity(
                                    MyApp.userManager.getCurrentUsername(),
                                    MyApp.bookManager.getBookName(),
                                    nameController.text);
                                final Map<String, String> newLocation = newMap;
                                newLocation["type"] = "location";
                                newLocation["name"] = nameController.text;
                                newLocation["vista"] =
                                    quillController.document.toPlainText();
                                saveEntity(newLocation).then((value) {
                                  final data = jsonDecode(value);
                                  if (data['msg'] == 'Successfully saved') {
                                    showAlertDiaglog(
                                        context,
                                        "Edit",
                                        "Location " +
                                            nameController.text +
                                            " has been edited.",
                                        () => {
                                              Navigator.pop(context, 'OK'),
                                              Navigator.pop(context)
                                            });
                                  }
                                });
                              })
                        ]),
                  ),
                ]))));
  }
}
