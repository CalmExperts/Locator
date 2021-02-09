import 'package:flutter/material.dart';
import 'package:locator/resources/colors.dart';

class OptionsItem extends StatelessWidget {
  final Function function;
  final Widget child;

  const OptionsItem({Key key, this.function, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Material(
            child: InkWell(
              onTap: function,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: darkAccent))),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
