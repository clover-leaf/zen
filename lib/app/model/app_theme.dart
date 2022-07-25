import 'package:flutter/material.dart';

class AppTheme {
  static const TextTheme lightTextTheme = TextTheme(
    //
    displayLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 57,
      fontWeight: FontWeight.w400,
      height: 64 / 57,
      color: Color(0xff212121),
    ),
    //
    displayMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 45,
      fontWeight: FontWeight.w400,
      height: 52 / 45,
      color: Color(0xff212121),
    ),
    //
    displaySmall: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 36,
      fontWeight: FontWeight.w400,
      height: 40 / 36,
      color: Color(0xff212121),
    ),
    //
    headlineLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 32,
      fontWeight: FontWeight.w400,
      height: 40 / 32,
      color: Color(0xff212121),
    ),
    //
    headlineMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 28,
      fontWeight: FontWeight.w400,
      height: 36 / 28,
      color: Color(0xff212121),
    ),
    //
    headlineSmall: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 22,
      fontWeight: FontWeight.w500,
      letterSpacing: -.8,
      color: Color(0xff212121),
    ),
    //
    titleLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 22,
      fontWeight: FontWeight.w500,
      height: 26 / 22,
      color: Color(0xff212121),
    ),
    //
    titleMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 20 / 16,
      color: Color(0xff212121),
    ),
    //
    titleSmall: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 18 / 14,
      color: Color(0xff212121),
    ),
    //
    labelLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 18 / 14,
      color: Color(0xff212121),
    ),
    //
    labelMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 16 / 12,
      color: Color(0xff212121),
    ),
    //
    labelSmall: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: Color(0xff212121),
    ),
    //
    bodyLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 20 / 16,
      color: Color(0xff212121),
    ),
    //
    bodyMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 18 / 14,
      color: Color(0xff212121),
    ),
    //
    bodySmall: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 16 / 12,
      color: Color(0xff212121),
    ),
  );
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xff890e4f),
    backgroundColor: const Color(0xffffffff),
    dividerColor: const Color(0xffd3d3d3),
    textTheme: lightTextTheme,
    fontFamily: 'Montserrat',
  );

  static const TextTheme darkTextTheme = TextTheme(
    //
    displayLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 57,
      fontWeight: FontWeight.w400,
      height: 64 / 57,
      color: Color(0xffffffff),
    ),
    //
    displayMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 45,
      fontWeight: FontWeight.w400,
      height: 52 / 45,
      color: Color(0xffffffff),
    ),
    //
    displaySmall: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 36,
      fontWeight: FontWeight.w400,
      height: 40 / 36,
      color: Color(0xffffffff),
    ),
    //
    headlineLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 32,
      fontWeight: FontWeight.w400,
      height: 40 / 32,
      color: Color(0xffffffff),
    ),
    //
    headlineMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 28,
      fontWeight: FontWeight.w400,
      height: 36 / 28,
      color: Color(0xffffffff),
    ),
    // USE FOR HEADLINE
    headlineSmall: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 22,
      fontWeight: FontWeight.w600,
      letterSpacing: -.8,
      color: Color(0xffffffff),
    ),
    //
    titleLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 22,
      fontWeight: FontWeight.w500,
      height: 28 / 22,
      color: Color(0xffffffff),
    ),
    //
    titleMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 24 / 16,
      color: Color(0xffffffff),
    ),
    //
    titleSmall: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 20 / 14,
      color: Color(0xffffffff),
    ),
    //
    labelLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 20 / 14,
      color: Color(0xffffffff),
    ),
    //
    labelMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 16 / 12,
      color: Color(0xffffffff),
    ),
    //
    labelSmall: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 11,
      fontWeight: FontWeight.w500,
      height: 16 / 11,
      color: Color(0xffffffff),
    ),
    //
    bodyLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16,
      letterSpacing: 0.15,
      fontWeight: FontWeight.w500,
      height: 24 / 16,
      color: Color(0xffffffff),
    ),
    //
    bodyMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 20 / 14,
      color: Color(0xffffffff),
    ),
    //
    bodySmall: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 16 / 12,
      color: Color(0xffffffff),
    ),
  );
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xffffffff),
    backgroundColor: const Color(0xff212121),
    textTheme: darkTextTheme,
  );
}
