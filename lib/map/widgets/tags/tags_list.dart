// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:locator/controllers/options_controller.dart';
// import 'package:locator/map/widgets/tags/tag_card.dart';
// import 'package:locator/map/widgets/update_page.dart';
// import 'package:locator/options/routes/contribute_page.dart';
// import 'package:locator/options/routes/options_page.dart';

// class TagsList extends StatefulWidget {
//   @override
//   _TagsListState createState() => _TagsListState();
// }

// class _TagsListState extends State<TagsList> {
//   final optionsController = GetIt.I.get<OptionsController>();

//   List<Widget> pages;
//   int currentView = 0;

//   @override
//   void initState() {
//     super.initState();
//     pages = [
//       mainPage(),
//       updatePage(),
//       contributePage(),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return pages[currentView];
//   }

//   mainPage() {
//     return Container(
//       height: 100,
//       padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         physics: BouncingScrollPhysics(),
//         children: [
//           TagCard(
//             text: 'OPTIONS',
//             icon: Icons.warning,
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => OptionsPage(),
//                 ),
//               );
//             },
//           ),
//           TagCard(
//             text: 'UPDATE',
//             icon: Icons.warning,
//             onPressed: () {
//               optionsController.optionSelected = true;
//               print(optionsController.optionSelected);
//               setState(() {
//                 currentView = 1;
//               });
//             },
//           ),
//           TagCard(
//             text: 'CONTRIBUTE',
//             icon: Icons.warning,
//             onPressed: () {
//               optionsController.optionSelected = true;
//               print(optionsController.optionSelected);
//               setState(() {
//                 currentView = 2;
//               });
//             },
//           ),
//           TagCard(
//             text: 'CAN\'T FIND SOMETHING?',
//             icon: Icons.warning,
//             onPressed: () {},
//           ),
//           TagCard(
//             text: 'DONATE',
//             icon: Icons.warning,
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }

//   updatePage() {
//     return UpdatePage();
//   }

//   contributePage() {
//     return ContributePage();
//   }
// }
