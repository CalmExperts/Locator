import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locator_app/auth/auth.dart';
import 'package:locator_app/auth/route/account_page.dart';
import 'package:locator_app/map/bloc/map_bloc.dart';
import 'package:locator_app/map/models/coordinates.dart';
import 'package:locator_app/map/models/drop.dart';
import 'package:locator_app/map/services/drop_service.dart';
import 'package:locator_app/map/widgets/drop_card.dart';
import 'package:locator_app/map/widgets/edit_card/bloc/card_bloc.dart';
import 'package:locator_app/map/widgets/edit_card/create_card.dart';
import 'package:locator_app/map/widgets/loading_failed.dart';
import 'package:locator_app/resources/dimensions.dart';
import 'package:locator_app/resources/enums.dart';
import 'package:locator_app/utils/dialog.dart';
import 'package:locator_app/utils/exceptions.dart';
import 'package:locator_app/utils/functions.dart' show navigateTo;
import 'package:provider/provider.dart';

typedef ShowBottomSheet = PersistentBottomSheetController Function(
    {@required Widget content});

class MapBackground extends StatefulWidget {
  static GlobalKey<MapBackgroundState> mapBackgroundKey = GlobalKey();

  const MapBackground({@required Key key}) : super(key: key);

  @override
  MapBackgroundState createState() => MapBackgroundState();

  static ShowBottomSheet get showBottomSheet =>
      mapBackgroundKey.currentState.showBottomSheet;
  static PersistentBottomSheetController get persistentBottomSheetController =>
      mapBackgroundKey.currentState.bottomSheetController;
}

class MapBackgroundState extends State<MapBackground> {
  GoogleMapController mapController;

  Drop tappedDrop;
  bool displayCard = false;
  LatLng newDropPosition;
  Widget _cardContent;

  Widget get cardContent {
    if (mapBloc.state.isCardOpen) {
      return _cardContent;
    }
    return null;
  }

  set cardContent(Widget cardContent) {
    _cardContent = cardContent;
  }

  CardBloc get cardBloc => CardBloc.of(context);
  final mapKey = GlobalKey();
  PersistentBottomSheetController bottomSheetController;

  MapBloc get mapBloc => MapBloc.of(context);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      buildWhen: (oldState, newState) {
        return (oldState.activeTopCategory != newState.activeTopCategory ||
                oldState.activeCategory != newState.activeCategory ||
                oldState.activeSubcategory != newState.activeSubcategory) &&
            !newState.isCardOpen;
      },
      builder: (BuildContext context,
          MapState latestStateThatHasANewCategorySelection) {
        return StreamBuilder<List<Drop>>(
          key: GlobalKey(),
          stream: Provider.of<DropService>(context)
              .fetch(latestStateThatHasANewCategorySelection.activeCategory),
          builder: (context, snapshot) {
            if (mapBloc.state is MapInitial) {
              return LoadingWidget(
                errorMessage: 'Please check your internet connection',
                errorIcon: Icon(
                  Icons.signal_cellular_connected_no_internet_4_bar,
                  size: 70,
                ),
              );
              // shows because drop service returns null while category is null.
              // change to show all drops within a certain distance.
            }
            final data = snapshot.data ?? [];

            return GoogleMap(
              key: mapKey,
              compassEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(43.66665970807569, -79.38109528273344),
                zoom: 16,
              ),
              markers: Set.from([
                for (final drop in data)
                  if (drop.coordinates != null)
                    Marker(
                      markerId: MarkerId(drop.id),
                      alpha: drop.isDraft ? 0.5 : 1.0,
                      onTap: () {
                        debugPrint(drop.toString());
                        if (drop.isDraft) {
                          cardBloc
                            ..reset()
                            ..add(SetDrop(drop));
                          _showEditDropCard();
                        } else {
                          tappedDrop = drop;
                          _showViewDropCard();
                        }
                      },
                      position: LatLng(
                        drop.coordinates.latitude,
                        drop.coordinates.longitude,
                      ),
                    ),
              ]),
              myLocationButtonEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  mapController = controller;
                });
              },
              onLongPress: (LatLng position) async {
                var currentUser =
                    Provider.of<Auth>(context, listen: false).currentUser;
                if (currentUser == null) {
                  showAlertDialog(context, 'You are not logged in', [
                    'Whatever!',
                    'Login'
                  ], [
                    () => Navigator.pop(context),
                    () {
                      Navigator.pop(context);
                      navigateTo(context, AccountPage());
                    },
                  ]);
                } else {
                  newDropPosition = position;
                  cardBloc.reset();
                  cardBloc.add(
                    UpdateDrop(
                      coordinates: Coordinates.fromLatLng(position),
                      topCategory: mapBloc.state.activeTopCategory,
                      category: mapBloc.state.activeCategory,
                      subcategory: mapBloc.state.activeSubcategory,
                      isDraft: true,
                      addedBy: Provider.of<Auth>(context, listen: false)
                          .currentUser
                          .documentReference,
                    ),
                  );
                  _showEditDropCard();
//                  });
                }
              },
            );
          },
        );
      },
    );
  }

  void _showViewDropCard() {
    var sheet = showBottomSheet(
        content: ViewDropCard(
      drop: tappedDrop,
      onClose: () {
        displayCard = false;
      },
    ));
    sheet.closed.then(
      (value) => mapBloc.add(
        ChangeCardOpenState(isCardOpen: false),
      ),
    );
  }

  void _showEditDropCard() {
    bottomSheetController = showBottomSheet(
      content: CreateDropCard(
        position: newDropPosition,
        initialPage: _getInitialPage(cardBloc.state.drop),
        close: () {
          bottomSheetController.close();
          return bottomSheetController.closed;
        },
      ),
    );
    mapBloc.add(ChangeCardOpenState(isCardOpen: true));
  }

  PersistentBottomSheetController showBottomSheet({@required Widget content}) {
    cardContent = content;
    return Scaffold.of(context).showBottomSheet(
      (context) => content,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(angleBorderRadius),
          topRight: Radius.circular(angleBorderRadius),
        ),
      ),
    )..closed.then(
        (value) {
          mapBloc.add(
            ChangeCardOpenState(isCardOpen: false),
          );
        },
      );
  }

  EditDropCardPage _getInitialPage(Drop drop) {
    assert(drop != null);
    if (drop.category == null) {
      return EditDropCardPage.category;
    }
    if (drop.location == null) {
      return EditDropCardPage.location;
    }
    if (drop.condition == null) {
      return EditDropCardPage.category;
    }
    if (drop.open == null) {
      return EditDropCardPage.location;
    }
    if (drop.isDraft) {
      return EditDropCardPage.summary;
    }
    throw InvalidDataException(
        'We should not be here. Drop is in an incomplete state yet the data is complete.');
  }
}
