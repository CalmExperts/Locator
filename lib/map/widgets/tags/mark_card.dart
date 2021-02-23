import 'package:flutter/material.dart';

class MarkCard extends StatefulWidget {
  final String text;
  final Function onPressed;
  // final IconData icon;

  const MarkCard({
    Key key,
    this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  _MarkCard createState() => _MarkCard();
}

class _MarkCard extends State<MarkCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 15.0),
      child: FlatButton(
        height: 45,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
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
              widget.text == 'OUTDOOR'
                  ? Icons.sensor_door_outlined
                  : Icons.sensor_door,
              color: Theme.of(context).dividerColor,
              size: 22,
            ),
            Container(
              height: 05,
            ),
            Text(
              // tag,
              widget.text,
              style: TextStyle(
                color: Theme.of(context).dividerColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}
