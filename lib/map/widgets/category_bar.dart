import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:locator/map/bloc/map_bloc.dart';
import 'package:locator/map/models/category.dart';
import 'package:locator/map/widgets/category_button.dart';
import 'package:locator/map/widgets/edit_card/category_balloon.dart';
import 'package:locator/map/widgets/flexible_container.dart';
import 'package:locator/resources/dimensions.dart';
import 'package:locator/utils/extensions.dart';

typedef CategoryBarOnChange = void Function({
  @required CategoryBarStep currentStep,
  @required Category topCategory,
  @required Category activeCategory,
});

class CategoryBar extends StatefulWidget {
  final Category activeCategory;
  final Category activeTopCategory;
  final Axis scrollDirection;
  final List<Category> topCategories;
  final List<Category> categories;
  final CategoryBarStep initialState;
  final CategoryBarOnChange onChange;

//  onChange

  const CategoryBar({
    Key key,
    @required this.activeCategory,
    @required this.activeTopCategory,
    @required this.topCategories,
    @required this.categories,
    this.initialState = CategoryBarStep.closedTopCategory,
    this.scrollDirection = Axis.vertical,
    this.onChange,
  }) : super(key: key);

  CategoryBar.fromMapState({
    Key key,
    MapState mapState,
    this.scrollDirection = Axis.vertical,
    this.initialState = CategoryBarStep.closedTopCategory,
    this.onChange,
  })  : topCategories = mapState.topCategories,
        activeTopCategory = mapState.activeTopCategory,
        activeCategory = mapState.activeCategory,
        categories = mapState.categories,
        super(key: key);

  @override
  CategoryBarState createState() => CategoryBarState();
}

class CategoryBarState extends State<CategoryBar>
    with SingleTickerProviderStateMixin {
  final double collapsedSize = sideBarSize * 1.75;
  double currentSize;

  bool isAnimating = false;
  CategoryBarStep _currentStep;

  CategoryBarStep get currentStep => _currentStep;

  set currentStep(CategoryBarStep value) {
    _currentStep = value;
    CategoryBarStateNotification(step: value, isCollapsed: drawerIsCollapsed)
        .dispatch(context);
    if (widget.onChange != null) {
      widget.onChange(
        activeCategory: activeCategory,
        currentStep: currentStep,
        topCategory: activeTopCategory,
      );
    }
  }

  Category get activeTopCategory => widget.activeTopCategory;

  Category get activeCategory => widget.activeCategory;

  bool get drawerIsCollapsed =>
      [
        CategoryBarStep.closedTopCategory,
        CategoryBarStep.closedTopCategoryAndCategory,
        CategoryBarStep.closedCategory
      ].contains(currentStep) &&
      !isAnimating;

  MapBloc get mapBloc => MapBloc.of(context);

  bool get isVertical => widget.scrollDirection == Axis.vertical;

  bool get isHorizontal => !isVertical;

  void initState() {
    super.initState();
    currentStep = widget.initialState ?? CategoryBarStep.closedTopCategory;
    currentSize = _getInitialCurrentSize();
  }

  double _getInitialCurrentSize() {
    if (currentStep == CategoryBarStep.closedTopCategoryAndCategory) {
      return _getClosedSize(2);
    } else {
      return collapsedSize;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius15,
      child: AnimatedContainer(
        duration: animationDuration,
        height: widget.scrollDirection == Axis.vertical ? currentSize : null,
        width: widget.scrollDirection == Axis.horizontal ? currentSize : null,
        decoration: rectangleDecoration(context: context),
        child: buildChild(),
      ),
      elevation: isVertical ? elevation : 0,
    );
  }

  Widget buildChild({int height}) {
    switch (currentStep) {
      case CategoryBarStep.closedTopCategory:
        {
          return CategoryButton.filter(onTap: openTopCategories);
        }
      case CategoryBarStep.openTopCategory:
        return FlexibleScrollableContainer(
          scrollDirection: widget.scrollDirection,
          maxHeight: isVertical
              ? MediaQuery.of(context).size.height / 3
              : double.infinity,
          builder: (BuildContext context, BoxConstraints constraints) {
            List<Category> sortedCategoryList = widget.topCategories
                .withElementAsFirst(widget.activeTopCategory);
            return Flex(
              direction: widget.scrollDirection,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                for (final category in sortedCategoryList)
                  getCategoryButtonType(
                    category: category,
                    isActive: false,
                    onTap: (category) {
                      setActiveTopCategory(category);
                      closeTopCategory(category);
                    },
                  )
              ],
            );
          },
        );
        break;
      case CategoryBarStep.closedCategory:
        final shouldOpenCategories = widget.categories.isNotEmpty;

        if (shouldOpenCategories) {
          openCategories();
        }
        return getCategoryButtonType(
          category: widget.activeTopCategory,
          isActive: true,
          onTap: (_) => openTopCategories(),
        );

      case CategoryBarStep.openCategory:
        void onTap(Category category) {
          setActiveCategory(category);
          closeActiveCategory(category);
        }

        void reopenTopCategories() async {
          await close(numberOfIcons: 1);
          openTopCategories();
          setActiveTopCategory(null);
        }

        return Flex(
          direction: widget.scrollDirection,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (isHorizontal) // place activeTopCategoryButton at the beginning
              Expanded(
                child: CategoryBalloon(
                  category: widget.activeTopCategory,
                  isActive: true,
                  onPressed: () => reopenTopCategories(),
                  size: 60,
                ),
              ),
            Expanded(
              child: FlexibleScrollableContainer(
                scrollDirection: widget.scrollDirection,
                maxHeight: MediaQuery.of(context).size.height / 4,
                builder: (BuildContext context, BoxConstraints constraints) {
                  List<Category> sortedCategoryList = widget.categories
                      .withElementAsFirst(widget.activeCategory);
                  return Flex(
                    direction: widget.scrollDirection,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      for (final category in sortedCategoryList)
                        getCategoryButtonType(
                          category: category,
                          isActive: false,
                          onTap: (_) => onTap(category),
                        )
                    ],
                  );
                },
              ),
            ),
            if (isVertical)
              CategoryButton(
                widget.activeTopCategory,
                isActive: true,
                onTap: reopenTopCategories,
              ),
          ],
        );
      case CategoryBarStep.closedTopCategoryAndCategory:
        return Flex(
          direction: widget.scrollDirection,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            if (isVertical)
              getCategoryButtonType(
                category:
                    // category
                    widget.activeCategory,
                isActive: true,
                onTap: (_) {
                  resetActiveCategory();
                  openCategories();
                },
              ),
            getCategoryButtonType(
              category:
                  // top category
                  widget.activeTopCategory,
              isActive: true,
              onTap: (_) {
                resetActiveTopCategory();
                resetActiveCategory();

                openTopCategories();
              },
            ),
            if (isHorizontal)
              getCategoryButtonType(
                category:
                    // category
                    widget.activeCategory,
                isActive: true,
                onTap: (_) {
                  resetActiveCategory();
                  openCategories();
                },
              ),
          ],
        );
        break;
      default:
        throw UnsupportedError('ERROR in CategoryBarState');
    }
  }

  void resetActiveTopCategory() => mapBloc.add(SetActiveTopCategory(null));

  void resetActiveCategory() => mapBloc.add(SetActiveCategory(null));

  EdgeInsets buildPadding({@required int index, @required int listLength}) {
    bool isFirst = index == 0;
    bool isLast = index == listLength - 1;
    const top = 8.0;
    const bottom = 8.0;
    return EdgeInsets.only(
        top: !isFirst ? top : 0, bottom: !isLast ? bottom : 0);
  }

  Future<double> _animateTo(double to) async {
    if (mounted) {
      debugPrint('Animating to $to');
      setState(() {
        currentSize = to;
        isAnimating = true;
      });
    }

    await Future.delayed(animationDuration);
    if (mounted) {
      setState(() => isAnimating = false);
    } else {
      isAnimating = false;
    }
    return currentSize;
  }

  Future<double> expand({@required int numberOfIcons}) {
    assert(numberOfIcons > 0, 'You must have at least one category showing.');
    double finalSize = _getOpenedSize(numberOfIcons);

    return _animateTo(finalSize);
  }

  Future<double> close({@required int numberOfIcons}) {
    double finalSize = _getClosedSize(numberOfIcons);

    assert(numberOfIcons > 0, 'You must have at least one category showing.');
    return _animateTo(finalSize);
  }

  bool getIsActive(Category category) =>
      category.level == CategoryLevel.top &&
      category == widget.activeTopCategory;

  Future<void> openTopCategories() {
    currentStep = CategoryBarStep.openTopCategory;
    setActiveTopCategory(null);
    return expand(numberOfIcons: widget.topCategories.length);
  }

  Future closeTopCategory(Category category) async {
    await close(numberOfIcons: 1);
    setState(() {
      currentStep = CategoryBarStep.closedCategory;
    });
  }

  Future openCategories() {
    setState(() => currentStep = CategoryBarStep.openCategory);
    return expand(numberOfIcons: widget.categories.length + 1);
    // add one to account for the selected top category
  }

  Future<void> closeActiveCategory(Category category) async {
    await close(numberOfIcons: 2);
    currentStep = CategoryBarStep.closedTopCategoryAndCategory;
  }

  void setActiveTopCategory(Category category) =>
      mapBloc.add(SetActiveTopCategory(category));

  void setActiveCategory(Category category) =>
      mapBloc.add(SetActiveCategory(category));

  Widget getCategoryButtonType({
    @required Category category,
    @required Function(Category) onTap,
    @required bool isActive,
  }) {
    if (widget.scrollDirection == Axis.vertical) {
      return CategoryButton(
        category,
        isActive: isActive,
        onTap: () => onTap(category),
      );
    } else {
      return CategoryBalloon(
        category: category,
        isActive: isActive,
        onPressed: () => onTap(category),
        size: 60,
      );
    }
  }

  double _getClosedSize(int numberOfIcons) {
    if (isVertical) {
      return numberOfIcons * (categoryButtonSize + 2);
    } else {
      return numberOfIcons * (categoryBalloonSize + 8);
    }
  }

  double _getOpenedSize(int numberOfIcons) {
    if (isVertical) {
      return numberOfIcons * categoryButtonSize;
    } else {
      return numberOfIcons * categoryBalloonSize;
    }
  }
}

enum CategoryBarStep {
  closedTopCategory,
  openTopCategory,
  closedCategory,
  openCategory,
  closedTopCategoryAndCategory
}

class CategoryBarStateNotification extends Notification {
  final CategoryBarStep step;
  final bool isCollapsed;

  CategoryBarStateNotification(
      {@required this.step, @required this.isCollapsed});
}
