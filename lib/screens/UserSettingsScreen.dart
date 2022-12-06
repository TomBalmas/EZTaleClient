import 'package:ez_tale/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import '../widgets/Widgets.dart';
import 'Screens.dart';

// ignore: must_be_immutable
class UserSettingsScreen extends StatelessWidget {
  TextEditingController deleteTextController = new TextEditingController();
  bool _toDel = false;

  void _checkToDel() {
    _toDel = deleteTextController.text == 'DELETE';
  }

  void showAcceptDiaglog(
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

  void showAlartDialog(BuildContext context, String alt, String desc,
      Function delete_func, Function cancel_func) async {
    showDialog<String>(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text(alt),
              content: Text(desc),
              actions: <Widget>[
                TextFormField(
                  controller: deleteTextController,
                  onChanged: (text) {
                    setState(() {
                      _checkToDel();
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: TextButton(
                    key: Key('textDel'),
                    onPressed: _toDel ? delete_func : null,
                    child: const Text('Delete'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    deleteTextController.text = '';
                    cancel_func();
                  },
                  child: const Text('Cancel'),
                )
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    var name = MyApp.userManager.getCurrentName();
    var surname = MyApp.userManager.getCurrentSurname();
    var email = MyApp.userManager.getCurrentEmail();

    return Scaffold(
        drawer: EZDrawer(),
        appBar: AppBar(title: Text('User Settings')),
        body: CardSettings(children: <CardSettingsSection>[
          CardSettingsSection(
            header: CardSettingsHeader(
              label: MyApp.userManager.getCurrentUsername() + ' Settings',
            ),
            children: <CardSettingsWidget>[
              CardSettingsText(
                icon: Icon(Icons.account_circle_rounded),
                label: 'Name',
                initialValue: name,
                // ignore: missing_return
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Name is required.';
                },
                onSaved: (value) => name = value,
              ),
              CardSettingsText(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Surname',
                initialValue: surname,
                // ignore: missing_return
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Surname is required.';
                },
                onSaved: (value) => surname = value,
              ),
              CardSettingsEmail(
                icon: Icon(Icons.email),
                label: 'Email',
                initialValue: email,
                // ignore: missing_return
                validator: (value) {
                  if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                          .hasMatch(value) ||
                      value == null) return 'Email is not valid.';
                },
                onSaved: (value) => email = value,
              ),
              CardSettingsPassword(
                icon: Icon(Icons.password),
                label: 'Password',
                initialValue: 'initialPassword',
              ),
              CardSettingsButton(
                label: 'Save Settings',
                backgroundColor: Colors.green,
                textColor: Colors.white,
                onPressed: () => {},
              ),
              CardSettingsButton(
                  label: 'Delete User',
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  onPressed: () {
                    showAlartDialog(
                        context, 'Delete?', 'Enter "DELETE" to delete user.',
                        () {
                      MyApp.userManager.deleteCurrentUser().then(
                        (value) {
                          if (value) {
                            showAcceptDiaglog(context, 'User Deleted!',
                                'User has been deleted', () {
                              MyApp.userManager.logout();
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            });
                          } else
                            showAcceptDiaglog(
                                context,
                                'User Not Deleted!',
                                'User NOT deleted',
                                () => Navigator.pop(context));
                        },
                      );
                    }, () => Navigator.pop(context));
                  }),
              CardSettingsButton(
                label: 'Return',
                textColor: Colors.white,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ]));
  }
}
