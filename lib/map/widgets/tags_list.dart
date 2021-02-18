import 'package:flutter/material.dart';
import 'package:locator/map/widgets/tag_card.dart';
import 'package:locator/options/routes/options_page.dart';

class TagsList extends StatelessWidget {
  const TagsList();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      // width: 900,
      // color: Colors.red,
      // alignment: Alignment.center,
      child: ListView(
        // direction: Axis.horizontal,
        // crossAxisAlignment: WrapCrossAlignment.start,

        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),

        children: [
          TagCard(
            text: 'OPTIONS',
            icon: Icons.warning,
            onPressed: () {
              print('OPTIONS!');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OptionsPage(),
                ),
              );
            },
          ),
          TagCard(
            text: 'UPDATE NAV',
            icon: Icons.warning,
            onPressed: () {
              print('UPDATE!');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OptionsPage(),
                ),
              );
            },
          ),
          TagCard(
            text: 'CONTRIBUTE',
            icon: Icons.warning,
            onPressed: () {
              print('CONTRIBUTE!');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OptionsPage(),
                ),
              );
            },
          ),
          TagCard(
            text: 'CANT\' FIND SOMETHING',
            icon: Icons.warning,
            onPressed: () {
              print('CANT\' FIND SOMETHING!');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OptionsPage(),
                ),
              );
            },
          ),

          TagCard(
            text: 'DONATE',
            icon: Icons.warning,
            onPressed: () {
              print('DONATE');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OptionsPage(),
                ),
              );
            },
          ),
          // ),
        ],

        // children: tags
        //     .map(
        //       (tag) =>

        //           ),
        //     )
        //     .toList(),
      ),
    );
  }
}
