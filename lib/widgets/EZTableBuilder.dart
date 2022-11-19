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
                    'Mock',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)  
                )),  
                DataColumn(label: Text(  
                    'Mock',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)  
                )),  
                DataColumn(label: Text(  
                    'Mock',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)  
                )),  
              ],  
              rows: [  
                DataRow(cells: [  
                  DataCell(Text('Mock')),  
                  DataCell(Text('Mock')),  
                  DataCell(Text('Mock')),  
                ]),  
                DataRow(cells: [  
                  DataCell(Text('Mock')),  
                  DataCell(Text('Mock')),  
                  DataCell(Text('Mock')),  
                ]),  
                DataRow(cells: [  
                  DataCell(Text('Mock')),  
                  DataCell(Text('Mock')),  
                  DataCell(Text('Mock')),   
                ]),  
                DataRow(cells: [  
                  DataCell(Text('Mock')),  
                  DataCell(Text('Mock')),  
                  DataCell(Text('Mock')),   
                ]),  
              ],  
            ); 
  }  
}  