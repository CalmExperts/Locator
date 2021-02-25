import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:locator/controllers/options_controller.dart';
import 'package:locator/map/widgets/tags/tag_card.dart';
import 'package:locator/options/routes/contribute_page.dart';
import 'package:locator/options/routes/options_page.dart';

import '../tags/tags_list.dart';
import '../update_page.dart';
import 'bottomsheet_handle.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({Key key}) : super(key: key);

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget>
    with TickerProviderStateMixin {
  final optionsController = GetIt.I.get<OptionsController>();
  static const EdgeInsets _dropCardPadding =
      EdgeInsets.symmetric(horizontal: 8, vertical: 10);

  int spacerFlex = 3;
  double bottomSheetHeight;
  bool valor = false;

  List<Widget> pages;
  int currentView = 0;

  @override
  void initState() {
    super.initState();

    pages = [
      mainPage(),
      updatePage(),
      contributePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        optionsController.isModalActive = false;
        Navigator.pop(context);
        return;
      },
      child: Observer(
        builder: (_) {
          return Container(
            height: optionsController.optionSelected == true ? 500 : 145,
            child: Card(
              color: Theme.of(context).primaryColorDark,
              margin: _dropCardPadding,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  optionsController.optionSelected == true
                      ? Container()
                      : Row(
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
                    child: Center(
                      child: pages[currentView],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  mainPage() {
    return Container(
      height: 100,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        children: [
          TagCard(
            text: ' OPTIONS',
            icon: Icons.settings,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OptionsPage(),
                ),
              );
            },
          ),
          TagCard(
            text: ' UPDATE',
            description: "v1.0",
            icon: Icons.update,
            onPressed: () {
              optionsController.optionSelected = true;
              setState(() {
                currentView = 1;
              });
            },
          ),
          TagCard(
            text: ' CONTRIBUTE',
            description: "Earn points",
            icon: Icons.point_of_sale,
            onPressed: () {
              optionsController.optionSelected = true;
              setState(() {
                currentView = 2;
              });
            },
          ),
          TagCard(
            text: ' CAN\'T FIND SOMETHING?',
            description: "Try Google Maps",
            icon: Icons.warning,
            onPressed: () {},
          ),
          TagCard(
            text: ' DONATE',
            description: "Remove ads",
            icon: Icons.monetization_on_sharp,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  updatePage() {
    return UpdatePage();
  }

  contributePage() {
    return ContributePage();
  }

  // onVerticalDragUpdate(DragUpdateDetails details) {
  //   if (details.delta.dy > 2.5) {
  //     optionsController.optionSelected = false;
  //     Navigator.pop(context);
  //   }

  //   // else if (details.delta.dy < 2.5) {
  //   //   optionsController.optionSelected = true;
  //   // }
  // }
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
