import 'package:ez_tale/EZNetworking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import '../constants.dart';
import '../widgets/Widgets.dart';

class EditorScreen extends StatelessWidget {
  quill.QuillController _controller = quill.QuillController.basic();

  @override
  Widget build(BuildContext context) {
    double buttonWidth = 300, buttonHeight = 60;
    return Scaffold(
      drawer: EZDrawer(),
      appBar: AppBar(title: Text('book1')), //TODO correct the name
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child:Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BuildButton('Characters', Color.fromRGBO(0, 173, 181, 100), Colors.black87, buttonWidth, buttonHeight, (){}),
                          SizedBox(height: 16),
                          BuildButton('Characters', Color.fromRGBO(0, 173, 181, 100), Colors.black87, buttonWidth, buttonHeight, (){}),
                          SizedBox(height: 16),
                          BuildButton('Locations', Color.fromRGBO(0, 173, 181, 100), Colors.black87, buttonWidth, buttonHeight, (){}),
                          SizedBox(height: 16),
                          BuildButton('Conversations', Color.fromRGBO(0, 173, 181, 100), Colors.black87, buttonWidth, buttonHeight, (){}),
                          SizedBox(height: 16),
                          BuildButton('Custom', Color.fromRGBO(0, 173, 181, 100), Colors.black87, buttonWidth, buttonHeight, (){}),
                          SizedBox(height: 16),
                          BuildButton('Attribute Templates', Color.fromRGBO(0, 173, 181, 100), Colors.black87, buttonWidth, buttonHeight, (){}),
                          SizedBox(height: 16),
                          BuildButton('Co Writers', Color.fromRGBO(0, 173, 181, 100), Colors.black87, buttonWidth, buttonHeight, (){}),
                        ]),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BuildButton('Send', Color.fromRGBO(0, 173, 181, 100), Colors.black87, 100, buttonHeight, (){}),
                                SizedBox(width: 16),
                                BuildButton('Update', Color.fromRGBO(0, 173, 181, 100), Colors.black87, 100, buttonHeight, (){}),
                                SizedBox(width: 16),
                                BuildButton('Merge Requests', Color.fromRGBO(0, 173, 181, 100), Colors.black87, 100, buttonHeight, (){}),
                              ]),
                            ),
                            SizedBox(height: 16),
                            quill.QuillToolbar.basic(controller: _controller),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 5, color: Colors.blue),
                                  color: Colors.white
                                ),
                                child: quill.QuillEditor.basic(
                                  controller: _controller,
                                  readOnly: false, // true for view only mode
                                ),
                              ),
                            ),
                    ])
                    )
                  ]),
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 450,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(width: 5, color: Colors.blue),
                        color: Colors.white
                      ),
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Editor Options:'),
                            Expanded(
                              child: Row(
                                children: [
                                  BuildButton('Repeated Words', Color.fromRGBO(0, 173, 181, 100), Colors.black87, 125, buttonHeight, (){}),
                                  SizedBox(width: 16),
                                  BuildButton('Tense Tracking', Color.fromRGBO(0, 173, 181, 100), Colors.black87, 125, buttonHeight, (){}),
                                  SizedBox(width: 16),
                                  BuildButton('Turning Point', Color.fromRGBO(0, 173, 181, 100), Colors.black87, 125, buttonHeight, (){}),
                                ])
                            )
                          ],
                        )
                      ),
                    ),
                    SizedBox(width: 16),
                    BuildButton('Manual Save', Color.fromRGBO(0, 173, 181, 100), Colors.black87, 100, buttonHeight, (){}),
                  ])
              )
          ]),
        )
      )
    );

  }
}

Widget BuildButton(String name, Color bgColor, Color textColor, double width, double height, Function onTap){
  return Flexible(
    child: SizedBox(
      width: width,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith(
              (states) => Colors.black12,
            ),
          ),
          onPressed: onTap,
          child: Text(
            name,
            style: kButtonText.copyWith(color: textColor),
          ),
        )
      )
    )
  );
}