import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:locator/controllers/contribute_controller.dart';
import 'package:locator/options/widgets/points_row.dart';

class ContributePage extends StatefulWidget {
  @override
  _ContributePageState createState() => _ContributePageState();
}

class _ContributePageState extends State<ContributePage> {
  final controller = GetIt.I.get<ContributeController>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        bool contributeMode = controller.contributeMode;
        print(contributeMode);
        return controller.pageIndex == 1
            ? Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        controller.changeIndex(0);
                      },
                      icon: Icon(Icons.keyboard_arrow_left_sharp),
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                          ),
                        ),
                        Divider(
                          color: Colors.transparent,
                        ),
                        Text("YOU"),
                        SizedBox(
                          height: 50,
                        ),
                        PointsRow(),
                        Divider(
                          color: Colors.transparent,
                        ),
                        Switch(
                          value: contributeMode,
                          onChanged: (value) {
                            _contribute(value);
                          },
                        ),
                        SizedBox(height: 10),
                        Text(contributeMode == false
                            ? "CONTRIBUTE"
                            : "CONTRIBUTING"),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    onPressed: () {
                      controller.changeIndex(1);
                    },
                    child: Text("GET STARTED"),
                  ),
                ],
              );
      },
    );
  }

  _contribute(bool value) {
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser == null) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text("You need to sign into your account to contribute"),
          );
        },
      );
    } else {
      controller.changeToContributeMode(value);
    }
  }
}
