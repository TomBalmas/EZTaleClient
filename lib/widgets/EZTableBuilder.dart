import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/EntityScreen.dart';

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
    List<String> cells;
    String participants = '';
    switch (widget.nameOfTable) {
      case 'Characters':
        columns.add(createColumn('Name'));
        columns.add(createColumn('Surename'));
        columns.add(createColumn('Age'));
        columns.add(createColumn('Gender'));
        for (final character in widget.tableContent) {
          cells = [];
          cells.add(character["name"]);
          cells.add(character["surename"]);
          cells.add(character["age"].toString());
          cells.add(character["gender"]);
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
          print(conversation);
          cells = [];
          cells.add(conversation["name"]);
          if (conversation["participants"].length == 0)
            cells.add('-');
          else {
            for (final participant in conversation["participants"])
              participants += participant["name"];
            cells.add(participants);
          }
          rows.add(createRow(cells));
        }
        break;
    }

    return DataTable(showCheckboxColumn: false, columns: columns, rows: rows);
  }

  DataRow createRow(List<String> cellsWithNulls) {
    List<DataCell> cellsWithoutNulls = [];
    for (String cell in cellsWithNulls) {
      if (cell == null ||
          cell == 'null' ||
          cell == '' ||
          cell == ' ' ||
          cell == '\n') cell = '-';
      cellsWithoutNulls.add(DataCell(Text(cell)));
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
