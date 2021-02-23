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
    final optionsController = GetIt.I.get<OptionsController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Observer(builder: (_) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 5,
            width: constraints.maxWidth / 7,
            decoration: BoxDecoration(
              color: optionsController.isColorActive == false
                  ? Theme.of(context).dividerColor
                  : Colors.yellow[600],
              borderRadius: BorderRadius.circular(4),
            ),
          );
        });
        // );
      },
    );
  }
}
