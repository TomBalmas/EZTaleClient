import 'dart:convert';
import 'package:ez_tale/main.dart';
import 'package:ez_tale/utils/AppModel.dart';
import 'package:ez_tale/widgets/Widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../EZNetworking.dart';
import 'Screens.dart';


// Uses full-screen breakpoints to reflow the widget tree
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    // Reflow from Row to Col when in Portrait mode
    bool useVerticalLayout = screenSize.width < screenSize.height;
    // Hide an optional element if the screen gets too small.
    bool hideDetailPanel = screenSize.shortestSide < 250;
    return Scaffold(
      body: Flex(
          direction: useVerticalLayout ? Axis.vertical : Axis.horizontal,
          children: [
            if (hideDetailPanel == false) ...[
              Flexible(child: _LoginDetailPanel()),
            ],
            Flexible(child: _LoginForm()),
          ]),
    );
  }
}

class _LoginDetailPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        color: Color.fromRGBO(57, 62, 70, 100),
        child: Text(
          "EZTale\nThe easy way\nTo tale.",
          style: TextStyle(fontSize: 64, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      );
}

class _LoginForm extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<_LoginForm> {
  var encoder = JsonEncoder();
  bool isPasswordVisible = true;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordContoller = new TextEditingController();

  showAlertDiaglog(
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

  @override
  Widget build(BuildContext context) {
    // When login button is pressed, show the Dashboard page.
    void handleLoginPressed() => context.read<AppModel>().login();

    // Example Form, pressing the login button will show the Dashboard page
    return Center(
      // Use a maxWidth so the form is responsive, but does get not too large on
      // bigger screens
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 450),
        // Very small screens may require vertical scrolling of the form
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                EZTextField(
                  icon: Icon(Icons.account_circle),
                  controller: emailController,
                  hintText: 'Email / Username',
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                EZPasswordField(
                    icon: Icon(Icons.password),
                    controller: passwordContoller,
                    isPasswordVisible: isPasswordVisible,
                    onTap: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    }),
                SizedBox(height: 16),
                EZTextButton(
                  buttonName: 'Login',
                  onTap: () {
                    //backdoor: email 1 password 1
                    if (emailController.text == '1' &&
                        passwordContoller.text == '1') {
                      MyApp.userManager.setCurrentUser('1', '1');
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => HomeScreen(
                                    booksList:
                                        MyApp.userManager.getUserStoriesList(),
                                  )));
                      return;
                    }
                    // check empty conditions
                    if (emailController.text.isEmpty ||
                        passwordContoller.text.isEmpty) {
                      showAlertDiaglog(
                          context,
                          "Error",
                          "One or more fields are empty",
                          () => Navigator.pop(context, 'OK'));
                      return;
                    }
                    // check auth on server
                    var res =
                        authUser(emailController.text, passwordContoller.text);
                    res.then((value) {
                      final data = jsonDecode(value);
                      if (data['success']) {
                        MyApp.userManager
                            .setCurrentUser(data['username'], data['token']);
                        showAlertDiaglog(
                            context,
                            "User Connected",
                            "User ${emailController.text} Has Connected Successfully!",
                            () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => HomeScreen(
                                          booksList: MyApp.userManager
                                              .getUserStoriesList(),
                                        ))));
                      } else {
                        showAlertDiaglog(
                            context,
                            "Error",
                            "Email / Username or password are not correct",
                            () => Navigator.pop(context, 'OK'));
                      }
                    });
                  },
                  bgColor: Color.fromRGBO(0, 173, 181, 100),
                  textColor: Colors.black87,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: EZTextButton(
                      buttonName: 'Register',
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      bgColor: Color.fromRGBO(0, 173, 181, 100),
                      textColor: Colors.black87,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration _getTextDecoration(String hint) =>
    InputDecoration(border: OutlineInputBorder(), hintText: hint);
