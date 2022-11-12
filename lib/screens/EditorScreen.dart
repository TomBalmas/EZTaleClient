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
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 100, right: 100, bottom: 100),
            child: Column(
              children: [
                SizedBox(height: 16),
                Row(  //FIXME overflow
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildButton('Send', Color.fromRGBO(0, 173, 181, 100), Colors.black87, buttonWidth, buttonHeight, (){}),
                    SizedBox(width: 16),
                    buildButton('Update', Color.fromRGBO(0, 173, 181, 100), Colors.black87, buttonWidth, buttonHeight, (){}),
                    SizedBox(width: 16),
                    buildButton('Merge Requests', Color.fromRGBO(0, 173, 181, 100), Colors.black87, buttonWidth, buttonHeight, (){}),
                  ]
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
                )
              ],
          ),
        )
      )
    );

  }
}


buildButton(String buttonName, Color bgColor, Color textColor, double width, double height, Function onTap){
    return SizedBox(
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
                buttonName,
                style: kButtonText.copyWith(color: textColor),
              ),
            )));
}