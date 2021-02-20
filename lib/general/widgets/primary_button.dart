import 'package:flutter/material.dart';
import 'package:locator/resources/style/colors.dart';

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
      child: child,
      borderSide: BorderSide(
        color: Theme.of(context).highlightColor.withOpacity(0.8),
      ),
      textColor: Theme.of(context).highlightColor.withOpacity(0.8),
      highlightedBorderColor: Theme.of(context).highlightColor.withOpacity(0.8),
    );
  }
}
