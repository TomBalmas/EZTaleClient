import 'package:flutter/material.dart';
import '../constants.dart';

class EZPasswordField extends StatelessWidget {
  const EZPasswordField(
      {Key key,
      @required this.isPasswordVisible,
      @required this.onTap,
      @required this.controller,
      this.repeat: false,
      this.icon})
      : super(key: key);
  final bool isPasswordVisible;
  final Function onTap;
  final controller;
  final bool repeat;
  final icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          width: 500,
          child: TextField(
            controller: controller,
            style: kBodyText.copyWith(
              color: Colors.white,
            ),
            obscureText: isPasswordVisible,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              prefixIcon: icon,
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: onTap,
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Color.fromRGBO(0, 173, 181, 100),
                  ),
                ),
              ),
              contentPadding: EdgeInsets.all(20),
              hintText: repeat ? 'Repeat Password' : 'Password',
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
