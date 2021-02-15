import 'package:flutter/material.dart';
import 'package:locator/resources/style/colors.dart';

class Star extends StatelessWidget {
  final bool pressed;
  final int index;
  final Function onPressed;

  const Star({this.index, this.pressed, this.onPressed});

  @override
  Widget build(BuildContext context) {
    Color color = pressed ? Colors.amber : Theme.of(context).primaryColor;
    IconData iconData = pressed ? Icons.star : Icons.star_border;
    return IconButton(
      icon: Transform.translate(
        offset: Offset(-5, -5),
        child: IconTheme(
          data: Theme.of(context).iconTheme,
          child: Icon(iconData, color: color, size: 42),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
