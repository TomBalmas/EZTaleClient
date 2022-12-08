import 'package:flutter/material.dart';
import '../constants.dart';

class EZEntityTextField extends StatelessWidget {
  const EZEntityTextField(
      {Key key,
      @required this.hintText,
      @required this.inputType,
      @required this.controller,
      this.width = 300,
      this.height = 1,
      this.icon})
      : super(key: key);
  final String hintText;
  final TextInputType inputType;
  final controller;
  final icon;
  final width;
  final height;
  

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          width: width.toDouble(),
          child: TextField(
            controller: controller,
            focusNode: FocusNode(),
            style: kBodyText.copyWith(
              color: Colors.white,
              height: height.toDouble()
            ),
            keyboardType: inputType,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              prefixIcon: icon,
              contentPadding: EdgeInsets.all(20),
              hintText: hintText,
              hintStyle: kBodyText,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(0, 173, 181, 100),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ));
  }
}
