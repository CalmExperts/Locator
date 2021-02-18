import 'package:flutter/material.dart';
import 'package:locator/map/widgets/tags/tag_item.dart';
import 'package:locator/options/routes/options_page.dart';

class TagsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        children: [
          TagItem(
            text: "OPTIONS",
            icon: Icons.warning,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OptionsPage(),
                ),
              );
            },
          ),
          TagItem(
            text: "UPDATE",
            icon: Icons.warning,
            onPressed: () {},
          ),
          TagItem(
            text: "CONTRIBUTE",
            icon: Icons.warning,
            onPressed: () {},
          ),
          TagItem(
            text: "CAN\'T FIND SOMETHING?",
            icon: Icons.warning,
            onPressed: () {},
          ),
          TagItem(
            text: "DONATE",
            icon: Icons.warning,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // bool enableNext(OptionState state) {
  //   final currentPage = state.activeEditDropCardPage;
  //   final drop = state.drop;
  //   switch (currentPage) {
  //     case EditDropCardPage.category:
  //       return drop.category != null;
  //     case EditDropCardPage.location:
  //       return locationController.text.isNotEmpty;
  //       break;
  //     case EditDropCardPage.condition:
  //       return drop.condition != null;
  //       break;
  //     case EditDropCardPage.comment:
  //       return true;
  //       break;
  //     case EditDropCardPage.summary:
  //     case EditDropCardPage.tags:
  //       return true;
  //       break;
  //     default:
  //       throw InvalidDataException('$currentPage is not a valid page');
  //   }
  // }

}
