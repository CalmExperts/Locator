import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ThemeData darkModeTheme = ThemeData(
  primaryColor: primaryColor,
  accentColor: secondaryColor,
  //splashColor:
  disabledColor: disabledColor,
  dividerColor: dividerColor,
  errorColor: errorColor,
  highlightColor: baseLightColor,
  backgroundColor: backgroundColor,

  ///Sub Themes
  buttonTheme: _buttonThemeData,
  textTheme: _textTheme,
  iconTheme: _iconThemeData,
  inputDecorationTheme: _inputDecorationTheme,
);

ButtonThemeData _buttonThemeData = ButtonThemeData(
  buttonColor: primaryColor,
);

TextTheme _textTheme = TextTheme();

IconThemeData _iconThemeData = IconThemeData(
  color: baseLightColor,
);

InputDecorationTheme _inputDecorationTheme = InputDecorationTheme();

// ThemeData locatorTheme = ThemeData(
//   buttonColor: white,
//   accentColor: darkAccent,
//   splashColor: darkAccent,
//   disabledColor: disabled,
//   dividerColor: primaryText,
//   errorColor: error,
//   inputDecorationTheme: InputDecorationTheme(focusColor: darkAccent),
//   textTheme: TextTheme(
//     subtitle2: GoogleFonts.abel(color: darkAccent),
//     headline6: TextStyle(
//       fontWeight: FontWeight.w600,
//       color: primaryText,
//     ),
//     bodyText1: TextStyle(fontWeight: FontWeight.w400, color: primaryText),
//     button: TextStyle(fontWeight: FontWeight.w400, color: darkAccent),
//   ),
// );
