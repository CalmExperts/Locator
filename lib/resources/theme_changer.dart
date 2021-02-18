// import 'package:flutter/material.dart';

// class ThemeBuilder extends StatefulWidget {
//   final Widget Function(BuildContext context, Brightness brightness) builder;
//   final Brightness defaultBrightness;

//   const ThemeBuilder({Key key, this.builder, this.defaultBrightness})
//       : super(key: key);

//   @override
//   _ThemeBuilderState createState() => _ThemeBuilderState();

//   static _ThemeBuilderState of(BuildContext context) {
//     return context.findAncestorStateOfType<_ThemeBuilderState>();
//   }
// }

// class _ThemeBuilderState extends State<ThemeBuilder> {
//   Brightness _brightness;

//   @override
//   void initState() {
//     super.initState();
//     _brightness = widget.defaultBrightness;
//     if (mounted) {
//       setState(() {});
//     }
//   }

//   void changeTheme() {
//     setState(() {
//       _brightness =
//           _brightness == Brightness.dark ? Brightness.light : Brightness.dark;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.builder(context, _brightness);
//   }
// }
