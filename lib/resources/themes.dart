import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ThemeData darkModeTheme = ThemeData(
  primaryColor: primaryColor,
  accentColor: brandColor,
  splashColor: splashColor,
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

TextTheme _textTheme = TextTheme(
  button: TextStyle(
    fontWeight: FontWeight.w400,
    color: primaryTextColor,
  ),
  bodyText1: TextStyle(
    fontWeight: FontWeight.w400,
    color: primaryTextColor,
  ),
  headline6: TextStyle(
    fontWeight: FontWeight.w600,
    color: primaryTextColor,
  ),
  subtitle2: GoogleFonts.abel(
    color: primaryTextColor,
  ),
);

IconThemeData _iconThemeData = IconThemeData(
  color: baseLightColor,
);

InputDecorationTheme _inputDecorationTheme = InputDecorationTheme();
