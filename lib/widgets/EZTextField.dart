import 'package:flutter/material.dart';
import '../constants.dart';

class EZTextField extends StatelessWidget {
  const EZTextField(
      {Key key,
      @required this.hintText,
      @required this.inputType,
      @required this.controller})
      : super(key: key);
  final String hintText;
  final TextInputType inputType;
  final controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          width: 500,
          child: TextField(
            controller: controller,
            style: kBodyText.copyWith(color: Colors.white),
            keyboardType: inputType,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: hintText,
              hintStyle: kBodyText,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ));
  }
}
