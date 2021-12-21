import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemePrimary {
  static Color primaryColor = Color(0xFF279E97);
  static Color scaffoldBackgroundColor = Color(0xFFF5F5F5);
  static Color accentColor = Color(0xFFe84545);
  static Color backgroundColor = Color(0xFFFFFFFF);

  static String fontFamily = "BeFonts";
  static Color textPrimaryColor = Color(0xFF2b2e4a);

  static ThemeData theme() {
    return ThemeData(
      primaryColor: primaryColor,
      // scaffoldBackgroundColor: scaffoldBackgroundColor,
      // accentColor: accentColor,
      // backgroundColor: backgroundColor,
      // appBarTheme: AppBarTheme(
      //   systemOverlayStyle: SystemUiOverlayStyle(
      //       statusBarBrightness: Brightness.dark, // For iOS: (dark icons)
      //       statusBarIconBrightness:
      //           Brightness.dark, // For Android: (dark icons)
      //       statusBarColor: Colors.red),
      // ),
      fontFamily: fontFamily,
      textTheme: TextTheme(
        headline1: TextStyle(
            color: textPrimaryColor, fontWeight: FontWeight.bold, fontSize: 24),
        headline2: TextStyle(
            color: textPrimaryColor, fontWeight: FontWeight.bold, fontSize: 20),
        bodyText1: TextStyle(
            color: textPrimaryColor,
            fontWeight: FontWeight.normal,
            fontSize: 14),
        bodyText2: TextStyle(
            color: textPrimaryColor,
            fontWeight: FontWeight.normal,
            fontSize: 12),
      ),
    );
  }
}
