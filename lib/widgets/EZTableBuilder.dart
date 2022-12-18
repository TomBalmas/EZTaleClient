import 'dart:convert';

import 'package:ez_tale/EZNetworking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/EntityScreen.dart';
import '../screens/NewEntityScreen.dart';
import '../screens/TablesScreen.dart';

// ignore: must_be_immutable
class BuildTable extends StatefulWidget {
  BuildTable({
    key,
    this.nameOfTable,
    this.tableContent,
  });
  final nameOfTable;
  var tableContent;

  @override
  _BuildTable createState() => _BuildTable();
}

class _BuildTable extends State<BuildTable> {
  bool nameFlag = true;
  @override
  Widget build(BuildContext context) {
    List<DataColumn> columns = [];
    List<DataRow> rows = [];
    List<Text> cells;
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
          cells.add(Text('X'));
          rows.add(createRow(cells));
        }
        break;
      case 'Locations':
        columns.add(createColumn('Name'));
        columns.add(createColumn('Description'));
        columns.add(createColumn('Delete'));
        for (final location in widget.tableContent) {
          cells = [];
          cells.add(Text(checkEmptyField(location["name"])));
          if (checkEmptyField(location["vista"]).length > 150)
            cells.add(Text(location["vista"].substring(0, 150) + '...'));
          else
            cells.add(Text(checkEmptyField(location["vista"])));
          cells.add(Text('X'));
          rows.add(createRow(cells));
        }
        break;
      case 'Conversations':
        columns.add(createColumn('Name'));
        columns.add(createColumn('Participants'));
        columns.add(createColumn('Delete'));
        for (final conversation in widget.tableContent) {
          cells = [];
          cells.add(Text(conversation["name"]));
          if (conversation["participants"].length == 0)
            cells.add(Text('-'));
          else {
            for (final participant in conversation["participants"])
              participants += participant["name"];
            cells.add(Text(participants));
          }
          cells.add(Text('X'));
          rows.add(createRow(cells));
        }
        break;
      case 'Custom':
        columns.add(createColumn('Name'));
        for (final customEntity in widget.tableContent) {
          cells = [];
          cells.add(Text(customEntity["name"]));
          cells.add(Text('X'));
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

  DataRow createRow(List<Text> widgetCells) {
    String entityName;
    List<DataCell> datacCells = [];
    for (Text cell in widgetCells) {
      if (nameFlag) {
        entityName = cell.data;
        nameFlag = false;
      }
      if (cell.data == 'X') {
        datacCells.add(DataCell(cell, onTap: (() {
          deleteEntity(MyApp.userManager.getCurrentUsername(),
                  MyApp.bookManager.getBookName(), entityName)
              .then((value) {
            final data = jsonDecode(value);
            if (data['msg'] == 'Entity Deleted')
              showAlertDiaglog(context, "Success",
                  "Entity " + entityName + " was deleted successfuly.", () {
                Navigator.pop(context, 'OK');
                getAllTypeEntities(
                        MyApp.bookManager.getBookName(),
                        MyApp.userManager.getCurrentUsername(),
                        getType(widget.nameOfTable))
                    .then((value) {
                  final data = jsonDecode(value);
                  widget.tableContent = data;
                  setState(() {});
                });
              });
          });
        })));
        nameFlag = true;
      } else
        datacCells.add(DataCell(cell));
    }
    return DataRow(
      cells: datacCells,
      onSelectChanged: (selected) {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => EntityScreen(
                      type: widget.nameOfTable
                          .substring(0, widget.nameOfTable.length - 1),
                      content: datacCells,
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
