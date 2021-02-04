import 'package:flutter/material.dart';

/// A container that will size itself to it's children but will scroll
/// if there isn't enough space to lay them out with the provided space.
/// it returns the layout constraints as extra data
class FlexibleScrollableContainer extends StatelessWidget {
  final double maxHeight;
  final double maxWidth;
  final LayoutWidgetBuilder builder;
  final ScrollPhysics physics;
  final Axis scrollDirection;

  const FlexibleScrollableContainer({
    Key key,
    this.maxHeight = double.infinity,
    this.maxWidth = double.infinity,
    this.physics,
    @required this.scrollDirection,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maxHeight,
        maxWidth: maxWidth,
      ),
      child: SingleChildScrollView(
          scrollDirection: scrollDirection,
          physics: physics,
          child: LimitedBox(
            maxHeight: scrollDirection == Axis.vertical
                ? MediaQuery.of(context).size.height / 2
                : double.infinity,
            maxWidth: double.infinity,
            child: LayoutBuilder(
              builder: builder,
            ),
          )),
    );
  }
}
