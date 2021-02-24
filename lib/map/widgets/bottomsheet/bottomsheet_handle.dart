import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:locator/controllers/options_controller.dart';

class BottomSheetHandle extends StatelessWidget {
  const BottomSheetHandle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: 5,
          width: constraints.maxWidth / 7,
          decoration: BoxDecoration(
            color: Colors.yellow[600],
            borderRadius: BorderRadius.circular(4),
          ),
        );
        // );
      },
    );
  }
}
