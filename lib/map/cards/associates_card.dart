import 'package:buffetlocator/app/models/fridge_model.dart';

import 'package:flutter/material.dart';

class AssociatesCard extends StatelessWidget {
  const AssociatesCard({this.fridge});

  final FridgeModel fridge;

  @override
  Widget build(BuildContext context) {
    return new Container(
      
      
      padding: const EdgeInsets.all(8),
      child: Column(
        
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
                padding: const EdgeInsets.all(20),
                child: Icon(Icons.people, size: 48),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Donors',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Details of the donors',
                    style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[500]),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Flexible(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                ["Duos Marketing", Icons.local_atm, Colors.deepPurpleAccent],
                ["Dine with Smith", Icons.fastfood, Colors.teal],
                [
                  "Jasper Flights",
                  Icons.airplanemode_active,
                  Colors.orangeAccent
                ],
              ]
                  .map(
                    (i) => Card(
                      clipBehavior: Clip.antiAlias,
                      color: i[2],
                      shape: StadiumBorder(),
                      child: ListTile(
                        title: Text(i[0], style: TextStyle(fontSize: 16)),
                        leading: Icon(i[1]),
                        onTap: () {},
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
