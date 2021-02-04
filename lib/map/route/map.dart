import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locator_app/map/bloc/map_bloc.dart';
import 'package:locator_app/map/models/category.dart';
import 'package:locator_app/map/widgets/category_bar.dart';
import 'package:locator_app/map/widgets/edit_card/subcategory_scroll_view.dart';
import 'package:locator_app/map/widgets/find_me.dart';
import 'package:locator_app/map/widgets/map_background.dart';
import 'package:locator_app/map/widgets/options.dart';
import 'package:locator_app/resources/dimensions.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with SingleTickerProviderStateMixin {
  ValueChanged<Category> onCategoryChanged;
  bool buildSideBar = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                MapBackground(
                  key: MapBackground.mapBackgroundKey,
                ),
                Positioned(
                  right: padding,
                  bottom: padding,
                  child: BlocBuilder<MapBloc, MapState>(
                    builder: (context, state) {
                      return AnimatedOpacity(
                        duration: animationDuration,
                        opacity: state.isCardOpen ? 0.0 : 1.0,
                        child: SideBar(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SideBar extends StatelessWidget {
  const SideBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget separator = Container(height: 12);
    return Container(
      width: sideBarSize,
      child: Column(
        children: <Widget>[
          BlocBuilder<MapBloc, MapState>(
            builder: (BuildContext context, MapState state) {
              return CategoryBar(
                activeTopCategory: state.activeTopCategory,
                activeCategory: state.activeCategory,
                topCategories: state.topCategories,
                categories: state.categories,
                onChange: ({
                  Category activeCategory,
                  CategoryBarStep currentStep,
                  Category topCategory,
                }) async {
                  if (currentStep ==
                          CategoryBarStep.closedTopCategoryAndCategory &&
                      activeCategory.hasChildren) {
                    MapBloc mapBloc = MapBloc.of(context);
                    PersistentBottomSheetController controller;
                    ShowCard showCardEvent = ShowCard(
                      content: SubcategoryScrollView.alwaysExpanded(
                        category: activeCategory,
                        onSubcategorySelected: (Subcategory subcategory) async {
                          mapBloc.add(SetActiveSubcategory(subcategory));

                          // 👇🏾 necessary because for some reason, the new state was set
                          // out of order and the cardIsOpen was being reverted.
                          await mapBloc.firstWhere(
                              (state) => state.activeSubcategory != null);

                          controller.close();
                        },
                      ),
                    );
                    mapBloc.add(showCardEvent);
                    controller = await showCardEvent.controllerCompleter.future;
                  }
                },
              );
            },
          ),
          separator,
          FindMe(
            onFindMe: (LatLng coordinates) {},
          ),
          separator,
          Options(),
        ],
      ),
    );
  }
}
