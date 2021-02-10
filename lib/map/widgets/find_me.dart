import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locator/resources/dimensions.dart';

class FindMe extends StatefulWidget {
  final Function(LatLng coordinates) onFindMe;

  const FindMe({Key key, this.onFindMe}) : super(key: key);

  @override
  _FindMeState createState() => _FindMeState();
}

class _FindMeState extends State<FindMe> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
//          widget.onFindMe();
        },
        child: Container(
          child: IconTheme(
            data: Theme.of(context).iconTheme,
            child: Icon(
              Icons.gps_not_fixed,
            ),
          ),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: borderRadius15),
          height: sideBarSize,
          width: double.infinity,
        ),
      ),
      elevation: elevation,
      shape: CircleBorder(),
    );
  }
}
