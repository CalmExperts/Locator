import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:locator/controllers/options_controller.dart';

class TagCard extends StatefulWidget {
  final String text;
  final Function onPressed;
  final IconData icon;

  const TagCard({Key key, this.text, this.onPressed, this.icon})
      : super(key: key);

  @override
  _TagCardState createState() => _TagCardState();
}

class _TagCardState extends State<TagCard> {
  final optionsController = GetIt.I.get<OptionsController>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 26.0),
        child: FlatButton(
          height: 45,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(
              // color: Theme.of(context).dividerColor,
              color: (optionsController.buttonColor == widget.text
                  ? Colors.green[900]
                  : Theme.of(context).dividerColor),
              width: 1,
            ),
          ),
          // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: (optionsController.buttonColor == widget.text
                    ? Theme.of(context).accentColor
                    : Theme.of(context).disabledColor),
                size: 22,
              ),
              Text(
                // tag,
                widget.text,
                style: TextStyle(
                  // color: Colors.green,
                  // color: Theme.of(context).dividerColor,
                  color: (optionsController.buttonColor == widget.text
                      ? Colors.green
                      : Colors.grey),
                  // color: text == myColorz[0].name
                  //     ? Color(myColorz[0].color)
                  //     : Colors.grey,
                  fontSize: 12,
                  fontWeight: (optionsController.buttonColor == widget.text
                      ? FontWeight.bold
                      : FontWeight.normal),
                ),
              ),
            ],
          ),
          onPressed: widget.onPressed,
        ),
      );
    });
  }
}
