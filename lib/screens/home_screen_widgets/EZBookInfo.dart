import 'package:ez_tale/main.dart';
import 'package:ez_tale/screens/Screens.dart';
import 'package:ez_tale/screens/home_screen_widgets/EZBooks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

// this class if for the preview of the
//books and click on them will move to the editor

//get from https://github.com/abuanwar072/Flutter-Responsive-Admin-Panel-or-Dashboard

// ignore: must_be_immutable
class BookInfoCard extends StatefulWidget {
  BookInfoCard(this.bookInfo);
  EZBook bookInfo;

  @override
  State<BookInfoCard> createState() => _BookInfoCardState(bookInfo);
}

class _BookInfoCardState extends State<BookInfoCard> {
  _BookInfoCardState(this.bookInfo);
  bool _toDel = false;
  EZBook bookInfo;
  TextEditingController deleteTextController = new TextEditingController();
  void _checkToDel() {
    _toDel = deleteTextController.text == 'DELETE';
  }

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    deleteTextController.addListener(_checkToDel);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    deleteTextController.dispose();
    super.dispose();
  }

  void showAcceptDiaglog(
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

  void showAlartDialog(BuildContext context, String alt, String desc,
      Function delete_func, Function cancel_func) async {
    showDialog<String>(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text(alt),
              content: Text(desc),
              actions: <Widget>[
                TextFormField(
                  controller: deleteTextController,
                  onChanged: (text) {
                    setState(() {
                      _checkToDel();
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: TextButton(
                    key: Key('textDel'),
                    onPressed: _toDel ? delete_func : null,
                    child: const Text('Delete'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    deleteTextController.text = '';
                    cancel_func();
                  },
                  child: const Text('Cancel'),
                )
              ],
            );
          });
        });
  }

  void showPopUpMenuAtTap(BuildContext context, TapDownDetails details) async {
    showMenu(
      context: context,
      color: kBackgroundColor,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: [
        PopupMenuItem<String>(child: const Text('Edit'), value: 'edit'),
        PopupMenuItem<String>(child: const Text('Delete'), value: 'delete')
      ],
      elevation: 8.0,
    ).then<void>((String itemSelected) {
      if (itemSelected == null) return;
      if (itemSelected == 'edit') {
        MyApp.bookManager
            .setBook(MyApp.userManager.getCurrentUsername(), bookInfo.title);
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) =>
                    EditorScreen())); //add build book, entities
      } else if (itemSelected == 'delete') {
        showAlartDialog(context, 'Delete?', 'Write \"DELETE\" to confirm:', () {
          MyApp.userManager
              .deleteUsersBook(
                  MyApp.userManager.getCurrentUsername(), bookInfo.title)
              .then((boolValue) => MyApp.userManager
                      .updateUserStoriesList()
                      .then((booksListValue) {
                    if (boolValue)
                      showAcceptDiaglog(
                          context,
                          'Deleted',
                          'Book deleted successfully',
                          () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => HomeScreen(
                                        booksList: booksListValue,
                                      ))));
                  })); //delete book function
        },
            () => Navigator.pop(
                context, 'cancel')); // don't do anything when cancel
      }
    });
  }

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: EdgeInsets.all(defaultPadding * 0.75),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  )),
              GestureDetector(
                  child: Icon(Icons.more_vert, color: Colors.white54),
                  onTapDown: (details) => showPopUpMenuAtTap(context, details))
            ],
          ),
          Text(
            widget.bookInfo.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.bookInfo.description,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.white70),
              ),
              Text(
                widget.bookInfo.type,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.white70),
              ),
            ],
          )
        ],
      ),
    );
  }
}
