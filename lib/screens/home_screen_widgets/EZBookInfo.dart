import 'package:ez_tale/screens/home_screen_widgets/EZBooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants.dart';

// this class if for the preview of the
//books and click on them will move to the editor

//get from https://github.com/abuanwar072/Flutter-Responsive-Admin-Panel-or-Dashboard

class BookInfoCard extends StatelessWidget {
  BookInfoCard(
    @required this.bookInfo
    );

  EZBook bookInfo;
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
              Icon(Icons.more_vert, color: Colors.white54)
            ],
          ),
          Text(
            bookInfo.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                bookInfo.description,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.white70),
              ),
              Text(
                "type: " + bookInfo.type,
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
