import 'dart:convert';

import 'package:ez_tale/EZNetworking.dart';
import 'package:ez_tale/screens/EditorScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/EntityScreen.dart';
import '../screens/NewEntityScreen.dart';
import '../screens/TablesScreen.dart';

void showAcceptRequestDiaglog(
    BuildContext context, String alt, String desc, String coUsername) async {
  TextEditingController pageController = new TextEditingController();
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(alt),
      content: Text(desc),
      actions: <Widget>[
        TextFormField(
          decoration: InputDecoration(hintText: 'Page to merge'),
          controller: pageController,
        ),
        TextButton(
          onPressed: () {
            approveMergeRequest(
                    MyApp.bookManager.getOwnerUsername(),
                    MyApp.bookManager.getBookName(),
                    coUsername,
                    pageController.text)
                .then((value) => Navigator.pop(context));
          },
          child: const Text('OK'),
        ),
        TextButton(
          onPressed: (() => Navigator.pop(context)),
          child: const Text('Cancel'),
        ),
      ],
    ),
  );
}

Future<bool> showDisapproveRequestDiaglog(
    BuildContext context, String alt, String desc, String coUsername) async {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(alt),
      content: Text(desc),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            deleteMergeRequest(MyApp.bookManager.getOwnerUsername(),
                    MyApp.bookManager.getBookName(), coUsername)
                .then((value) {
              Navigator.pop(context);
              return true;
            });
          },
          child: const Text('Delete'),
        ),
        TextButton(
          onPressed: (() {
            Navigator.pop(context);
            return false;
          }),
          child: const Text('Cancel'),
        ),
      ],
    ),
  );
  return false;
}

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
          columns.add(createColumn('Username'));
          columns.add(createColumn('Deadline'));
          columns.add(createColumn('Description'));
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
        case 'MergeRequests':
          columns.add(createColumn('Username'));
          columns.add(createColumn('Accepted'));
          columns.add(createColumn('     '));
          columns.add(createColumn('     '));
          for (final request in widget.tableContent) {
            cells = [];
            cells.add(Text(request["coUsername"]));
            cells.add(Text(request["accepted"].toString()));
            cells.add(Text("Approve"));
            cells.add(Text("Disapprove"));
            rows.add(createRow(cells));
          }
          break;
        case 'Apply Template':
          columns.add(createColumn('Name'));
          for (final template in widget.tableContent) {
            cells = [];
            cells.add(Text(template["name"]));
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

  /*
  fills empty field
  */
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
    String tableName = widget.nameOfTable;
    String type = tableName.toLowerCase().substring(0, tableName.length - 1);
    //correct the type
    if (tableName == 'Custom')
      type = 'userDefined';
    else if (tableName == 'Attribute Templates' ||
        tableName == 'Apply Template')
      type = 'attributeTemplate';
    else if (tableName == 'Events') type = 'storyEvent';
    List<DataCell> datacCells = [];
    for (Text cell in widgetCells) {
      //gets the name of the entity
      if (nameFlag) {
        entityName = cell.data;
        nameFlag = false;
      }

      //adds the delete button
      if (cell.data == 'X' && widget.nameOfTable != 'Relations') {
        datacCells.add(DataCell(cell, onTap: (() {
          deleteEntity(MyApp.bookManager.getOwnerUsername(),
                  MyApp.bookManager.getBookName(), entityName, type)
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
      }
      //adds the remove relation button
      else if (cell.data == 'X' && widget.nameOfTable == 'Relations') {
        datacCells.add(DataCell(cell, onTap: () {
          Text name = datacCells[0].child, type = datacCells[1].child;
          for (final relation in relations)
            if (relation['name'] == name.data &&
                relation['type'] == type.data) {
              deleteRelation(
                  MyApp.bookManager.getOwnerUsername(),
                  MyApp.bookManager.getBookName(),
                  widget.entityName,
                  widget.entityType,
                  name.data,
                  type.data);
              relations.remove(relation);
              break;
            }
          setState(() {});
        }));
      } else if (cell.data == 'Approve' &&
          widget.nameOfTable == 'MergeRequests') {
        datacCells.add(DataCell(cell, onTap: () {
          Text username = datacCells[0].child, approved = datacCells[1].child;
          for (final request in MyApp.bookManager.getBookMergeRequests()) {
            if (request['coUsername'] == username.data &&
                approved.data != 'true') {
              showAcceptRequestDiaglog(
                  context,
                  'Which page to merge?',
                  'Please select a page to merge to and press OK',
                  username.data);
              break;
            }
            setState(() {});
          }
        }));
      } else if (cell.data == 'Disapprove' &&
          widget.nameOfTable == 'MergeRequests') {
        datacCells.add(DataCell(cell, onTap: () {
          Text username = datacCells[0].child, approved = datacCells[1].child;
          for (final request in MyApp.bookManager.getBookMergeRequests()) {
            if (request['coUsername'] == username.data &&
                approved.data != 'true') {
              showDisapproveRequestDiaglog(
                  context,
                  'Disapprove Merge Request?',
                  'Are you sure you want to disapprove\n the merge request?',
                  username.data);
              MyApp.bookManager.mergeRequests.remove(request);
              break;
            }
            setState(() {});
          }
        }));
      } else
        datacCells.add(DataCell(cell));
    }

    /*
    Table in the tables screen
    */
    if (widget.nameOfTable != 'Relations' &&
        widget.nameOfTable != 'Choose Relations' &&
        widget.nameOfTable != 'Co-writers' &&
        widget.nameOfTable != 'MergeRequests' &&
        widget.nameOfTable != 'Apply Template')
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
    } else if (widget.nameOfTable == 'Co-writers') {
      return DataRow(
        cells: datacCells,
      );
    } else if (widget.nameOfTable == 'Relations') {
      return DataRow(
        cells: datacCells,
      );
    } else if (widget.nameOfTable == 'MergeRequests') {
      return DataRow(
        cells: datacCells,
        onSelectChanged: (value) {
          Text username = datacCells[0].child;
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => EditorScreen(
                      isCoBook: true,
                      isWatch: true,
                      coWriterName: username.data)));
        },
      );
    } else
      return DataRow(cells: datacCells);
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
