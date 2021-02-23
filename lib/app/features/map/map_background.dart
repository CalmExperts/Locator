import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locator/app/models/drop.dart';

class MapBackground extends StatefulWidget {
  static GlobalKey<MapBackgroundState> mapBackgroundKey = GlobalKey();

  const MapBackground({@required Key key}) : super(key: key);

  @override
  MapBackgroundState createState() => MapBackgroundState();
}

class MapBackgroundState extends State<MapBackground> {
  CameraPosition cameraPosition;
  GoogleMapController mapController;
  final mapKey = GlobalKey();

  // final contributeController = GetIt.I.get<ContributeController>();

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
    });
  }

  @override
  void initState() {
    super.initState();
    getCameraPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final data = List<Drop>();

        if (cameraPosition == null) {
          return Container(
            color: Theme.of(context).backgroundColor,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
              ),
            ),
          );
        }
        return GoogleMap(
          zoomControlsEnabled: false,
          key: mapKey,
          compassEnabled: true,
          initialCameraPosition: cameraPosition,
          myLocationButtonEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            setState(() {
              mapController = controller;
            });
            // _activateMapDarkMode();
            _activateMapDarkMode();
          },
          markers: Set.from([for (final drop in data) {}]),
        );
      },
    );
  }

  _activateMapDarkMode() {
    getJsonForMapMode('assets/map_dark_mode.json').then(setMapStyle);
  }

  Future<String> getJsonForMapMode(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    mapController.setMapStyle(mapStyle);
  }
}
