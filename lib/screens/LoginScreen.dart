import 'package:ez_tale/utils/AppModel.dart';
import 'package:ez_tale/widgets/Widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/EZTextField.dart';
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
      body: Flex(direction: useVerticalLayout ? Axis.vertical : Axis.horizontal, children: [
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
    color: Colors.grey.shade300,
    child: Text(
      "EZTale\nThe easy way\nTo tale.",
      style: TextStyle(fontSize: 64),
      textAlign: TextAlign.center,
    ),
  );
}

class _LoginForm extends StatefulWidget {

  @override
  _LoginScreenState createState()  => _LoginScreenState();
}

class _LoginScreenState extends State<_LoginForm> {
  bool isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    // When login button is pressed, show the Dashboard page.
    void handleLoginPressed() => context.read<AppModel>().login();

    // Example Form, pressing the login button will show the Dashboard page
    return Center(
      // Use a maxWidth so the form is responsive, but does get not too large on bigger screens
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 450),
        // Very small screens may require vertical scrolling of the form
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                EZTextField(
                  hintText: 'Email',
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                EZPasswordField(
                    isPasswordVisible: isPasswordVisible,
                    onTap: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    }
                ),
                SizedBox(height: 16),
                EZTextButton(
                  buttonName: 'Login',
                  onTap: () {
                    //TODO: add auth with server 

                    Navigator.push(context,CupertinoPageRoute(
                            builder: (context) => HomeScreen()));
                  },
                  bgColor: Colors.white,
                  textColor: Colors.black87,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: EZTextButton(
                    buttonName: 'Register',
                    onTap: () { Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => RegisterScreen()));
                      },
                    bgColor: Colors.white,
                    textColor: Colors.black87,
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );


  }
}

InputDecoration _getTextDecoration(String hint) => InputDecoration(border: OutlineInputBorder(), hintText: hint);