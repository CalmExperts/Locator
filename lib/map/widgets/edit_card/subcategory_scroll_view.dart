import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:locator_app/map/models/category.dart';
import 'package:locator_app/map/services/category_service.dart';
import 'package:locator_app/map/widgets/edit_card/subcategory_tile.dart';
import 'package:locator_app/resources/colors.dart';
import 'package:locator_app/resources/dimensions.dart';

class SubcategoryScrollView extends StatefulWidget {
  final Category category;
  final Function(Subcategory subcategory) onSubcategorySelected;
  final bool isExpanded;
  final Subcategory subcategoryWhenCollapsed;

  /// If dense is true, cards will be small. For use inside a smaller widget. Set
  /// this to true for larger, full screen uses.
  final bool dense;

  const SubcategoryScrollView({
    Key key,
    @required this.category,
    @required this.onSubcategorySelected,
    @required this.isExpanded,
    @required this.subcategoryWhenCollapsed,
    this.dense = true,
  })  : assert(dense != null),
        super(key: key);

  const SubcategoryScrollView.alwaysExpanded({
    @required this.category,
    @required this.onSubcategorySelected,
  })  : isExpanded = true,
        subcategoryWhenCollapsed = null,
        dense = false;

  @override
  _SubcategoryScrollViewState createState() => _SubcategoryScrollViewState();
}

class _SubcategoryScrollViewState extends State<SubcategoryScrollView> {
  double animatedContainerWidth = 100;
  Completer isAnimatingCompleter;
  bool showCollapsed;

  bool get isAnimating => isAnimatingCompleter.isCompleted;

  Future animateOpen() {
    isAnimatingCompleter = Completer();
    setState(() {
      animatedContainerWidth = 200;
    });
    return isAnimatingCompleter.future;
  }

  Future animateClosed() {
    isAnimatingCompleter = Completer();

    setState(() {
      animatedContainerWidth = 100;
    });
    return isAnimatingCompleter.future;
  }

  @override
  void initState() {
    showCollapsed = widget.isExpanded;
    super.initState();
  }

  @override
  void didUpdateWidget(SubcategoryScrollView oldWidget) {
    if (oldWidget.isExpanded != widget.isExpanded) {
      if (widget.isExpanded) {
        animateOpen().then((value) => setState(() {
              showCollapsed = false;
            }));
      } else {
        animateClosed().then((value) => setState(() {
              showCollapsed = true;
            }));
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Subcategory>>(
        future: GetIt.I
            .get<CategoryService>()
            .getSubcategoriesFromCategory(widget.category),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Subcategory> subcategories = snapshot.data;
            if (widget.dense) {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.white),
                    right: BorderSide(color: Colors.white),
                    top: BorderSide(color: grayBorder),
                    bottom: BorderSide(color: grayBorder),
                  ) /*border: Border.symmetric(
                    vertical: BorderSide(color: Colors.white),
                    horizontal: BorderSide(color: grayBorder),
                  )*/
                  ,
                ),
                child: showCollapsed && widget.subcategoryWhenCollapsed != null
                    ? SubcategoryTile(
                        subcategory: widget.subcategoryWhenCollapsed,
                        margin: EdgeInsets.symmetric(horizontal: 3),
                        onTap: () => widget.onSubcategorySelected(
                          widget.subcategoryWhenCollapsed,
                        ),
                      )
                    : AnimatedContainer(
                        duration: animationDuration,
                        width: animatedContainerWidth,
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: <Widget>[
                            for (final subcategory in subcategories)
                              SubcategoryTile(
                                subcategory: subcategory,
                                margin: EdgeInsets.symmetric(horizontal: 3),
                                onTap: () =>
                                    widget.onSubcategorySelected(subcategory),
                              )
                          ],
                        ),
                        onEnd: () => isAnimatingCompleter.complete(),
                      ),
              );
            } else {
              return SizedBox(
                height: 200,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                  scrollDirection: Axis.horizontal,
                  itemCount: subcategories.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Subcategory subcategory = subcategories[index];
                    return AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        height: 200,
//                        margin: EdgeInsets.only(bottom: 30),
                        child: SubcategoryTile(
                          iconSize: 100,
                          subcategory: subcategory,
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          onTap: () =>
                              widget.onSubcategorySelected(subcategory),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
          return Container();
        });
  }
}
