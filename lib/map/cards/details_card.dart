// import 'package:buffetlocator/app/models/fridge_model.dart';
// import 'package:buffetlocator/app/pages/shared/widgets/tag_chip.dart';
// import 'package:buffetlocator/app/pages/shared/widgets/tags_list.dart';
import 'package:flutter/material.dart';
import 'package:locator/map/models/fridge_model.dart';
// import 'package:buffetlocator/app/pages/shared/widgets/my_list_view.dart';
// import 'package:buffetlocator/app/pages/shared/widgets/square_view.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({this.fridge,});

  final FridgeModel fridge;
  // final double distance;

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(8),
      child: Column(
//        direction: Axis.horizontal,
//        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                padding: const EdgeInsets.all(10),
                child: Icon(Icons.kitchen, size: 40),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fridge.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    // distance > 1
                    //     ? '${distance.toStringAsFixed(2)} km'
                    //     : '${(distance * 1000).floor()} m',
                    // style: TextStyle(fontSize: 12),
                    'xxxx'
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'In : ',
                      style: TextStyle(fontSize: 15),
                      children: <TextSpan>[
                        TextSpan(
                          text: fridge.locationName,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // TagChip(
                  //   label: fridge.open ? 'OPEN' : 'CLOSE',
                  //   color: fridge.open
                  //       ? Colors.lightGreenAccent
                  //       : Colors.redAccent,
                  //   backgroundColor: Colors.transparent,
                  // ),
                  // TagChip(
                  //   label: fridge.hasFood ? 'FULL' : 'EMPTY',
                  //   color: fridge.hasFood
                  //       ? Colors.lightGreenAccent
                  //       : Colors.redAccent,
                  //   backgroundColor: Colors.transparent,
                  // ),
                ],
              )
            ],
          ),
          SizedBox(height: 2),

          // MyList(),
          // SquareView(),
            // Flexible(
            //   child: TagsList(fridge.tags.map((a) => a.toString()).toList())),

          // )
        ],
      ),
    );
  }
}
