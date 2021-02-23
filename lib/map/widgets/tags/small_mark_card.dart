import 'package:flutter/material.dart';

class SmallMarkCard extends StatefulWidget {
  final String text;
  final Function onPressed;
  final IconData icon;

  const SmallMarkCard({Key key, this.text, this.onPressed, this.icon})
      : super(key: key);

  @override
  _SmallMarkCard createState() => _SmallMarkCard();
}

class _SmallMarkCard extends State<SmallMarkCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
      child: FlatButton(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
        height: 65,
        minWidth: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
          side: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              widget.icon,
              color: Theme.of(context).dividerColor,
              size: 26,
            ),
          ],
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}
