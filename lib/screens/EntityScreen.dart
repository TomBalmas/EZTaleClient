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
    //TODO: ask tom to create "get entity function"
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
      print(data);
      Text surename = content[1].child;
      Text age = content[2].child;
      Text gender = content[3].child;
      nameController.text = name.data;
      sureNameController.text = surename.data;
      ageController.text = age.data;
      genderController.text = gender.data;
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
                                EZEntityTextField(
                                    hintText: 'Name',
                                    inputType: TextInputType.name,
                                    controller: nameController),
                                EZEntityTextField(
                                    hintText: 'Surename',
                                    inputType: TextInputType.name,
                                    controller: sureNameController),
                                EZEntityTextField(
                                    hintText: 'age',
                                    inputType: TextInputType.name,
                                    controller: ageController),
                                EZEntityTextField(
                                    hintText: 'Gender',
                                    inputType: TextInputType.name,
                                    controller: genderController),
                              ]),
                          Column(children: [
                            EZEntityTextField(
                                hintText: 'Personality Traits',
                                inputType: TextInputType.name,
                                controller: traitsController,
                                width: 500),
                            EZEntityTextField(
                                hintText: 'Appearance',
                                inputType: TextInputType.name,
                                controller: appearanceController,
                                width: 500),
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
                                bool nameExists = false;
                                getAllTypeEntities(
                                        MyApp.bookManager.getBookName(),
                                        MyApp.userManager.getCurrentUsername(),
                                        "character")
                                    .then((value) {
                                  final data = jsonDecode(value);
                                  for (final character in data) {
                                    if (character["name"] ==
                                        nameController.text) {
                                      nameExists = true;
                                      showAlertDiaglog(
                                          context,
                                          "Error",
                                          "Character " +
                                              nameController.text +
                                              " already exists.", () {
                                        Navigator.pop(context, 'OK');
                                      });
                                      break;
                                    }
                                  }
                                  if (nameExists) return;
                                  final Map<String, String> newChar = newMap;
                                  newChar["type"] = "character";
                                  newChar["name"] = nameController.text;
                                  newChar["surename"] = sureNameController.text;
                                  newChar["personalityTraits"] =
                                      traitsController.text;
                                  newChar["appearanceTraits"] =
                                      appearanceController.text;
                                  newChar["age"] = ageController.text;
                                  newChar["gender"] = genderController.text;
                                  saveEntity(newChar).then((value) {
                                    final data = jsonDecode(value);
                                    if (data['msg'] == 'Successfully saved') {
                                      showAlertDiaglog(
                                          context,
                                          "Save Successeful",
                                          "Character " +
                                              nameController.text +
                                              " has been saved.",
                                          () => {
                                                Navigator.pop(context, 'OK'),
                                                Navigator.pop(context),
                                              });
                                    } else if (nameController.text.isEmpty) {
                                      showAlertDiaglog(
                                          context,
                                          "Error",
                                          "Name must be filled.",
                                          () => Navigator.pop(context, 'OK'));
                                    }
                                  });
                                });
                              })
                        ]),
                  ),
                ]))));
  }
}
