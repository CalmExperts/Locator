import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locator/map/bloc/map_bloc.dart';
import 'package:locator/map/models/category.dart';
import 'package:locator/map/widgets/add_drop.dart';
import 'package:locator/map/widgets/category_bar.dart';
import 'package:locator/map/widgets/edit_card/subcategory_scroll_view.dart';
import 'package:locator/map/widgets/find_me.dart';
import 'package:locator/map/widgets/map_background.dart';
import 'package:locator/map/widgets/options.dart';
import 'package:locator/resources/dimensions.dart';
import 'package:locator/resources/theme_changer.dart';

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

  getCameraPosition() async {
    // return await locationService.getCameraPosition();
    await Geolocator.getCurrentPosition().then((value) {
      setState(() {
        cameraPosition = CameraPosition(
          target: LatLng(
            value.latitude,
            value.longitude,
          ),
          zoom: 15.0,
        );
      });

      _updateMarker(value.latitude, value.longitude);

      _goToTheMarker(value.latitude, value.longitude);
    });
  }

  Future<void> _goToTheMarker(double targetLat, double targetLong) async {
    final GoogleMapController controller = await _controller.future;
    setState(() {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(targetLat, targetLong), zoom: 20),
        ),
      );
    });
  }

  void _updateMarker(double latitude, double longitude) {
    setState(() {
      _markers.clear();

      final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(latitude, longitude),
        icon: BitmapDescriptor.defaultMarker,
      );

      _markers.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget separator = Container(height: 12);
    return Container(
      // color: Colors.yellow,
      //-----------

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
          AddDrop(),
          separator,
          FindMe(
            onFindMe: () {
              getCameraPosition();
            },
          ),
          separator,
          Options(), //hamburguer menu
        ],
      ),
    );
  }
}
