import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:locator/controllers/options_controller.dart';
import 'package:locator/map/widgets/tags/tag_card.dart';
import 'package:locator/options/routes/options_page.dart';

class TagsList extends StatelessWidget {
  final optionsController = GetIt.I.get<OptionsController>();

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
              // print('OPTIONS!');
              // optionsController.changeModal(false);
              // optionsController.changeColor(false);
              // optionsController.changeButtonColor('OPTIONS');
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
              if (optionsController.isModalActive == false) {
                optionsController.changeModal(true);
                optionsController.changeButtonColor('UPDATE');
                optionsController.changeColor(true);
              } else {
                optionsController.changeModal(false);
                optionsController.changeColor(false);
              }
              // print('UPDATE!');
              // optionsController.changeModal(true);
              // optionsController.changeButtonColor('UPDATE');
              // optionsController.changeColor(true);
            },
          ),
          TagCard(
            text: 'CONTRIBUTE',
            icon: Icons.warning,
            onPressed: () {
              print('CONTRIBUTE!');
              if (optionsController.isModalActive == false) {
                optionsController.changeModal(true);
                optionsController.changeButtonColor('CONTRIBUTE');
                optionsController.changeColor(true);
              } else {
                optionsController.changeModal(false);
                optionsController.changeColor(false);
              }
              // optionsController.isModalActive == false ??
              //     optionsController.changeModal(true);
            },
          ),
          TagCard(
            text: 'CAN\'T FIND SOMETHING?',
            icon: Icons.warning,
            onPressed: () {
              print('CANT\' FIND SOMETHING!');
              if (optionsController.isModalActive == false) {
                optionsController.changeModal(true);
                optionsController.changeButtonColor('CAN\'T FIND SOMETHING?');
                optionsController.changeColor(true);
              } else {
                optionsController.changeModal(false);
                optionsController.changeColor(false);
              }

              // optionsController.changeButtonColor('CAN\'T FIND SOMETHING?');
              // optionsController.changeModal(false);
              // optionsController.changeColor(false);
            },
          ),
          TagCard(
            text: 'DONATE',
            icon: Icons.warning,
            onPressed: () {
              print('DONATE');
              if (optionsController.isModalActive == false) {
                optionsController.changeModal(true);
                optionsController.changeButtonColor('DONATE');
                optionsController.changeColor(true);
              } else {
                optionsController.changeModal(false);
                optionsController.changeColor(false);
              }
            },
          ),
        ],
      ),
    );
  }
}
