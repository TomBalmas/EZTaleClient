import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../utils/Responsive.dart';
import '../Screens.dart';
import 'EZBookInfo.dart';

class MyBooks extends StatelessWidget {
  MyBooks({
    Key key,
    @required
    this.booksList
  }) : super(key: key);

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
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => EditorScreen()),
                );
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
