import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:locator/resources/style/colors.dart';

const double padding = 16;
const EdgeInsets dropCardInternalPadding = EdgeInsets.fromLTRB(15, 0, 15, 15);
BorderRadius borderRadius15 = BorderRadius.circular(7);
const double sideBarSize = 48;
const double angleBorderRadius = 30;
const double greatBorderRadius = sideBarSize / 2;
const double elevation = 4;
const double sidebar = 4;
const double greatIconSize = 96;
const Duration animationDuration = Duration(milliseconds: 300);
const double categoryButtonSize = 48.0;
const double categoryBalloonSize = 90.0;
BoxDecoration rectangleDecoration({BuildContext context}) {
  return BoxDecoration(
    borderRadius: borderRadius15,
    color: Theme.of(context).primaryColor,
    border: Border.all(color: Theme.of(context).primaryColor, width: 2.5),
  );
}
