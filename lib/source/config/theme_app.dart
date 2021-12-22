import 'package:flutter/material.dart';

class ThemePrimary {
  static Color primaryColor = const Color(0xFF279E97);
  static Color scaffoldBackgroundColor = const Color(0xFFF5F5F5);
  static Color accentColor = const Color(0xFFe84545);
  static Color backgroundColor = const Color(0xFFFFFFFF);

  static String fontFamily = "BeFonts";
  static Color textPrimaryColor = const Color(0xFF2b2e4a);

  static Color green = const Color(0xFF4CD97B);
  static Color orange = const Color(0xFFFFB259);

  static List<BoxShadow>? boxShadow = [
    const BoxShadow(
        color: Colors.black26,
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3)),
  ];

  static ThemeData theme() {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      backgroundColor: backgroundColor,
      fontFamily: fontFamily,
      textTheme: TextTheme(
        headline1: TextStyle(
            color: textPrimaryColor, fontWeight: FontWeight.bold, fontSize: 24),
        headline2: TextStyle(
            color: textPrimaryColor, fontWeight: FontWeight.bold, fontSize: 20),
        headline3: TextStyle(
            color: textPrimaryColor, fontWeight: FontWeight.bold, fontSize: 16),
        bodyText1: TextStyle(
            color: textPrimaryColor,
            fontWeight: FontWeight.normal,
            fontSize: 16),
        bodyText2: TextStyle(
            color: textPrimaryColor,
            fontWeight: FontWeight.normal,
            fontSize: 14),
        subtitle2: TextStyle(
            color: textPrimaryColor,
            fontWeight: FontWeight.normal,
            fontSize: 12),
      ),
    );
  }
}
