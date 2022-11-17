import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:ez_tale/EZNetworking.dart';

class EZBooksDue extends StatelessWidget {
  const EZBooksDue({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Files",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("Story Name"),
                ),
                DataColumn(
                  label: Text("Date"),
                ),
                DataColumn(
                  label: Text("Size"),
                ),
              ],
              // rows: List.generate(
              //   demoRecentFiles.length, // TODO: change to due books
              //   (index) => recentFileDataRow(demoRecentFiles[index]),//TODO: change to due books
              // ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow dueBooksDataRow(String bookDue) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text("bookDue.title"),
            ),
          ],
        ),
      ),
      DataCell(Text("bookDue.date")),
      DataCell(Text("bookDue.mission")),
    ],
  );
}