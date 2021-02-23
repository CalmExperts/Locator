import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoggedInLayout extends StatelessWidget {
  final Function logout;
  final User user;

  const LoggedInLayout({Key key, this.logout, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 200,
          backgroundColor: Theme.of(context).primaryColor,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // UserAvatar(radius: 120),
                  Container(
                    child: Text(
                      user.displayName,
                      style: TextStyle(color: Colors.white, fontSize: 32),
                    ),
                  )
                ],
              ),

              // Column(
              //   padding: const EdgeInsets.only(bottom: 0),
              //   child:
              // ),
            ),
          ),
        ),
        SliverFillRemaining(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: logout,
                child: Text(
                  "LOGOUT",
                ),
              ),
              // OptionsItem(
              //   child: Text(
              //     '-LOGOUT-',
              //     style: Theme.of(context).textTheme.headline6,
              //   ),
              //   function: logout,
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
