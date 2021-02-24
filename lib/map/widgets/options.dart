import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:locator/controllers/options_controller.dart';
import 'package:locator/map/widgets/bottomsheet/bottomsheet_widget.dart';
import 'package:locator/options/routes/options_page.dart';
import 'package:locator/resources/dimensions.dart';

class Options extends StatefulWidget {
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final optionsController = GetIt.I.get<OptionsController>();

  // (if pushed, this commit will... (explicação) )

  // git c "tag list and tag card" -m "- the card is blue" -m "- the other card is yellw"
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
          showBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => BottomSheetWidget(),
          ).closed.whenComplete(() {
            optionsController.optionSelected = false;
          });
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
