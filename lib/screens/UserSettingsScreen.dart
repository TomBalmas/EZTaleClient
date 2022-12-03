import 'package:ez_tale/main.dart';
import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import '../widgets/Widgets.dart';

class UserSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title = 'lol';
    var url = 'lol2';
    return Scaffold(
        drawer: EZDrawer(),
        appBar: AppBar(title: Text('book1')),
        body: CardSettings(children: <CardSettingsSection>[
          CardSettingsSection(
            header: CardSettingsHeader(
              label: 'Favorite Book',
            ),
            children: <CardSettingsWidget>[
              CardSettingsText(
                label: 'Title',
                initialValue: title,
                // ignore: missing_return
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Title is required.';
                },
                onSaved: (value) => title = value,
              ),
              CardSettingsText(
                label: 'URL',
                initialValue: url,
                // ignore: missing_return
                validator: (value) {
                  if (!value.startsWith('http:'))
                    return 'Must be a valid website.';
                },
                onSaved: (value) => url = value,
              ),
            ],
          ),
        ]));
  }
}
