import 'package:flutter/material.dart';
import 'package:locator_app/auth/route/account_page.dart';
import 'package:locator_app/general/widgets/user_avatar.dart';
import 'package:locator_app/options/widgets/options_item.dart';
import 'package:locator_app/utils/functions.dart';

class OptionsPage extends StatefulWidget {
  @override
  _OptionsPageState createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              OptionsItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Account'),
                    UserAvatar(),
                  ],
                ),
                function: () => navigateTo(context, AccountPage()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
