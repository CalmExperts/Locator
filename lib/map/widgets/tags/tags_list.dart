import 'package:flutter/material.dart';
import 'package:locator/map/widgets/controllers/app_controller.dart';
import 'package:locator/map/widgets/tags/tag_card.dart';
import 'package:locator/options/routes/options_page.dart';

class TagsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        children: [
          TagCard(
            text: 'OPTIONS',
            icon: Icons.warning,
            onPressed: () {
              print('OPTIONS!');

              AppController.instance.changeModal(false);
              AppController.instance.changeColor(false);
              AppController.instance.changeButtonColor('OPTIONS');

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OptionsPage(),
                ),
              );
            },
          ),

          TagCard(
            text: 'UPDATE',
            icon: Icons.warning,
            onPressed: () {
              print('UPDATE!');

              AppController.instance.changeModal(true);
              AppController.instance.changeButtonColor('UPDATE');
              AppController.instance.changeColor(true);
            },
          ),

          TagCard(
            text: 'CONTRIBUTE',
            icon: Icons.warning,
            onPressed: () {
              print('CONTRIBUTE!');

              AppController.instance.changeModal(false);
              AppController.instance.changeButtonColor('CONTRIBUTE');
              AppController.instance.changeColor(false);
            },
          ),

          TagCard(
            text: 'CAN\'T FIND SOMETHING?',
            icon: Icons.warning,
            onPressed: () {
              print('CANT\' FIND SOMETHING!');

              AppController.instance
                  .changeButtonColor('CAN\'T FIND SOMETHING?');
              AppController.instance.changeModal(false);
              AppController.instance.changeColor(false);
            },
          ),

          TagCard(
            text: 'DONATE',
            icon: Icons.warning,
            onPressed: () {
              print('DONATE');
              AppController.instance.changeButtonColor('DONATE');

              AppController.instance.changeModal(false);
              AppController.instance.changeColor(false);
            },
          ),

          // ),
        ],
      ),
    );
  }
}
