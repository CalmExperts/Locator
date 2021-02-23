import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, String title,
    List<String> actionHeaders, List<Function> actions) {
  if (Platform.isIOS) {
    showDialog(
      context: context,
      builder: (context) {
        var buttons = <Widget>[];
        for (var i = 0; i < actionHeaders.length; ++i) {
          Widget action = CupertinoDialogAction(
            child: Text(actionHeaders[i]),
            onPressed: actions[i],
          );
          buttons.add(action);
        }
        return CupertinoAlertDialog(
          title: Text(title, style: Theme.of(context).textTheme.headline6),
          actions: buttons,
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        var buttons = <Widget>[];
        for (var i = 0; i < actionHeaders.length; ++i) {
          Widget action = FlatButton(
            child: Text(actionHeaders[i]),
            onPressed: actions[i],
          );
          buttons.add(action);
        }
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(title, style: Theme.of(context).textTheme.headline6),
          actions: buttons,
        );
      },
    );
  }
}
