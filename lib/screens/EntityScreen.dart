import 'dart:convert';
import 'dart:io';

import 'package:ez_tale/widgets/EZTableBuilder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import '../EZNetworking.dart';
import '../constants.dart';
import '../main.dart';
import '../widgets/EZBuildButton.dart';
import '../widgets/EZDrawer.dart';
import '../widgets/EZNewEntityTextField.dart';
import 'NewEntityScreen.dart';
import 'ChooseRelationScreen.dart';

Map<String, String> newEditMap = {
  "username": MyApp.bookManager.getOwnerUsername(),
  "bookName": MyApp.bookManager.getBookName(),
};
var relations = [];

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
  TextEditingController nameController = new TextEditingController();
  TextEditingController sureNameController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController traitsController = new TextEditingController();
  TextEditingController appearanceController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Text name = widget.content[0].child;
    if (widget.type == 'Character')
      return buildCharacterScreen(context, widget.type + ': ' + name.data);
    if (widget.type == 'Location')
      return buildLocationScreen(context, widget.type + ': ' + name.data);
    if (widget.type == 'Event')
      return buildEventScreen(context, widget.type + ': ' + name.data);
    //TODO: create a screen for every entity type
    return null;
  }

/*
  Builds the "Character" screen
*/

  Widget buildCharacterScreen(BuildContext context, String title) {
    if (firstTimeFlag) {
      Text name = widget.content[0].child;
      relations = [];
      getEntity(MyApp.bookManager.getOwnerUsername(),
              MyApp.bookManager.getBookName(), name.data)
          .then((value) {
        final data = jsonDecode(value);
        nameController.text = data['name'];
        sureNameController.text = data['surename'];
        if (data['age'] != null) ageController.text = data['age'].toString();
        genderController.text = data['gender'];
        traitsController.text = data['personalityTraits'];
        appearanceController.text = data['appearanceTraits'];
        setState(() {});
        firstTimeFlag = false;
      });
    }
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
                          Expanded(
                            child: Column(
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
                          ),
                          Expanded(
                              child: Column(children: [
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
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BuildButton(
                                      name: 'Add a relation',
                                      bgColor: Color.fromRGBO(0, 173, 181, 100),
                                      textColor: Colors.black87,
                                      width: 150,
                                      height: 35,
                                      onTap: () {
                                        addRelationButton();
                                      })
                                ]),
                            SizedBox(height: 16),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Relations:'),
                                Expanded(
                                    child: ListView(children: [
                                  BuildTable(
                                      nameOfTable: 'Relations',
                                      tableContent: relations)
                                ]))
                              ],
                            ))
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
                                editMap["relations"] = relations.toString();
                                deleteEntity(
                                    MyApp.bookManager.getOwnerUsername(),
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
    getEntity(MyApp.bookManager.getOwnerUsername(),
            MyApp.bookManager.getBookName(), name.data)
        .then((value) {
      final data = jsonDecode(value);
      nameController.text = data['name'];
      if (firstTimeFlag) {
        data['vista'] = data['vista'].substring(0, data['vista'].length - 1);
        quillController.document.insert(0, data['vista']);
        relations = data['relations'];
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
                    child: Row(children: [
                  Expanded(
                      child: Column(children: [
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
                                        width: 600,
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
                  ])),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BuildButton(
                                name: 'Add a relation',
                                bgColor: Color.fromRGBO(0, 173, 181, 100),
                                textColor: Colors.black87,
                                width: 150,
                                height: 35,
                                onTap: () {
                                  addRelationButton();
                                }),
                          ]),
                      SizedBox(height: 16),
                      Text('Relations:'),
                      Expanded(
                          child: ListView(children: [
                        BuildTable(
                            nameOfTable: 'Relations', tableContent: relations)
                      ]))
                    ],
                  ))
                ])),
                Expanded(
                  flex: 0,
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
                                  MyApp.bookManager.getOwnerUsername(),
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
              ])),
        ));
  }

  /*
  Builds the "Event" screen
*/
  Widget buildEventScreen(BuildContext context, String title) {
    TextEditingController nameController = new TextEditingController();
    Text name = widget.content[0].child;
    getEntity(MyApp.bookManager.getOwnerUsername(),
            MyApp.bookManager.getBookName(), name.data)
        .then((value) {
      final data = jsonDecode(value);
      nameController.text = data['name'];
      if (firstTimeFlag) {
        data['desc'] = data['desc'].substring(0, data['desc'].length - 1);
        quillController.document.insert(0, data['desc']);
        relations = data['relations'];
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
                      child: Row(children: [
                    Expanded(
                        child: Column(children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                          width: 600,
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
                    ])),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BuildButton(
                                  name: 'Add a relation',
                                  bgColor: Color.fromRGBO(0, 173, 181, 100),
                                  textColor: Colors.black87,
                                  width: 150,
                                  height: 35,
                                  onTap: () {
                                    addRelationButton();
                                  }),
                            ]),
                        SizedBox(height: 16),
                        Text('Relations:'),
                        Expanded(
                            child: ListView(children: [
                          BuildTable(
                              nameOfTable: 'Relations', tableContent: relations)
                        ]))
                      ],
                    ))
                  ])),
                  Expanded(
                    flex: 0,
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
                                    MyApp.bookManager.getOwnerUsername(),
                                    MyApp.bookManager.getBookName(),
                                    nameController.text);
                                final Map<String, String> newLocation = newMap;
                                newLocation["type"] = "storyEvent";
                                newLocation["name"] = nameController.text;
                                newLocation["desc"] =
                                    quillController.document.toPlainText();
                                saveEntity(newLocation).then((value) {
                                  final data = jsonDecode(value);
                                  if (data['msg'] == 'Successfully saved') {
                                    showAlertDiaglog(
                                        context,
                                        "Edit",
                                        "Event " +
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

/*
Removes the current entity from the possible relations list,
and the entities that are in the relations list already,
and the attribute templates.
 */
  List<dynamic> checkInstance(dynamic data) {
    List<dynamic> entities = data;
    List<dynamic> toRemove = [];
    Text name = widget.content[0].child;
    String type = widget.type.toLowerCase();
    bool foundSelfFlag = false;
    for (final entity in data) {
      if (entity['type'] == 'attributeTemplate') {
        toRemove.add(entity);
        continue;
      }
      if (entity['name'] == name.data &&
          entity['type'] == type &&
          !foundSelfFlag) {
        toRemove.add(entity);
        foundSelfFlag = true;
      }
      for (final relation in relations) {
        if (relation['name'] == entity['name'] &&
            relation['type'] == entity['type']) toRemove.add(entity);
      }
    }
    for (final entity in toRemove) {
      entities.remove(entity);
    }
    return entities;
  }

  void addRelationButton() {
    List<dynamic> entities = [];
    Text entityName = widget.content[0].child;
    getAllEntities(MyApp.bookManager.getBookName(),
            MyApp.bookManager.getOwnerUsername())
        .then((value) async {
      final data = jsonDecode(value);
      entities = checkInstance(data);
      await Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => ChooseRelation(
                    tableContent: entities,
                    nameOfTable: 'Choose Relations',
                    entityName: entityName.data,
                    entityType: widget.type,
                  )));
      // TODO: Add the relation selected to the "relations"
      setState(() {});
    });
  }
}
