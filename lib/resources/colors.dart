import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color darkAccent = Color(0xFF0D47A1);
const Color primaryText = Colors.black87;
const Color secondaryText = Colors.black38;
const Color disabled = Color(0xFF8a8e96);
const Color white = Colors.white;
const Color error = Color(0xFFAA0959);
const Color grayBorder = Color(0xFFf3f3f3);

ThemeData locatorTheme = ThemeData(
  buttonColor: white,
  accentColor: darkAccent,
  splashColor: darkAccent,
  disabledColor: disabled,
  dividerColor: primaryText,
  errorColor: error,
  inputDecorationTheme: InputDecorationTheme(focusColor: darkAccent),
  textTheme: TextTheme(
    subtitle2: GoogleFonts.abel(color: darkAccent),
    headline6: TextStyle(
      fontWeight: FontWeight.w600,
      color: primaryText,
    ),
    bodyText1: TextStyle(fontWeight: FontWeight.w400, color: primaryText),
    button: TextStyle(fontWeight: FontWeight.w400, color: darkAccent),
  ),
);
