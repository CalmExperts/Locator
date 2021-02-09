import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locator/map/models/category.dart';
import 'package:locator/map/widgets/layered_icon.dart';
import 'package:locator/utils/extensions.dart';

class CategoryIcon extends StatelessWidget {
  final Category category;
  final double size;

  const CategoryIcon({Key key, @required this.category, this.size})
      : assert(category != null),
        super(key: key);

  @override
  Widget build(BuildContext context) =>
      SizedBox(height: size, width: size, child: buildIcon(category.name));

  Widget buildIcon(String categoryName) {
    final icon = categoryIcons[categoryName];
    if (icon != null) {
      if (icon is IconData) {
        return SizedBox(
            child: Icon(
          icon,
          size: size,
        )).expandForFinite(height: 48, width: 48);
      }
      if (icon is List<IconData>) {
        return LayeredIcon<IconData>(
          icon1: icon.first,
          icon2: icon.last,
        );
      }
      throw UnsupportedError('${icon.runtimeType} is not a supported type');
    } else {
      return Center(
        child: Text(
          categoryName.initial,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  static const Map<String, dynamic> categoryIcons = {
    'ATM': Icons.atm,
    'Baby Changing Room': FontAwesomeIcons.baby,
    'Bike': Icons.directions_bike,
    'Bike Parking': [FontAwesomeIcons.biking, Icons.local_parking],
    'Bike Rentals': Icons.directions_bike,
    'Bike Store': [Icons.directions_bike, Icons.store],
    'Car': Icons.directions_car,
    'Car Parking': [Icons.directions_car, Icons.local_parking],
    'Cigarette Disposal': Icons.smoking_rooms,
    'Compost Disposal': FontAwesomeIcons.trash,
    'Drinking Fountain': FontAwesomeIcons.water,
    'Emergency Phone': Icons.phone,
    'Food': Icons.fastfood,
    'Garbage': FontAwesomeIcons.trash,
    'Lost And Found': FontAwesomeIcons.search,
    'Picnic Area': [Icons.fastfood, FontAwesomeIcons.tree],
    'Public Phone': FontAwesomeIcons.phone,
    'Recycle Bin': FontAwesomeIcons.recycle,
    'Recycling': FontAwesomeIcons.recycle,
    'Seating': Icons.event_seat,
    'Smoking Area': Icons.smoking_rooms,
    'Street': Icons.streetview,
    'Taxi Phone': Icons.phone,
    'Taxi Stand': Icons.local_taxi,
    'Washroom': FontAwesomeIcons.tint,
    'Water Fountain': FontAwesomeIcons.tint,
    'Disposal': FontAwesomeIcons.trash,
    'Parking': Icons.local_parking,
    'Filter': FontAwesomeIcons.filter,
  };
}
