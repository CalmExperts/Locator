import 'package:flutter/material.dart';

class TagCard extends StatelessWidget {
  final String text;
  final Function onPressed;
  final IconData icon;

  const TagCard({Key key, this.text, this.onPressed, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 26.0),
      child: FlatButton(
        height: 45,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
          side: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
        // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).disabledColor,
              size: 22,
            ),
            Text(
              // tag,
              text,
              style: TextStyle(
                color: Theme.of(context).dividerColor,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
