import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:locator/controllers/options_controller.dart';
import 'package:locator/options/routes/contribute_page.dart';

import '../tags/tags_list.dart';
import 'bottomsheet_handle.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({Key key}) : super(key: key);

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget>
    with TickerProviderStateMixin {
  final optionsController = GetIt.I.get<OptionsController>();
  AnimationController _controller;

  int spacerFlex = 3;
  double bottomSheetHeight;
  bool valor = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      bool isColorActive = optionsController.isColorActive;
      return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return AnimatedContainer(
              // color: Colors.black,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),

              alignment: Alignment.topCenter,
              duration: Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              height: isColorActive == false ? 120 : 315,

              child: GestureDetector(
                onVerticalDragUpdate: onVerticalDragUpdate,
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Container(
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

                          Container(
                            height: isColorActive == false
                                ? 80 //CERTO!!!!!!!!!!!!!!
                                : 280,
                            child: ListView(
                              physics: NeverScrollableScrollPhysics(),
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Flexible(
                                      // child: TagsList(fridge.tags.map((a) => a.toString()).toList())),
                                      child: TagsList(),
                                    ),
                                    Column(
                                      children: [
                                        ContributePage(),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )

                          // widget.child,
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    });
  }

  onVerticalDragUpdate(DragUpdateDetails details) {
    if (optionsController.isModalActive == true) {
      if (details.delta.dy > 2.5) {
        bottomSheetHeight = 125;
      } else if (details.delta.dy < 2.5) {
        bottomSheetHeight = 400;
      }
    }

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
              setState(
                () {
                  checkingFlight = true;
                },
              );
              await Future.delayed(Duration(seconds: 1));
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
                color: Theme.of(context).indicatorColor,
              );
  }
}
