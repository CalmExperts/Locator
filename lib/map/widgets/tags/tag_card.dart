import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:locator/controllers/options_controller.dart';

class TagCard extends StatefulWidget {
  final String text;
  final String description;
  final Function onPressed;
  final IconData icon;

  const TagCard(
      {Key key, this.text, this.onPressed, this.icon, this.description})
      : super(key: key);

  @override
  _TagCardState createState() => _TagCardState();
}

class _TagCardState extends State<TagCard> {
  final optionsController = GetIt.I.get<OptionsController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 26.0),
      child: FlatButton(
        height: 40,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
          side: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
        child: Center(
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: Theme.of(context).disabledColor,
                size: 22,
              ),
              Text(
                widget.text,
                style: TextStyle(
                  color: Theme.of(context).disabledColor,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}
