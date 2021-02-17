import 'package:flutter/material.dart';
import 'package:locator/map/models/category.dart';
import 'package:locator/map/widgets/category_container.dart';
import 'package:locator/map/widgets/category_icon.dart';
import 'package:locator/resources/style/dark_colors.dart';
import 'package:locator/resources/dimensions.dart';

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
      labelStyle: TextStyle(
          color: Theme.of(context).highlightColor, fontWeight: FontWeight.bold),
      margin: margin,
      width: 100,
      decoration: rectangleDecoration(context: context),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
