import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Coordinates extends LatLng {
//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Coordinates({
    @required double latitude,
    @required double longitude,
  })  : assert(latitude != null),
        assert(longitude != null),
        super(latitude, longitude);

  @override
  bool operator ==(Object o) =>
      identical(this, o) ||
      (o is Coordinates &&
          runtimeType == o.runtimeType &&
          latitude == o.latitude &&
          longitude == o.longitude);

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;

  @override
  String toString() {
    return 'Coordinates{'
        ' latitude: $latitude,'
        ' longitude: $longitude,'
        '}';
  }

  Coordinates copyWith({
    double latitude,
    double longitude,
  }) {
    return Coordinates(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Coordinates.fromLatLng(LatLng latLng)
      : super(
          latLng.latitude,
          latLng.longitude,
        );

  Map<String, dynamic> toMap() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  factory Coordinates.fromJson(Map json) {
    if (json == null) {
      return null;
    }
    return Coordinates(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }

//</editor-fold>
}
