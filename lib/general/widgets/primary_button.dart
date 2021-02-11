import 'package:flutter/material.dart';
import 'package:locator/resources/colors.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const PrimaryButton({
    Key key,
    this.child,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: onPressed,
      color: Theme.of(context).highlightColor,
      child: child,
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
      textColor: Theme.of(context).primaryColor,
      highlightedBorderColor: Theme.of(context).primaryColor,
    );
  }
}
