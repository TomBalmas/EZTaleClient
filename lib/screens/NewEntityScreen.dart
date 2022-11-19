import 'package:flutter/material.dart';
import '../widgets/EZBuildButton.dart';
import '../widgets/EZNewEntityTextField.dart';
import '../widgets/Widgets.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class NewEntityScreen extends StatefulWidget {

  NewEntityScreen({
    key,
    @required this.nameOfEntity,
  });
  final nameOfEntity;

  @override
  State<NewEntityScreen> createState() => _NewEntityScreen();
}

class _NewEntityScreen extends State<NewEntityScreen> {
  quill.QuillController quillController = quill.QuillController.basic();
  TextEditingController nameController = new TextEditingController();
  TextEditingController sureNameController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController traitsController = new TextEditingController();
  TextEditingController appearanceController = new TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    if(widget.nameOfEntity == 'New Character')
      return buildCharacters(context, widget.nameOfEntity);
    if(widget.nameOfEntity == 'New Location')
      return buildLocations(context, widget.nameOfEntity);
  }
}

/*
Builds the "New Location" screen
*/
Widget buildLocations(BuildContext context, String title) {
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
                              hintText: 'Name',
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
Widget buildCharacters(BuildContext context, String title){
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