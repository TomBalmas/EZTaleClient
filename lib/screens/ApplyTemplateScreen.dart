import 'package:flutter/material.dart';
import '../widgets/EZBuildButton.dart';
import '../widgets/Widgets.dart';

// ignore: must_be_immutable
class ApplyTemplate extends StatefulWidget {
  ApplyTemplate({key, this.tableContent});
  var tableContent;

  @override
  State<ApplyTemplate> createState() => _ApplyTemplateState();
}

class _ApplyTemplateState extends State<ApplyTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: EZDrawer(),
        appBar: AppBar(
          title: Text('Apply Template'),
        ),
        body: Container(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Choose a template to apply:',
                          style: TextStyle(fontSize: 64, color: Colors.grey),
                        ),
                        BuildButton(
                          name: 'Back',
                          bgColor: Color.fromRGBO(0, 173, 181, 100),
                          textColor: Colors.black87,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          width: 100,
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    Expanded(
                        child: ListView(children: [
                      BuildTable(
                          nameOfTable: 'Apply Template',
                          tableContent: widget.tableContent)
                    ]))
                  ],
                ))));
  }
}
