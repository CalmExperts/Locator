import 'package:flutter/material.dart';
import 'package:locator_app/map/models/category.dart';
import 'package:locator_app/map/widgets/category_icon.dart';
import 'package:locator_app/resources/colors.dart';
import 'package:locator_app/resources/dimensions.dart';

class CategoryButton extends StatefulWidget {
  final Category category;
  final Color activeColor;
  final Color inactiveColor;
  final bool isActive;
  final VoidCallback onTap;
  final bool _isFilter;

  const CategoryButton(
    this.category, {
    Key key,
    this.activeColor = darkAccent,
    this.inactiveColor = Colors.white,
    this.onTap,
    @required this.isActive,
  })  : _isFilter = false,
        assert(category != null),
        assert(isActive != null),
        super(key: key);

  const CategoryButton.filter({@required this.onTap})
      : category = const Category.constant(
          name: 'Filter',
          tags: {},
          documentReference: null,
          childrenCategories: [],
          description: null,
          level: CategoryLevel.top,
        ),
        activeColor = darkAccent,
        inactiveColor = Colors.white,
        isActive = false,
        _isFilter = true;

  @override
  _CategoryButtonState createState() => _CategoryButtonState();

  bool isEqualTo(CategoryButton other) =>
      identical(this, other) ||
      super == other &&
          other is CategoryButton &&
          runtimeType == other.runtimeType &&
          category == other.category &&
          activeColor == other.activeColor &&
          inactiveColor == other.inactiveColor &&
          isActive == other.isActive;
}

class _CategoryButtonState extends State<CategoryButton> {
  @override
  void initState() {
    super.initState();
    if (widget._isFilter) {
//      assert(MapBloc.of(context).state.activeCategory == null);
//      assert(MapBloc.of(context).state.activeTopCategory == null);
    }
  }

  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Tooltip(
        message: widget.category.name,
        child: Container(
          margin: widget.category.level == CategoryLevel.category
              ? EdgeInsets.symmetric(horizontal: 5)
              : null,
          decoration: BoxDecoration(
            borderRadius: widget.category.level == CategoryLevel.top
                ? borderRadius15
                : null,
            border: widget.isActive ? Border.all(color: darkAccent) : null,
            shape: widget.category.level == CategoryLevel.category
                ? BoxShape.circle
                : BoxShape.rectangle,
          ),
          child: InkWell(
            splashColor: disabled,
            child: CategoryIcon(category: widget.category),
            onTap: widget.onTap,
          ),
        ),
      ),
    );
  }
}
