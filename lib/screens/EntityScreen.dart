import 'package:flutter/material.dart';

import '../widgets/EZBuildButton.dart';
import '../widgets/EZDrawer.dart';

class EntityScreen extends StatelessWidget {
  EntityScreen({
    key,
    this.type,
    this.content,
  });
  final type;
  final content; // List<String>, content[0] = name

  @override
  Widget build(BuildContext context) {
    var name = content[0];
    return Scaffold( //TODO: fix parent exception
        drawer: EZDrawer(),
        appBar: AppBar(
          title: Text(type + ': ' + name),
        ),
        body: Container(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: BuildButton(
                  name: 'Back',
                  bgColor: Color.fromRGBO(0, 173, 181, 100),
                  textColor: Colors.black87,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  width: 100,
                ))));
  }
}
