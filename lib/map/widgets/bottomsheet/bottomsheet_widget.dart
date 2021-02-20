import 'package:flutter/material.dart';
import 'package:locator/map/widgets/tags_list.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({Key key}) : super(key: key);

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class BottomSheetHandle extends StatelessWidget {
  const BottomSheetHandle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        margin: EdgeInsets.only(top: 15),
        height: 5,
        width: constraints.maxWidth / 7,
        decoration: BoxDecoration(
          color: Theme.of(context).dividerColor,
          borderRadius: BorderRadius.circular(4),
        ),
      );
    });
  }
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  int spacerFlex = 3;
  double bottomSheetHeight = 125;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      // color: Colors.black,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),

      alignment: Alignment.topCenter,
      duration: Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      height: bottomSheetHeight,
      child: GestureDetector(
        onVerticalDragUpdate: onVerticalDragUpdate,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: 125,
              // width: MediaQuery.of(context).size.width,
              // decoration: BoxDecoration(
              //   // color: Theme.of(context).primaryColor,
              //   // color: Colors.red,
              //   color: Colors.transparent,
              //   borderRadius: BorderRadius.circular(15),
              // ),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Spacer(flex: spacerFlex),
                      Expanded(child: BottomSheetHandle()),
                      Spacer(
                        flex: spacerFlex,
                      ),
                    ],
                  ),

                  Flexible(
                      // child: TagsList(fridge.tags.map((a) => a.toString()).toList())),
                      child: TagsList()),
                  // widget.child,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  onVerticalDragUpdate(DragUpdateDetails details) {
    print(bottomSheetHeight);
    print(details.delta.dy);

    if (details.delta.dy > 1) {
      bottomSheetHeight = 125;
    } else if (details.delta.dy < 1) {
      bottomSheetHeight = 400;
    }

    // if (details.delta.dy < -2.5) {
    //   bottomSheetHeight = 400;
    // }
    setState(() {});
  }
}

class DecoratedTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration:
            InputDecoration.collapsed(hintText: 'Enter your reference number'),
      ),
    );
  }
}

class SheetButton extends StatefulWidget {
  SheetButton({Key key}) : super(key: key);

  _SheetButtonState createState() => _SheetButtonState();
}

class _SheetButtonState extends State<SheetButton> {
  bool checkingFlight = false;
  bool success = false;

  @override
  Widget build(BuildContext context) {
    return !checkingFlight
        ? MaterialButton(
            color: Colors.grey[800],
            onPressed: () async {
              setState(() {
                checkingFlight = true;
              });

              await Future.delayed(Duration(seconds: 1));

              setState(() {
                success = true;
              });

              await Future.delayed(Duration(milliseconds: 500));

              Navigator.pop(context);
            },
            child: Text(
              'Check Flight',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        : !success
            ? CircularProgressIndicator()
            : Icon(
                Icons.check,
                color: Colors.green,
              );
  }
}
