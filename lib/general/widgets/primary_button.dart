import 'package:flutter/material.dart';
import 'package:locator_app/resources/colors.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color selectedColor;
  final Color borderColor;
  final Color deselectedColor;
  final Widget child;

  const PrimaryButton({
    Key key,
    this.onPressed,
    this.selectedColor = white,
    this.borderColor = darkAccent,
    this.deselectedColor,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: onPressed,
      color: selectedColor,
      child: child,
      borderSide: BorderSide(color: borderColor),
      textColor: borderColor,
      highlightedBorderColor: borderColor,
    );
  }
}
