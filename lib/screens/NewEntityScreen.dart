import 'dart:convert';

import 'package:ez_tale/EZNetworking.dart';
import 'package:ez_tale/constants.dart';
import 'package:ez_tale/main.dart';
import 'package:flutter/material.dart';
import '../widgets/EZBuildButton.dart';
import '../widgets/EZNewEntityTextField.dart';
import '../widgets/Widgets.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

final Map<String, String> newMap = {
  "username": MyApp.bookManager.getOwnerUsername(),
  "bookName": MyApp.bookManager.getBookName(),
};

// ignore: must_be_immutable
class NewEntityScreen extends StatefulWidget {
  NewEntityScreen({key, @required this.nameOfEntity});
  final nameOfEntity;

  var firstTimeFlag = true;
  List<Widget> attributeWidgets = [];
  List<TextEditingController> nameControllers = [];
  List<TextEditingController> valueControllers = [];
  TextEditingController attributeTemplateNameController =
      new TextEditingController();
  TextEditingController customNameController = new TextEditingController();
  var attributeCounter = 0;

  @override
  State<NewEntityScreen> createState() => _NewEntityScreen();
}

class _NewEntityScreen extends State<NewEntityScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.nameOfEntity == 'New Character')
      return buildCharacterScreen(context, widget.nameOfEntity);
    if (widget.nameOfEntity == 'New Location')
      return buildLocationScreen(context, widget.nameOfEntity);
    if (widget.nameOfEntity == 'New Custom Entity') return buildCustomScreen();
    if (widget.nameOfEntity == 'New Event')
      return buildEventScreen(context, widget.nameOfEntity);
    if (widget.nameOfEntity == 'New Attribute Template')
      return buildTemplatesScreen();
    return null;
  }

  /*
  Builds the "New Custom Entity" screen
  */
  buildCustomScreen() {
    //TODO: fix save button with Tom
    if (widget.firstTimeFlag) {
      widget.attributeWidgets.add(EZEntityTextField(
        hintText: 'Entity Name',
        inputType: TextInputType.name,
        controller: widget.customNameController,
        width: 200,
      ));
      widget.attributeWidgets.add(SizedBox(width: 800));
      widget.firstTimeFlag = false;
    }
    return Scaffold(
        drawer: EZDrawer(),
        appBar: AppBar(
          title: Text(widget.nameOfEntity),
        ),
        body: Container(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      widget.nameOfEntity,
                      style: TextStyle(fontSize: 64, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  BuildButton(
                      name: 'Apply Attribute Template',
                      bgColor: Color.fromRGBO(0, 173, 181, 100),
                      textColor: Colors.black87,
                      height: 40,
                      width: 250,
                      onTap: () {} //TODO: add functionality
                      ),
                  Expanded(
                    flex: 10,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: widget.attributeWidgets)),
                          Expanded(
                              child: Column(children: [
                            BuildButton(
                              name: 'Add Attribute',
                              bgColor: Color.fromRGBO(0, 173, 181, 100),
                              textColor: Colors.black87,
                              height: 50,
                              onTap: () {
                                setState(() {
                                  widget.attributeWidgets.add(addAttribute());
                                  widget.attributeCounter++;
                                });
                              },
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Total attributes\n' +
                                  widget.attributeCounter.toString(),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            )
                          ]))
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
                              //TODO: ask Tom about this save
                              name: 'Save',
                              bgColor: Color.fromRGBO(0, 173, 181, 100),
                              textColor: Colors.black87,
                              width: 100,
                              onTap: () {
                                bool nameExists = false;
                                getAllTypeEntities(
                                        MyApp.bookManager.getBookName(),
                                        MyApp.bookManager.getOwnerUsername(),
                                        "userDefined")
                                    .then((value) {
                                  final data = jsonDecode(value);
                                  for (final customEntity in data) {
                                    if (customEntity["name"]
                                            .toString()
                                            .toLowerCase() ==
                                        widget.attributeTemplateNameController
                                            .text
                                            .toLowerCase()) {
                                      nameExists = true;
                                      showAlertDiaglog(
                                          context,
                                          "Error",
                                          "Custom Entity " +
                                              widget
                                                  .attributeTemplateNameController
                                                  .text +
                                              " already exists.", () {
                                        Navigator.pop(context, 'OK');
                                      });
                                      break;
                                    }
                                  }
                                  if (nameExists) return;
                                  final Map<String, String> newCustom = newMap;
                                  newCustom["type"] = "userDefined";
                                  newCustom["name"] =
                                      widget.customNameController.text;
                                  final Map<String, String> attributes = {};
                                  for (int i = 0;
                                      i < widget.attributeCounter;
                                      i++) {
                                    attributes[widget.nameControllers[i].text] =
                                        widget.valueControllers[i].text;
                                  }
                                  //TODO: save the attributes

                                  saveEntity(newCustom).then((value) {
                                    final data = jsonDecode(value);
                                    if (data['msg'] == 'Successfully saved') {
                                      showAlertDiaglog(
                                          context,
                                          "Save Successeful",
                                          "Custom Entity " +
                                              widget
                                                  .attributeTemplateNameController
                                                  .text +
                                              " has been saved.",
                                          () => {
                                                Navigator.pop(context, 'OK'),
                                                Navigator.pop(context)
                                              });
                                    } else if (widget
                                        .customNameController.text.isEmpty) {
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

/*
Adds a new attribute line (name + value + delete button)
*/
  Widget addAttribute() {
    TextEditingController nameController = new TextEditingController();
    TextEditingController valueController = new TextEditingController();
    widget.nameControllers.add(nameController);
    widget.valueControllers.add(valueController);
    Widget r = Row();
    r = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        EZEntityTextField(
          hintText: 'Attribute Name',
          inputType: TextInputType.name,
          controller: nameController,
          width: 200,
        ),
        SizedBox(width: 16),
        EZEntityTextField(
          hintText: 'Value',
          inputType: TextInputType.name,
          controller: valueController,
          width: 500,
        ),
        SizedBox(width: 16),
        BuildButton(
          name: 'X',
          bgColor: Color.fromRGBO(0, 173, 181, 100),
          textColor: Colors.black87,
          height: 50,
          width: 50,
          onTap: () {
            setState(() {
              widget.attributeWidgets.remove(r);
              widget.attributeCounter--;
            });
          },
        ),
        SizedBox(width: 16),
      ],
    );
    return r;
  }

/*
Builds the "New Attribute Template" screen
*/
  buildTemplatesScreen() {
    if (widget.firstTimeFlag) {
      widget.attributeWidgets.add(EZEntityTextField(
        hintText: 'Template Name',
        inputType: TextInputType.name,
        controller: widget.attributeTemplateNameController,
        width: 200,
      ));
      widget.attributeWidgets.add(SizedBox(width: 800));
      widget.firstTimeFlag = false;
    }
    return Scaffold(
        drawer: EZDrawer(),
        appBar: AppBar(
          title: Text(widget.nameOfEntity),
        ),
        body: Container(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      widget.nameOfEntity,
                      style: TextStyle(fontSize: 64, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: widget.attributeWidgets)),
                          Expanded(
                              child: Column(
                            children: [
                              BuildButton(
                                name: 'Add Attribute',
                                bgColor: Color.fromRGBO(0, 173, 181, 100),
                                textColor: Colors.black87,
                                height: 50,
                                onTap: () {
                                  setState(() {
                                    widget.attributeWidgets.add(addAttribute());
                                    widget.attributeCounter++;
                                  });
                                },
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Total attributes\n' +
                                    widget.attributeCounter.toString(),
                                style:
                                    TextStyle(fontSize: 20, color: Colors.grey),
                              )
                            ],
                          ))
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
                                        MyApp.bookManager.getOwnerUsername(),
                                        "attributeTemplate")
                                    .then((value) {
                                  final data = jsonDecode(value);
                                  for (final template in data) {
                                    if (template["name"]
                                            .toString()
                                            .toLowerCase() ==
                                        widget.attributeTemplateNameController
                                            .text
                                            .toLowerCase()) {
                                      nameExists = true;
                                      showAlertDiaglog(
                                          context,
                                          "Error",
                                          "Template " +
                                              widget
                                                  .attributeTemplateNameController
                                                  .text +
                                              " already exists.", () {
                                        Navigator.pop(context, 'OK');
                                      });
                                      break;
                                    }
                                  }
                                  if (nameExists) return;
                                  final Map<String, String> newTemplate =
                                      newMap;
                                  newTemplate["type"] = "attributeTemplate";
                                  newTemplate["name"] = widget
                                      .attributeTemplateNameController.text;
                                  final Map<String, String> attributes = {};
                                  for (int i = 0;
                                      i < widget.attributeCounter;
                                      i++) {
                                    attributes[widget.nameControllers[i].text] =
                                        widget.valueControllers[i].text;
                                  }
                                  //TODO: save the attributes
                                  saveEntity(newTemplate).then((value) {
                                    final data = jsonDecode(value);
                                    if (data['msg'] == 'Successfully saved') {
                                      showAlertDiaglog(
                                          context,
                                          "Save Successeful",
                                          "Attribute template " +
                                              widget
                                                  .attributeTemplateNameController
                                                  .text +
                                              " has been saved.",
                                          () => {
                                                Navigator.pop(context, 'OK'),
                                                Navigator.pop(context)
                                              });
                                    } else if (widget
                                        .attributeTemplateNameController
                                        .text
                                        .isEmpty) {
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

/*
Builds the "New Event" screen
*/
Widget buildEventScreen(BuildContext context, String title) {
  quill.QuillController quillController = quill.QuillController.basic();
  TextEditingController nameController = new TextEditingController();
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
                                hintText: 'Event Name',
                                inputType: TextInputType.name,
                                controller: nameController,
                              ),
                              Text(
                                'Description:',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.grey),
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
                              bool nameExists = false;
                              getAllTypeEntities(
                                      MyApp.bookManager.getBookName(),
                                      MyApp.bookManager.getOwnerUsername(),
                                      "storyEvent")
                                  .then((value) {
                                final data = jsonDecode(value);
                                for (final event in data) {
                                  if (event["name"].toString().toLowerCase() ==
                                      nameController.text.toLowerCase()) {
                                    nameExists = true;
                                    showAlertDiaglog(
                                        context,
                                        "Error",
                                        "Event " +
                                            nameController.text +
                                            " already exists.", () {
                                      Navigator.pop(context, 'OK');
                                    });
                                    break;
                                  }
                                }
                                if (nameExists) return;
                                final Map<String, String> newEvent = newMap;
                                newEvent["type"] = "storyEvent";
                                newEvent["name"] = nameController.text;
                                newEvent["desc"] =
                                    quillController.document.toPlainText();
                                saveEntity(newEvent).then((value) {
                                  final data = jsonDecode(value);
                                  if (data['msg'] == 'Successfully saved') {
                                    showAlertDiaglog(
                                        context,
                                        "Save Successeful",
                                        "Event " +
                                            nameController.text +
                                            " has been saved.",
                                        () => {
                                              Navigator.pop(context, 'OK'),
                                              Navigator.pop(context)
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

/*
Builds the "New Location" screen
*/
Widget buildLocationScreen(BuildContext context, String title) {
  quill.QuillController quillController = quill.QuillController.basic();
  TextEditingController nameController = new TextEditingController();
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
                                hintText: 'Location Name',
                                inputType: TextInputType.name,
                                controller: nameController,
                              ),
                              Text(
                                'Description:',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.grey),
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
                              bool nameExists = false;
                              getAllTypeEntities(
                                      MyApp.bookManager.getBookName(),
                                      MyApp.bookManager.getOwnerUsername(),
                                      "location")
                                  .then((value) {
                                final data = jsonDecode(value);
                                for (final location in data) {
                                  if (location["name"]
                                          .toString()
                                          .toLowerCase() ==
                                      nameController.text.toLowerCase()) {
                                    nameExists = true;
                                    showAlertDiaglog(
                                        context,
                                        "Error",
                                        "Location " +
                                            nameController.text +
                                            " already exists.", () {
                                      Navigator.pop(context, 'OK');
                                    });
                                    break;
                                  }
                                }
                                if (nameExists) return;
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
                                        "Save Successeful",
                                        "Location " +
                                            nameController.text +
                                            " has been saved.",
                                        () => {
                                              Navigator.pop(context, 'OK'),
                                              Navigator.pop(context)
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

/*
Builds the "New Character" screen
*/
Widget buildCharacterScreen(BuildContext context, String title) {
  TextEditingController nameController = new TextEditingController();
  TextEditingController sureNameController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController traitsController = new TextEditingController();
  TextEditingController appearanceController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
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
                                controller: nameController,
                              ),
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
                                      MyApp.bookManager.getOwnerUsername(),
                                      "character")
                                  .then((value) {
                                final data = jsonDecode(value);
                                for (final character in data) {
                                  if (character["name"]
                                          .toString()
                                          .toLowerCase() ==
                                      nameController.text.toLowerCase()) {
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
