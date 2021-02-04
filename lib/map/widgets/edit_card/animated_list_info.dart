import 'package:flutter/material.dart';

class AnimatedListInfo extends StatefulWidget {
  @override
  _AnimatedListInfoState createState() => _AnimatedListInfoState();
}

class _AnimatedListInfoState extends State<AnimatedListInfo> {
  List items = [0, 1, 2];
  bool isExpanded = true;
  static const double containerHeight = 100;

  var duration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration,
      height: containerHeight * (isExpanded ? 3 : 1),
      child: AnimatedList(
        shrinkWrap: true,
        initialItemCount: items.length,
        itemBuilder:
            (BuildContext context, int index, Animation<double> animation) {
          return SlideTransition(
            position:
                animation.drive(Tween(begin: Offset(0, 1), end: Offset(0, 0))),
            child: FlatButton(
              child: AnimatedOpacity(
                opacity: opacity(index),
                duration: duration,
                child: buildContainer(index),
              ),
              onPressed: () {
                if (isExpanded) {
                  AnimatedList.of(context)
                    ..removeItem(
                        index,
                        (context, animation) => Opacity(
                              opacity: animation.value,
                              child: buildContainer(index),
                            ))
                    ..insertItem(0);
                  setState(() {
                    var value = items.removeAt(index);
                    items.insert(0, value);
                    isExpanded = false;
                  });
                } else {
                  setState(() {
                    isExpanded = true;
                  });
                }
              },
            ),
          );
        },
      ),
    );
  }

  Container buildContainer(int index) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(color: Colors.red, border: Border.all()),
      child: Text(
        items[index].toString(),
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  double opacity(int index) {
    if (isExpanded || index == 0) {
      return 1.0;
    } else {
      return 0;
    }
  }
}
