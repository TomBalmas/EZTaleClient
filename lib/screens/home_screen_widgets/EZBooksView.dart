import 'dart:convert';

import 'package:ez_tale/EZNetworking.dart';
import 'package:ez_tale/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../utils/Responsive.dart';
import '../Screens.dart';
import 'EZBookInfo.dart';

class MyBooks extends StatelessWidget {
  MyBooks({Key key, @required this.booksList}) : super(key: key);

  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Book"), value: "Book"),
    DropdownMenuItem(child: Text("Script"), value: "Script"),
  ];

  showAlertDiaglog(
      BuildContext context, String alt, String desc, Function func) async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(alt),
        content: Text(desc),
        actions: <Widget>[
          TextButton(
            onPressed: func,
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  showNewStoryPopUp(BuildContext context) {
    TextEditingController newStoryNameController = new TextEditingController();
    TextEditingController descriptionController = new TextEditingController();
    String selectedValue = "Book";
    showDialog<String>(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text('Add New Story'),
              content: Text('Type the name of the new story:'),
              actions: <Widget>[
                DropdownButton(
                  value: selectedValue,
                  items: menuItems,
                  onChanged: (newValue) {
                    setState(() {
                      selectedValue = newValue;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Story Name'),
                  controller: newStoryNameController,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Description'),
                  controller: descriptionController,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: TextButton(
                    onPressed: () {
                      addNewStory(
                              MyApp.userManager.getCurrentUsername(),
                              newStoryNameController.text,
                              descriptionController.text,
                              selectedValue)
                          .then((value) {
                        final data = jsonDecode(value);
                        if (data['msg'] == 'Story already exists') {
                          showAlertDiaglog(
                              context,
                              'Story already exists',
                              'Story already exists',
                              () => Navigator.pop(context, 'OK'));
                        } else if (data['msg'] == 'Story Saved Successfully') {
                          showAlertDiaglog(context, 'Story Saved Successfully',
                              'Story Saved Successfully', () {
                            MyApp.bookManager.setBook(
                                MyApp.userManager.getCurrentUsername(),
                                newStoryNameController.text);
                            MyApp.userManager.updateUserStoriesList();
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => EditorScreen()));
                          });
                        }
                      });
                    },
                    child: const Text('Accept'),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                )
              ],
            );
          });
        });
  }

  final booksList;
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Books",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                showNewStoryPopUp(context);
              },
              icon: Icon(Icons.add),
              label: Text("Add New Story"),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: EZBookInfoCardGridView(
            booksCnt: booksList.length,
            booksList: booksList,
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 ? 1.3 : 1,
          ),
          tablet: EZBookInfoCardGridView(
            booksCnt: booksList.length,
            booksList: booksList,
          ),
          desktop: EZBookInfoCardGridView(
            booksCnt: booksList.length,
            booksList: booksList,
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class EZBookInfoCardGridView extends StatelessWidget {
  EZBookInfoCardGridView(
      {Key key,
      this.crossAxisCount = 4,
      this.childAspectRatio = 1,
      @required this.booksCnt,
      @required this.booksList})
      : super(key: key);
  final booksCnt;
  final booksList;
  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: booksCnt,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) {
          return BookInfoCard(booksList[index]);
        });
  }
}
