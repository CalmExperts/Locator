import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  CameraPosition cameraPosition;

  getCameraPosition() async {
    await Geolocator.getCurrentPosition().then((value) {
      cameraPosition = CameraPosition(
        target: LatLng(
          value.latitude,
          value.longitude,
        ),
        zoom: 15.0,
      );
    });
  }
}
