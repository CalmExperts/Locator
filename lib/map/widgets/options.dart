import 'package:flutter/material.dart';
import 'package:locator/map/widgets/bottomsheet/bottomsheet_widget.dart';
import 'package:locator/options/routes/options_page.dart';
import 'package:locator/resources/dimensions.dart';
import 'package:locator/resources/style/colors.dart';

class Options extends StatefulWidget {
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius15,
      child: InkWell(
        onTap: () {
          var sheetController = showBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => BottomSheetWidget());
        },
        child: Container(
          child: IconTheme(
            data: Theme.of(context).iconTheme,
            child: Icon(Icons.menu),
          ),
          height: sideBarSize,
          width: double.infinity,
        ),
      ),
      color: Theme.of(context).primaryColor,
      // color: Colors.blue,
      elevation: elevation,
    );
  }
}

void _onButtonPressed(BuildContext context) {
  var sheetController = showBottomSheet(
    context: context,
    builder: (context) => Container(
      margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
      height: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 125,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.grey[300],
                  spreadRadius: 5,
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
  sheetController.closed.then(
    (value) {
      print('closed modal');
    },
  );

  // showModalBottomSheet(context: context, builder: (context){

  //      const EdgeInsets _dropCardPadding =
  //     EdgeInsets.symmetric(horizontal: 8, vertical: 10);

  //     return Container(
  //       // margin: EdgeInsets.only(top: 15),

  //     margin: _dropCardPadding,
  //       // height: 40,

  //     width: MediaQuery.of(context).size.width * .25,
  //     height: MediaQuery.of(context).size.width * .25,

  //       // width: 100,
  //       // width: constraints.maxWidth / 7,
  //       decoration: BoxDecoration(

  //         color: Colors.blue,
  //         // color: Theme.of(context).accentColor,
  //

  //         borderRadius: BorderRadius.circular(4),
  //       ),
  //     );
  // });
}
