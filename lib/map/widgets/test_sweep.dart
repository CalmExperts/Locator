// import 'package:flutter/material.dart';

// class TestSweep extends StatelessWidget with SingleTickerProviderStateMixin {
//   final double heightFactor = 0.67;

//   @override
//   Widget build(BuildContext context) {
//     debugPrint(MediaQuery.of(context).size.height.toString());
//     return MaterialApp(
//         title: 'Teste',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//                   home:  Container(

//           child: Column(

//             children: <Widget>[
//               FractionallySizedBox(
//                 alignment: Alignment.topCenter,
//                 // heightFactor: heightFactor,
//                 child:Container(
//                   height: 500,
//                   // height: 0.67,
//                   color: Colors.red,
//                 )
//               ),
//                     FractionallySizedBox(
//                 alignment: Alignment.bottomCenter,

//                 child:Container(
//                   // height: 500,
//                   height: 200,
//                   color: Colors.teal,
//                 )
//               ),
//             ],
//           ),
//         ));
//   }
// }
