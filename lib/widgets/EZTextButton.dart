import 'package:flutter/material.dart';
import '../constants.dart';

class EZTextButton extends StatelessWidget {
  const EZTextButton({
    Key key,
    @required this.buttonName,
    @required this.onTap,
    @required this.bgColor,
    @required this.textColor,
  }) : super(key: key);
  final String buttonName;
  final Function onTap;
  final Color bgColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 500,
        child: Container(
            height: 60,
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
                buttonName,
                style: kButtonText.copyWith(color: textColor),
              ),
            )));
  }
}
