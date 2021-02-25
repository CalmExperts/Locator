import 'package:flutter/material.dart';
import 'package:locator/resources/dimensions.dart';

class AddDrop extends StatefulWidget {
  @override
  _AddDropState createState() => _AddDropState();
}

class _AddDropState extends State<AddDrop> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                content: Text(
                  "Hold your finger at a specific location to add a drop in the map",
                ),
              );
            },
          );
        },
        child: Container(
          child: IconTheme(
            data: Theme.of(context).iconTheme,
            child: Icon(
              Icons.add,
            ),
          ),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: borderRadius15),
          height: sideBarSize,
          width: double.infinity,
        ),
      ),
      elevation: elevation,
      shape: CircleBorder(),
    );
  }
}
