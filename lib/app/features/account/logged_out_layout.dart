import 'package:flutter/material.dart';

class LoggedOutLayout extends StatelessWidget {
  final Function googleSignIn;
  // final Function signIn;

  const LoggedOutLayout({Key key, this.googleSignIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('You are not logged in',
            style: Theme.of(context).textTheme.subtitle1),
        Container(height: 48),
        OutlineButton.icon(
          onPressed: googleSignIn,
          icon: Image.asset('assets/images/google-logo.png',
              height: 40, width: 40),
          label: Text(
            "Log in with Google",
            style: Theme.of(context).textTheme.headline6,
          ),
          borderSide: BorderSide(
            color: Theme.of(context).highlightColor.withOpacity(0.8),
          ),
          textColor: Theme.of(context).highlightColor.withOpacity(0.8),
          highlightedBorderColor:
              Theme.of(context).highlightColor.withOpacity(0.8),
        ),
        // PrimaryButton(
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (_) => MailPassPage(),
        //       ),
        //     );
        //   },
        //   child: Text(
        //     'Mail and Pass',
        //     style: Theme.of(context).textTheme.headline6,
        //   ),
        // ),
      ],
    );
  }
}
