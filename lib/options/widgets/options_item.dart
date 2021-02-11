import 'package:flutter/material.dart';

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
                color: Theme.of(context).backgroundColor,
                width: double.infinity,
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
