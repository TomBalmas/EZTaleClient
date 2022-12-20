import 'package:ez_tale/constants.dart';
import 'package:flutter/material.dart';

class EZComboBox extends StatefulWidget {
  List list;

  EZComboBox(this.list);

  @override
  State<EZComboBox> createState() => _EZComboBoxState(list);
}

class _EZComboBoxState extends State<EZComboBox> {
  List list;
  String dropdownValue;
  List<DropdownMenuItem<String>> menuItems = new List<DropdownMenuItem<String>>();
  _EZComboBoxState(this.list) {
    dropdownValue = list.first;
    for (var val in list) 
      menuItems.add(DropdownMenuItem(child: Text(val), value: val));
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        color: secondaryColor,
      ),
      onChanged: (String value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value;
        });
      },
      items: menuItems,
    );
  }
}
