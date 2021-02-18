import 'package:flutter/material.dart';

class TagItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onPressed;

  const TagItem({Key key, this.text, this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
      child: FlatButton(
        height: 45,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
          side: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
