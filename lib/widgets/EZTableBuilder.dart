import 'package:flutter/material.dart';  
  
class BuildTable extends StatefulWidget {  
  @override  
  _BuildTable createState() => _BuildTable();  
}  
  
class _BuildTable extends State<BuildTable> {  
  @override  
  Widget build(BuildContext context) {  
    return   DataTable(  
              columns: [  
                DataColumn(label: Text(  
                    'ID',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)  
                )),  
                DataColumn(label: Text(  
                    'Name',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)  
                )),  
                DataColumn(label: Text(  
                    'Profession',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)  
                )),  
              ],  
              rows: [  
                DataRow(cells: [  
                  DataCell(Text('1')),  
                  DataCell(Text('Stephen')),  
                  DataCell(Text('Actor')),  
                ]),  
                DataRow(cells: [  
                  DataCell(Text('5')),  
                  DataCell(Text('John')),  
                  DataCell(Text('Student')),  
                ]),  
                DataRow(cells: [  
                  DataCell(Text('10')),  
                  DataCell(Text('Harry')),  
                  DataCell(Text('Leader')),  
                ]),  
                DataRow(cells: [  
                  DataCell(Text('15')),  
                  DataCell(Text('Peter')),  
                  DataCell(Text('Scientist')),  
                ]),  
              ],  
            ); 
  }  
}  