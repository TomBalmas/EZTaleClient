import 'package:ez_tale/EZNetworking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import '../widgets/Widgets.dart';

class EditorScreen extends StatelessWidget {
  quill.QuillController _controller = quill.QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: EZDrawer(),
        appBar: AppBar(title: Text('Book1')),
        body: Center(
          child: Column(
            children: [
              quill.QuillToolbar.basic(controller: _controller),
              Expanded(
                child: Container(
                  child: quill.QuillEditor.basic(
                    controller: _controller,
                    readOnly: false, // true for view only mode
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
