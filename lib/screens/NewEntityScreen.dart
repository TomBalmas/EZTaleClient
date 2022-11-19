import 'package:ez_tale/widgets/EZTableBuilder.dart';
import 'package:flutter/material.dart';
import '../widgets/EZBuildButton.dart';
import '../widgets/EZNewEntityTextField.dart';
import '../widgets/Widgets.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

// ignore: must_be_immutable
class NewEntityScreen extends StatefulWidget {

  NewEntityScreen({
    key,
    @required this.nameOfEntity,
  });
  final nameOfEntity;
  var firstTimeFlag = true;
  List<Widget> attributeWidgets = [];

  @override
  State<NewEntityScreen> createState() => _NewEntityScreen();
}

class _NewEntityScreen extends State<NewEntityScreen> {

  
  @override
  Widget build(BuildContext context) {
    if(widget.nameOfEntity == 'New Character')
      return buildCharacterScreen(context, widget.nameOfEntity);
    if(widget.nameOfEntity == 'New Location')
      return buildLocationScreen(context, widget.nameOfEntity);
    if(widget.nameOfEntity == 'New Conversation')
      return buildConversationScreen(context, widget.nameOfEntity);
    if(widget.nameOfEntity == 'New Custom Entity')
      return buildCustomScreen();
    if(widget.nameOfEntity == 'New Event')
      return buildEventScreen(context,widget.nameOfEntity);
    if(widget.nameOfEntity == 'New Attribute Template')
      return buildTemplatesScreen();
    return null;
  }
  
  /*
  Builds the "Custom Entity" screen
  */
  buildCustomScreen() {
  TextEditingController nameController = new TextEditingController();
  if(widget.firstTimeFlag){
    widget.attributeWidgets.add(
      EZEntityTextField(
        hintText: 'Entity Name',
        inputType: TextInputType.name,
        controller: nameController,
        width: 200,
      )
    );
    widget.attributeWidgets.add(
      SizedBox(width: 750)
    );
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
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      widget.nameOfEntity,
                      style: TextStyle(
                        fontSize: 64,
                        color: Colors.grey
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  BuildButton(
                    name: 'Apply Attribute Template',
                    bgColor: Color.fromRGBO(0, 173, 181, 100),
                    textColor: Colors.black87,
                    height: 40,
                    width: 250,
                    onTap: (){}
                  ),
                  Expanded(
                    flex: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.attributeWidgets
                        ),
                        Column(
                          children: [
                            BuildButton(
                              name: 'Add Attribute',
                              bgColor: Color.fromRGBO(0, 173, 181, 100),
                              textColor: Colors.black87,
                              height: 50,
                              onTap: (){
                                setState(() {
                                  if(widget.attributeWidgets.length < 7)
                                    widget.attributeWidgets.add(addAttribute());
                                  else
                                    showAlertDiaglog(
                                      context,
                                      "Error",
                                      "Max 5 attributes per custom entity.",
                                      () => Navigator.pop(context, 'OK')
                                    );
                                });
                              },
                            )
                          ],
                        )
                      ]
                    ),
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
                          onTap: (){
                            Navigator.pop(context);
                          },
                          width: 100,
                        ),
                        BuildButton(
                          name: 'Save',
                          bgColor: Color.fromRGBO(0, 173, 181, 100),
                          textColor: Colors.black87,
                          width: 100,
                          onTap: (){}
                        )
                      ]
                    ),
                  ),
              ])
          )
        )
      );
  }

/*
Builds the "Templates" screen
*/
buildTemplatesScreen() {
  TextEditingController nameController = new TextEditingController();
  if(widget.firstTimeFlag){
    widget.attributeWidgets.add(
      EZEntityTextField(
        hintText: 'Template Name',
        inputType: TextInputType.name,
        controller: nameController,
        width: 200,
      )
    );
    widget.attributeWidgets.add(
      SizedBox(width: 750)
    );
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
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      widget.nameOfEntity,
                      style: TextStyle(
                        fontSize: 64,
                        color: Colors.grey
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.attributeWidgets
                        ),
                        Column(
                          children: [
                            BuildButton(
                              name: 'Add Attribute',
                              bgColor: Color.fromRGBO(0, 173, 181, 100),
                              textColor: Colors.black87,
                              height: 50,
                              onTap: (){
                                setState(() {
                                  if(widget.attributeWidgets.length < 7)
                                    widget.attributeWidgets.add(addAttribute());
                                  else
                                    showAlertDiaglog(
                                      context,
                                      "Error",
                                      "Max 5 attributes per template.",
                                      () => Navigator.pop(context, 'OK')
                                    );
                                });
                              },
                            )
                          ],
                        )
                      ]
                    ),
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
                          onTap: (){
                            Navigator.pop(context);
                          },
                          width: 100,
                        ),
                        BuildButton(
                          name: 'Save',
                          bgColor: Color.fromRGBO(0, 173, 181, 100),
                          textColor: Colors.black87,
                          width: 100,
                          onTap: (){}
                        )
                      ]
                    ),
                  ),
              ])
          )
        )
      );
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
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 64,
                        color: Colors.grey
                      ),
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
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(width: 3, color: Colors.blue),
                              ),
                              child: SizedBox(
                                width: 700,
                                height: 300,
                                child: quill.QuillEditor.basic(
                                  controller: quillController,
                                  readOnly: false, // true for view only mode
                                ),
                              )
                            )
                          ]
                        ),
                      ]
                    ),
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
                          onTap: (){
                            Navigator.pop(context);
                          },
                          width: 100,
                        ),
                        BuildButton(
                          name: 'Save',
                          bgColor: Color.fromRGBO(0, 173, 181, 100),
                          textColor: Colors.black87,
                          width: 100,
                          onTap: (){}
                        )
                      ]
                    ),
                  ),
              ])
          )
        )
      );
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


Widget addAttribute() {
  TextEditingController nameController = new TextEditingController();
  TextEditingController valueController = new TextEditingController();
  return Row(
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
    ],
  );
}


/*
Builds the "New Conversation" screen
*/
Widget buildConversationScreen(BuildContext context, String title) {
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
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 64,
                        color: Colors.grey
                      ),
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
                              hintText: 'Name of conversation',
                              inputType: TextInputType.name,
                              controller: nameController,
                            ),
                            Text(
                              'Description:',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(width: 3, color: Colors.blue),
                              ),
                              child: SizedBox(
                                width: 500,
                                height: 300,
                                child: quill.QuillEditor.basic(
                                  controller: quillController,
                                  readOnly: false, // true for view only mode
                                ),
                              )
                            )
                          ]
                        ),
                        Column(
                          children: [
                            Text(
                              'Choose participants:',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey
                              ),
                            ),
                            BuildTable()
                          ],
                        )
                      ]
                    ),
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
                          onTap: (){
                            Navigator.pop(context);
                          },
                          width: 100,
                        ),
                        BuildButton(
                          name: 'Save',
                          bgColor: Color.fromRGBO(0, 173, 181, 100),
                          textColor: Colors.black87,
                          width: 100,
                          onTap: (){}
                        )
                      ]
                    ),
                  ),
              ])
          )
        )
      );
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
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 64,
                        color: Colors.grey
                      ),
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
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(width: 3, color: Colors.blue),
                              ),
                              child: SizedBox(
                                width: 700,
                                height: 300,
                                child: quill.QuillEditor.basic(
                                  controller: quillController,
                                  readOnly: false, // true for view only mode
                                ),
                              )
                            )
                          ]
                        ),
                      ]
                    ),
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
                          onTap: (){
                            Navigator.pop(context);
                          },
                          width: 100,
                        ),
                        BuildButton(
                          name: 'Save',
                          bgColor: Color.fromRGBO(0, 173, 181, 100),
                          textColor: Colors.black87,
                          width: 100,
                          onTap: (){}
                        )
                      ]
                    ),
                  ),
              ])
          )
        )
      );
}

/*
Builds the "New Character" screen
*/
Widget buildCharacterScreen(BuildContext context, String title){
  quill.QuillController quillController = quill.QuillController.basic();
  TextEditingController nameController = new TextEditingController();
  TextEditingController sureNameController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController traitsController = new TextEditingController();
  TextEditingController appearanceController = new TextEditingController();
  return Scaffold(
          drawer: EZDrawer(),
          appBar: AppBar(
            title: Text(title),
          ),
          body: Container(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 64,
                        color: Colors.grey
                      ),
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
                              controller: sureNameController
                            ),
                            EZEntityTextField(
                              hintText: 'Gender',
                              inputType: TextInputType.name,
                              controller: genderController
                            ),
                            Text(
                              'Description:',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(width: 3, color: Colors.blue),
                              ),
                              child: SizedBox(
                                width: 500,
                                height: 170,
                                child: quill.QuillEditor.basic(
                                  controller: quillController,
                                  readOnly: false, // true for view only mode
                                ),
                              )
                            ),
                          ]
                        ),
                        Column(
                          children: [
                            EZEntityTextField(
                              hintText: 'Personality Traits',
                              inputType: TextInputType.name,
                              controller: traitsController,
                              width: 500
                            ),
                            EZEntityTextField(
                              hintText: 'Appearance',
                              inputType: TextInputType.name,
                              controller: appearanceController,
                              width: 500
                            ),
                          ]
                        )
                      ]
                    ),
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
                          onTap: (){
                            Navigator.pop(context);
                          },
                          width: 100,
                        ),
                        BuildButton(
                          name: 'Save',
                          bgColor: Color.fromRGBO(0, 173, 181, 100),
                          textColor: Colors.black87,
                          width: 100,
                          onTap: (){}
                        )
                      ]
                    ),
                  ),
              ])
          )
        )
      );
}