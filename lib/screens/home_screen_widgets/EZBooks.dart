import 'package:ez_tale/main.dart';

class EZBook {
  final String title, description, type;

  EZBook({this.title, this.description, this.type});
}

List demoEZBooks = [
  EZBook(
    title: "XD File",
    description: "01-03-2021",
    type: "3.5mb",
  ),
  EZBook(
    title: "Figma File",
    description: "27-02-2021",
    type: "19.0mb",
  ),
  EZBook(
    title: "Document",
    description: "23-02-2021",
    type: "32.5mb",
  ),
  EZBook(
    title: "Sound File",
    description: "21-02-2021",
    type: "3.5mb",
  ),
  EZBook(
    title: "Media File",
    description: "23-02-2021",
    type: "2.5gb",
  ),
  EZBook(
    title: "Sales PDF",
    description: "25-02-2021",
    type: "3.5mb",
  ),
  EZBook(
    title: "Excel File",
    description: "25-02-2021",
    type: "34.5mb",
  ),
];
