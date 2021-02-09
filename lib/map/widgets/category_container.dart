import 'package:flutter/material.dart';
import 'package:locator/resources/colors.dart';

class CategoryContainer extends StatelessWidget {
  final Widget icon;
  final String label;
  final TextStyle labelStyle;
  final BoxDecoration decoration;

  final EdgeInsets margin;

  final double width;

  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const CategoryContainer({
    Key key,
    @required this.icon,
    @required this.label,
    this.labelStyle,
    @required this.margin,
    @required this.width,
    this.decoration,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: margin,
        width: width,
        decoration: decoration,
        child: FlatButton(
          padding: EdgeInsets.zero,
          splashColor: disabled,
          onPressed: onTap,
          onLongPress: onLongPress,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: icon,
              ),
              Container(height: 8),
              Center(
                child: Text(
                  label,
                  style: labelStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
