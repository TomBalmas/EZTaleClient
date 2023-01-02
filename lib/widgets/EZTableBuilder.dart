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
  BuildTable(
      {key,
      this.nameOfTable,
      this.tableContent,
      this.entityName,
      this.entityType});
  final nameOfTable;
  var tableContent;
  String entityName, entityType;
  bool coWritersFlag = false;

  @override
  _BuildTable createState() => _BuildTable();
}

class _BuildTable extends State<BuildTable> {
  bool nameFlag = true;
  int _currentSortColumn = 0;
  bool _isAscending = true;
  List<DataColumn> columns = [];
  List<DataRow> rows = [];
  List<Text> cells;
  bool sortFlag = false;

  @override
  Widget build(BuildContext context) {
    if (!sortFlag) {
      columns = [];
      rows = [];
      _currentSortColumn = 0;
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
            cells.add(Text(location["name"]));
            if (checkEmptyField(location["vista"]).length > 150)
              cells.add(Text(location["vista"].substring(0, 150) + '...'));
            else
              cells.add(Text(checkEmptyField(location["vista"])));
            cells.add(Text('X'));
            rows.add(createRow(cells));
          }
          break;
        case 'Custom':
          columns.add(createColumn('Name'));
          columns.add(createColumn('Delete'));
          for (final customEntity in widget.tableContent) {
            cells = [];
            cells.add(Text(customEntity["name"]));
            cells.add(Text('X'));
            rows.add(createRow(cells));
          }
          break;
        case 'Attribute Templates':
          columns.add(createColumn('Name'));
          columns.add(createColumn('Delete'));
          for (final template in widget.tableContent) {
            cells = [];
            cells.add(Text(template["name"]));
            cells.add(Text('X'));
            rows.add(createRow(cells));
          }
          break;
        case 'Events':
          columns.add(createColumn('Name'));
          columns.add(createColumn('Description'));
          columns.add(createColumn('Delete'));
          for (final event in widget.tableContent) {
            cells = [];
            cells.add(Text(checkEmptyField(event["name"])));
            cells.add(Text(checkEmptyField(event["desc"])));
            cells.add(Text('X'));
            rows.add(createRow(cells));
          }
          break;
        case 'Co-writers':
          columns.add(createColumn('coUsername'));
          columns.add(createColumn('deadLine'));
          columns.add(createColumn('description'));
          for (final writer in widget.tableContent) {
            cells = [];
            cells.add(Text(writer["coUsername"]));
            cells.add(Text(writer["deadLine"]));
            cells.add(Text(writer["description"]));
            rows.add(createRow(cells));
          }
          break;
        case 'Relations':
          columns.add(createColumn('Name'));
          columns.add(createColumn('Type'));
          columns.add(createColumn('Remove'));
          for (final entity in widget.tableContent) {
            cells = [];
            cells.add(Text(entity["name"]));
            if (entity["type"] == 'storyEvent')
              cells.add(Text('event'));
            else
              cells.add(Text(entity["type"]));
            cells.add(Text('X'));
            rows.add(createRow(cells));
          }
          break;
        case 'Choose Relations':
          columns.add(createColumn('Name'));
          columns.add(createColumn('Type'));
          for (final entity in widget.tableContent) {
            cells = [];
            cells.add(Text(entity["name"]));
            if (entity["type"] == 'storyEvent')
              cells.add(Text('event'));
            else
              cells.add(Text(entity["type"]));
            rows.add(createRow(cells));
          }
          break;
      }
    }
    sortFlag = false;
    return DataTable(
        showCheckboxColumn: false,
        columns: columns,
        rows: rows,
        sortColumnIndex: _currentSortColumn,
        sortAscending: _isAscending);
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

  // ignore: missing_return
  DataRow createRow(List<Text> widgetCells) {
    String entityName;
    List<DataCell> datacCells = [];
    for (Text cell in widgetCells) {
      if (nameFlag) {
        entityName = cell.data;
        nameFlag = false;
      }
      if (cell.data == 'X' && widget.nameOfTable != 'Relations') {
        datacCells.add(DataCell(cell, onTap: (() {
          deleteEntity(MyApp.bookManager.getOwnerUsername(),
                  MyApp.bookManager.getBookName(), entityName)
              .then((value) {
            final data = jsonDecode(value);
            if (data['msg'] == 'Entity Deleted')
              showAlertDiaglog(context, "Success",
                  "Entity " + entityName + " was deleted successfuly.", () {
                Navigator.pop(context, 'OK');
                getAllTypeEntities(
                        MyApp.bookManager.getBookName(),
                        MyApp.bookManager.getOwnerUsername(),
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
      } else if (cell.data == 'X' && widget.nameOfTable == 'Relations') {
        datacCells.add(DataCell(cell, onTap: () {
          Text name = datacCells[0].child, type = datacCells[1].child;
          for (final relation in relations)
            if (relation['name'] == name.data &&
                relation['type'] == type.data) {
              deleteRelation(
                  MyApp.bookManager.getOwnerUsername(),
                  MyApp.bookManager.getBookName(),
                  name.data,
                  type.data,
                  name.data,
                  type.data);

              relations.remove(relation);
              break;
            }
          setState(() {});
        }));
      } else
        datacCells.add(DataCell(cell));
    }
    /*
    Table in the Tables screen
    */
    if (widget.nameOfTable != 'Relations' &&
        widget.nameOfTable != 'Choose Relations')
      return DataRow(
        cells: datacCells,
        onSelectChanged: (selected) async {
          await Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => EntityScreen(
                        type: widget.nameOfTable
                            .substring(0, widget.nameOfTable.length - 1),
                        content: datacCells,
                      )));
          getAllTypeEntities(
                  MyApp.bookManager.getBookName(),
                  MyApp.bookManager.getOwnerUsername(),
                  getType(widget.nameOfTable))
              .then((value) {
            final data = jsonDecode(value);
            widget.tableContent = data;
            setState(() {});
          });
        },
      );
    else if (widget.nameOfTable == 'Choose Relations') {
      Text name = datacCells[0].child, type = datacCells[1].child;
      return DataRow(
        cells: datacCells,
        onSelectChanged: (selected) {
          relations.add({'name': name.data, 'type': type.data});
          addRelation(
              MyApp.bookManager.getOwnerUsername(),
              MyApp.bookManager.getBookName(),
              widget.entityName,
              widget.entityType,
              name.data,
              type.data);
          Navigator.pop(context);
        },
      );
    } else if (widget.nameOfTable == 'Co-Writers') {
      return DataRow(
        cells: datacCells,
      );
    } else if (widget.nameOfTable == 'Relations') {
      return DataRow(
        cells: datacCells,
      );
    }
  }

  DataColumn createColumn(String name) {
    if (name != 'Delete' && name != 'Remove')
      return DataColumn(
        label: Text(name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        onSort: (columnIndex, ascending) {
          sortFlag = true;
          _currentSortColumn = columnIndex;
          if (rows.isNotEmpty) {
            if (_isAscending == true) {
              _isAscending = false;
              // sort the list in Ascending, order by name
              rows.sort((nameA, nameB) => nameB.cells[columnIndex].child
                  .toString()
                  .toLowerCase()
                  .compareTo(
                      nameA.cells[columnIndex].child.toString().toLowerCase()));
            } else {
              _isAscending = true;
              // sort the list in Descending, order by name
              rows.sort((nameA, nameB) => nameA.cells[columnIndex].child
                  .toString()
                  .toLowerCase()
                  .compareTo(
                      nameB.cells[columnIndex].child.toString().toLowerCase()));
            }
            setState(() {});
          }
        },
      );
    return DataColumn(
      label: Text(name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
