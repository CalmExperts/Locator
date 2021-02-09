import 'package:flutter/material.dart';
import 'package:locator/map/models/category.dart';
import 'package:locator/map/widgets/category_container.dart';
import 'package:locator/map/widgets/category_icon.dart';
import 'package:locator/resources/colors.dart';
import 'package:locator/resources/dimensions.dart';

//const double size = 60;

class CategoryBalloon extends StatefulWidget {
  final Category category;
  final VoidCallback onPressed;
  final bool isActive;
  final double size;

  const CategoryBalloon({
    Key key,
    @required this.category,
    @required this.onPressed,
    @required this.isActive,
    @required this.size,
  }) : super(key: key);

  @override
  _CategoryBalloonState createState() => _CategoryBalloonState();
}

class _CategoryBalloonState extends State<CategoryBalloon>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
//  Animation<Color> _balloonAnimation;
//  Animation<Color> _childAnimation;
  double containerWidth = 0;

  @override
  void initState() {
//    _controller = AnimationController(vsync: this, duration: animationDuration)
//      ..addListener(() {
//        setState(() {
//          containerWidth = _controller
//              .value;
//        });
//      });
//    _balloonAnimation =
//        ColorTween(begin: locatorTheme.buttonColor, end: darkAccent)
//            .animate(_controller);
//    _childAnimation =
//        ColorTween(begin: primaryText, end: locatorTheme.buttonColor)
//            .animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
//    _controller.dispose();
    super.dispose();
  }

  double get size => widget.size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: CategoryContainer(
        icon: CategoryIcon(size: isCategory ? 40 : 48, category: category),
        label: category.name,
        width: size * 1.5 + containerWidth,
        margin: isCategory ? EdgeInsets.all(5) : null,
        decoration: BoxDecoration(
          borderRadius: widget.category.level == CategoryLevel.top
              ? borderRadius15
              : null,
          border: widget.isActive
              ? Border.all(color: darkAccent, width: 1.5)
              : null,
          shape: isCategory ? BoxShape.circle : BoxShape.rectangle,
        ),
        onTap: widget.onPressed,
      ),
    );
  }

  bool get isCategory => category.level == CategoryLevel.category;

  Category get category => widget.category;

  void animate() {
    print('selected ${widget.isActive}');
    print('category $category');
//    print('chosen ${widget.chosen}');
//    widget.chosen == widget.category ? _controller.forward() : _controller.reverse();
  }
}
