import 'package:flutter/material.dart';
import '../constants.dart';

class BuildButton extends StatelessWidget{
  BuildButton({
    Key key,
    @required this.name,
    this.onTap,
    @required this.bgColor,
    @required this.textColor,
    this.height = 60,
    this.width = 300,
  }) : super(key: key);
  final String name;
  final Function onTap;
  final Color bgColor;
  final Color textColor;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
      return Flexible(
      child: SizedBox(
        width: width,
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith(
                (states) => Colors.black12,
              ),
            ),
            onPressed: onTap,
            child: Text(
              name,
              style: kButtonText.copyWith(color: textColor),
            ),
          )
        )
      )
    );
  }
}