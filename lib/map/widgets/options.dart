import 'package:flutter/material.dart';
import 'package:locator/map/widgets/bottomsheet/bottomsheet_widget.dart';
import 'package:locator/options/routes/options_page.dart';
import 'package:locator/resources/dimensions.dart';

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
              // builder: (context) => BottomSheetWidget());
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
