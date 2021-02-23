import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:locator/controllers/contribute_controller.dart';

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
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Switch(
                          value: contributeMode,
                          onChanged: (value) {
                            controller.changeToContributeMode(value);
                          },
                        ),
                        Text(
                          contributeMode == false
                              ? "CONTRIBUTE"
                              : "CONTRIBUTING",
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
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
}
