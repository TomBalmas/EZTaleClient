import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/Widgets.dart';
import 'EditorScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: EZDrawer(),
      appBar: AppBar(
        title: const Text('Home'),
        foregroundColor: Colors.grey,
        backgroundColor: kBackgroundColor,
      ),
      body: Center(
        child: EZTextButton(
          buttonName: 'Editor Screen', // TODO correct the button
          onTap: (){
            Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => EditorScreen()));
                      return;
          },
          bgColor: Color.fromRGBO(0, 173, 181, 100),
          textColor: Colors.black87
        )
      )
    );
  }
}
