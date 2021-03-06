import 'package:flutter/material.dart';
import 'package:locator_app/map/models/category.dart';
import 'package:locator_app/map/widgets/category_container.dart';
import 'package:locator_app/map/widgets/category_icon.dart';
import 'package:locator_app/resources/colors.dart';
import 'package:locator_app/resources/dimensions.dart';

class SubcategoryTile extends StatelessWidget {
  final Subcategory subcategory;
  final EdgeInsets margin;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final double iconSize;

  const SubcategoryTile({
    Key key,
    @required this.subcategory,
    this.margin,
    this.onTap,
    this.onLongPress,
    this.iconSize,
  })  : assert(subcategory != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CategoryContainer(
      icon: CategoryIcon(
        category: subcategory,
        size: iconSize,
      ),
      label: subcategory.name,
      labelStyle: TextStyle(color: darkAccent, fontWeight: FontWeight.bold),
      margin: margin,
      width: 100,
      decoration: lightGrayRoundedRectangleDecoration,
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
