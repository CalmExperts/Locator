import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locator/app/controllers/map_controller.dart';
import 'package:locator/app/shared/resources/dimensions.dart';

import 'map_background.dart';
import 'widgets/find_me.dart';
import 'widgets/options.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final mapController = GetIt.I.get<MapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(children: <Widget>[
              MapBackground(
                key: MapBackground.mapBackgroundKey,
              ),
              Positioned(
                right: padding,
                bottom: padding,
                child: AnimatedOpacity(
                  duration: animationDuration,
                  opacity: mapController.isCardOpen ? 0.0 : 1.0,
                  child: SideBar(),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class SideBar extends StatefulWidget {
  const SideBar({
    Key key,
  }) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  CameraPosition cameraPosition;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  Set<Marker> _markers = new Set<Marker>();

  @override
  Widget build(BuildContext context) {
    Widget separator = Container(height: 12);
    return Container(
      // color: Colors.yellow,
      //-----------

      width: sideBarSize,
      child: Column(
        children: <Widget>[
          // BlocBuilder<MapBloc, MapState>(
          //   builder: (BuildContext context, MapState state) {
          //     return CategoryBar(
          //       activeTopCategory: state.activeTopCategory,
          //       activeCategory: state.activeCategory,
          //       topCategories: state.topCategories,
          //       categories: state.categories,
          //       onChange: ({
          //         Category activeCategory,
          //         CategoryBarStep currentStep,
          //         Category topCategory,
          //       }) async {
          //         if (currentStep ==
          //                 CategoryBarStep.closedTopCategoryAndCategory &&
          //             activeCategory.hasChildren) {
          //           MapBloc mapBloc = MapBloc.of(context);
          //           PersistentBottomSheetController controller;
          //           ShowCard showCardEvent = ShowCard(
          //             content: SubcategoryScrollView.alwaysExpanded(
          //               category: activeCategory,
          //               onSubcategorySelected: (Subcategory subcategory) async {
          //                 mapBloc.add(SetActiveSubcategory(subcategory));

          //                 // 👇🏾 necessary because for some reason, the new state was set
          //                 // out of order and the cardIsOpen was being reverted.
          //                 await mapBloc.firstWhere(
          //                     (state) => state.activeSubcategory != null);

          //                 controller.close();
          //               },
          //             ),
          //           );
          //           mapBloc.add(showCardEvent);
          //           controller = await showCardEvent.controllerCompleter.future;
          //         }
          //       },
          //     );
          //   },
          // ),
          separator,
          FindMe(
            onFindMe: () {},
          ),
          separator,
          Options(),
        ],
      ),
    );
  }
}
