import 'dart:convert';
import 'package:ez_tale/EZNetworking.dart';
import 'package:ez_tale/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../utils/Responsive.dart';
import '../Screens.dart';
import 'EZBookInfo.dart';
import 'EZBooks.dart';

class MyBooks extends StatelessWidget {
  const MyBooks({
    Key key,
  }) : super(key: key);

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
                  CupertinoPageRoute(builder: (context) => NewStoryScreen()),
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
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 ? 1.3 : 1,
          ),
          tablet: EZBookInfoCardGridView(),
          desktop: EZBookInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class EZBookInfoCardGridView extends StatelessWidget {
  EZBookInfoCardGridView({
    Key key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  int getUserStoryCount() {
    int cnt;
    var res = getStoryCount(MyApp.userManager.getCurrentToken());
    res.then((value) {
      final data = jsonDecode(value);
      if (data['success'])
        cnt = data['count'] as int;
      else
        print('count didnt work');
    });
    return cnt;
  }

  List getUserStories() {
    List retList = <EZBook>[];
    var res = getAllStories(MyApp.userManager.getCurrentToken());
    res.then((value) {
      final data = jsonDecode(value);
      for (int i = 0; i < getUserStoryCount(); i++) {
        retList.add(new EZBook(
            title: data[i]['name'],
            description: data[i]['description'],
            type: data[i]['type']));
      }
    });
    return retList;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: getUserStoryCount(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) {
          List storyLists = getUserStories();
          return BookInfoCard(storyLists[index]);
        });
  }
}
