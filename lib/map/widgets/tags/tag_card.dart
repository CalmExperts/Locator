import 'package:flutter/material.dart';
import 'package:locator/map/widgets/controllers/app_controller.dart';

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
            // color: Theme.of(context).dividerColor,
            color: (AppController.instance.isButtonCollor == text
                ? Colors.green[900]
                : Theme.of(context).dividerColor),
            width: 1,
          ),
        ),
        // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Row(
          children: [
            Icon(
              icon,
              color: (AppController.instance.isButtonCollor == text
                  ? Theme.of(context).accentColor
                  : Theme.of(context).disabledColor),
              size: 22,
            ),
            Text(
              // tag,
              text,
              style: TextStyle(
                // color: Colors.green,
                // color: Theme.of(context).dividerColor,
                color: (AppController.instance.isButtonCollor == text
                    ? Colors.green
                    : Colors.grey),
                // color: text == myColorz[0].name
                //     ? Color(myColorz[0].color)
                //     : Colors.grey,
                fontSize: 12,
                fontWeight: (AppController.instance.isButtonCollor == text
                    ? FontWeight.bold
                    : FontWeight.normal),
              ),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
