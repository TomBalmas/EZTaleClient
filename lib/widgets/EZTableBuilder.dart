import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/EntityScreen.dart';
import 'EZBuildButton.dart';

class BuildTable extends StatefulWidget {
  BuildTable({
    key,
    this.nameOfTable,
    this.tableContent,
  });
  final nameOfTable;
  final tableContent;
  @override
  _BuildTable createState() => _BuildTable();
}

class _BuildTable extends State<BuildTable> {
  @override
  Widget build(BuildContext context) {
    List<DataColumn> columns = [];
    List<DataRow> rows = [];
    List<Widget> cells;
    String participants = '';
    switch (widget.nameOfTable) {
      case 'Characters':
        columns.add(createColumn('Name'));
        columns.add(createColumn('Surename'));
        columns.add(createColumn('Age'));
        columns.add(createColumn('Gender'));
        columns.add(createColumn('Delete'));
        for (final character in widget.tableContent) {
          cells = [];
          cells.add(Text(character["name"]));
          cells.add(Text(checkEmptyField(character["surename"])));
          cells.add(Text(checkEmptyField(character["age"].toString())));
          cells.add(Text(checkEmptyField(character["gender"])));
          cells.add(BuildButton(
              name: 'X',
              bgColor: Color.fromRGBO(0, 173, 181, 100),
              textColor: Colors.black87,
              height: 40,
              width: 40,
              onTap: () {
                setState(() {});
              }));
          rows.add(createRow(cells));
        }
        break;
      case 'Locations':
        columns.add(createColumn('Name'));
        columns.add(createColumn('Description'));
        for (final location in widget.tableContent) {
          cells = [];
          cells.add(location["name"]);
          cells.add(location["vista"]);
          rows.add(createRow(cells));
        }
        break;
      case 'Conversations':
        columns.add(createColumn('Name'));
        columns.add(createColumn('Participants'));
        for (final conversation in widget.tableContent) {
          cells = [];
          cells.add(conversation["name"]);
          if (conversation["participants"].length == 0)
            cells.add(Text('-'));
          else {
            for (final participant in conversation["participants"])
              participants += participant["name"];
            cells.add(Text(participants));
          }
          rows.add(createRow(cells));
        }
        break;
      case 'Custom':
        columns.add(createColumn('Name'));
        for (final customEntity in widget.tableContent) {
          cells = [];
          cells.add(customEntity["name"]);
          rows.add(createRow(cells));
        }
        break;
      case 'Attribute Templates':
        columns.add(createColumn('Name'));
        for (final template in widget.tableContent) {
          cells = [];
          cells.add(template["name"]);
          rows.add(createRow(cells));
        }
        break;
      case 'Events':
        columns.add(createColumn('Name'));
        columns.add(createColumn('Description'));
        for (final event in widget.tableContent) {
          cells = [];
          cells.add(event["name"]);
          cells.add(event["desc"]);
          rows.add(createRow(cells));
        }
        break;
    }

    return DataTable(showCheckboxColumn: false, columns: columns, rows: rows);
  }

  String checkEmptyField(String entity) {
    if (entity == null ||
        entity == 'null' ||
        entity == '' ||
        entity == ' ' ||
        entity == '\n')
      return '-';
    else
      return entity;
  }

  DataRow createRow(List<Widget> cellsWithNulls) {
    List<DataCell> cellsWithoutNulls = [];
    for (Widget cell in cellsWithNulls) {
      cellsWithoutNulls.add(DataCell(cell));
    }
    return DataRow(
      cells: cellsWithoutNulls,
      onSelectChanged: (selected) {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => EntityScreen(
                      type: widget.nameOfTable
                          .substring(0, widget.nameOfTable.length - 1),
                      content: cellsWithNulls,
                    )));
      },
    );
  }
}

DataColumn createColumn(String name) {
  return DataColumn(
      label: Text(name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
}
