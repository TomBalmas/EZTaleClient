import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../widgets/widgets.dart';
import '../constants.dart';
import '../EZNetworking.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool passwordVisibility = true;
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();


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
                          SizedBox(
                            height: 50
                          ),
                          EZTextField(
                            controller: nameController,
                            hintText: 'Name',
                            inputType: TextInputType.name,
                          ),
                           EZTextField(
                            controller: nameController,
                            hintText: 'Surname',
                            inputType: TextInputType.name,
                          ),
                          EZTextField(
                            controller: emailController,
                            hintText: 'Email',
                            inputType: TextInputType.emailAddress,
                            
                          ),
                          EZTextField(
                            controller: phoneController,
                            hintText: 'Phone',
                            inputType: TextInputType.phone,
                          ),
                          EZPasswordField(
                            controller: passwordController,
                            isPasswordVisible: passwordVisibility,
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
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Log In",
                            style: kBodyText.copyWith(
                              color: Colors.white
                            ),
                          )
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    EZTextButton(
                      buttonName: 'Register',
                      onTap: () {
                        Future<String> res = createUser(nameController.text, emailController.text,
                            phoneController.text, passwordController.text);
                        print(res);
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