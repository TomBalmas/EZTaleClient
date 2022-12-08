import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../widgets/Widgets.dart';
import '../widgets/widgets.dart';
import '../constants.dart';
import '../EZNetworking.dart';
import 'Screens.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool passwordVisibility = true;
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController surnameController = new TextEditingController();
  TextEditingController repeatPasswordController = new TextEditingController();
  showAlartDialog(
      BuildContext context, String alt, String desc, Function callback) async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(alt),
        content: Text(desc),
        actions: <Widget>[
          TextButton(
            onPressed: callback,
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image(
            width: 24,
            color: Colors.white,
            image: Svg('assets/back_arrow.svg'),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Register",
                            style: kHeadline,
                          ),
                          Text(
                            "Create new account to get started.",
                            style: kBodyText2,
                          ),
                          SizedBox(height: 50),
                          EZTextField(
                            controller: nameController,
                            hintText: 'Name',
                            inputType: TextInputType.name,
                          ),
                          EZTextField(
                            controller: surnameController,
                            hintText: 'Surname',
                            inputType: TextInputType.name,
                          ),
                          EZTextField(
                            controller: usernameController,
                            hintText: 'Username',
                            inputType: TextInputType.phone,
                          ),
                          EZTextField(
                            controller: emailController,
                            hintText: 'Email',
                            inputType: TextInputType.emailAddress,
                          ),
                          EZPasswordField(
                            controller: passwordController,
                            isPasswordVisible: passwordVisibility,
                            onTap: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                          ),
                          EZPasswordField(
                            controller: repeatPasswordController,
                            isPasswordVisible: passwordVisibility,
                            repeat: true,
                            onTap: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: kBodyText,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Text(
                              "Log In",
                              style: kBodyText.copyWith(color: Colors.white),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    EZTextButton(
                      buttonName: 'Register',
                      onTap: () {
                        if (nameController.text.isEmpty ||
                            surnameController.text.isEmpty ||
                            usernameController.text.isEmpty ||
                            passwordController.text.isEmpty ||
                            repeatPasswordController.text.isEmpty ||
                            emailController.text.isEmpty) {
                          showAlartDialog(
                              context,
                              "Error",
                              "At least one of the fields are missing ",
                              () => Navigator.pop(context, 'OK'));
                          return;
                        }
                        if (usernameController.text.contains('@')) {
                          showAlartDialog(
                              context,
                              "Error",
                              "@ is not valid in Username",
                              () => Navigator.pop(context, 'OK'));
                          return;
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                            .hasMatch(emailController.text)) {
                          showAlartDialog(
                              context,
                              "Error",
                              "Email is not valid",
                              () => Navigator.pop(context, 'OK'));
                          return;
                        }
                        if (passwordController.text !=
                            repeatPasswordController.text) {
                          showAlartDialog(
                              context,
                              "Error",
                              "passwords are not the same",
                              () => Navigator.pop(context, 'OK'));
                          return;
                        }
                        Future<String> res = createUser(
                            nameController.text,
                            surnameController.text,
                            emailController.text,
                            usernameController.text,
                            passwordController.text);
                        res.then((value) {
                          if (value == 'Email is already in use') {
                            showAlartDialog(context, "Error", value,
                                () => Navigator.pop(context, 'OK'));
                            return;
                          } else if (value == 'Username is already in use') {
                            showAlartDialog(context, "Error", value,
                                () => Navigator.pop(context, 'OK'));
                            return;
                          }
                          final data = jsonDecode(value);
                          if (data['success']) {
                            showAlartDialog(
                                context,
                                "Success!",
                                "Welcome to our community " +
                                    nameController.text +
                                    "!",
                                () => Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => LoginScreen())));
                          }
                        });
                      },
                      bgColor: Colors.white,
                      textColor: Colors.black87,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
