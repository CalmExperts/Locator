import 'package:flutter/material.dart';

class CustomDialog {
  final BuildContext context;
  final String title;
  final String content;
  final bool dismissible;
  final String buttonText;
  final Function onPressed;
  CustomDialog(
      {this.context,
      this.title,
      this.dismissible,
      this.content,
      this.buttonText,
      this.onPressed});

  show() async {
    return await showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Theme.of(context).accentColor,
          title: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          content: Text(
            content,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            RaisedButton(
              onPressed: onPressed,
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }
}
