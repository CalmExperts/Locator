import 'package:flutter/material.dart';
import 'package:locator/auth/route/account_page.dart';
import 'package:locator/general/widgets/user_avatar.dart';
import 'package:locator/options/widgets/options_item.dart';
import 'package:locator/utils/functions.dart';

class OptionsPage extends StatefulWidget {
  @override
  _OptionsPageState createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              OptionsItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Account',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
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
