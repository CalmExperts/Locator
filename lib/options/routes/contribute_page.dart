import 'package:flutter/material.dart';

class ContributePage extends StatefulWidget {
  @override
  _ContributePageState createState() => _ContributePageState();
}

class _ContributePageState extends State<ContributePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blueAccent,
        ),
        Divider(
          color: Colors.transparent,
        ),
        Text(
          "Join the fun community of contributos and earn points",
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
        Divider(
          color: Colors.transparent,
        ),
        RaisedButton(
          onPressed: () {},
          child: Text("GET STARTED"),
        ),
      ],
    );
  }
}
