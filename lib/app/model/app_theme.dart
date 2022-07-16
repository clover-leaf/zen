import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final TextTheme lightTextTheme = TextTheme(
    // header || chart title
    headline1: GoogleFonts.montserrat(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 22 / 18,
      color: const Color(0xff1A191E),
    ),
    // header subtitle || chart subtitle
    headline2: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 18 / 14,
      color: const Color(0xff1A191E).withAlpha(193),
    ),
    // menu title
    headline3: GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 20 / 16,
      color: const Color(0xff1A191E),
    ),
    // chart value
    headline4: GoogleFonts.montserrat(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      height: 28 / 24,
      color: const Color(0xff1A191E),
    ),
    // chart value label
    headline5: GoogleFonts.montserrat(
      fontSize: 12,
      letterSpacing: 16/12,
      fontWeight: FontWeight.w800,
      height: 16/12,
      color: const Color(0xff1A191E).withAlpha(193),
    ),
    // chart value unit
    headline6: GoogleFonts.montserrat(
      fontSize: 12,
      letterSpacing: 16/12,
      fontWeight: FontWeight.w700,
      height: 16/12,
      color: const Color(0xff1A191E),
    ),
    // capital headline
    caption: GoogleFonts.montserrat(
      fontSize: 16,
      letterSpacing: 20/16,
      fontWeight: FontWeight.w900,
      height: 20/16,
      color: const Color(0xff1A191E),
    ),
    // capital subtitle
    subtitle1: GoogleFonts.montserrat(
      fontSize: 14,
      letterSpacing: 22/14,
      fontWeight: FontWeight.w700,
      height: 18/14,
      color: const Color(0xff1A191E),
    ),
    // bold action subtitle
    subtitle2: GoogleFonts.montserrat(
      fontSize: 14,
      letterSpacing: 18/14,
      fontWeight: FontWeight.w800,
      height: 18/14,
      color: const Color(0xff1A191E),
    ),
  );
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xff1A191E),
    backgroundColor: const Color(0xffffffff),
    textTheme: lightTextTheme,
  );

  static final TextTheme darkTextTheme = TextTheme(
    // header
    headline1: GoogleFonts.montserrat(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 22 / 18,
      color: const Color(0xffffffff),
    ),
    // header subtitle
    headline2: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 18 / 14,
      color: const Color(0xffffffff).withAlpha(193),
    ),
    // menu title
    headline3: GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 20 / 16,
      color: const Color(0xffffffff),
    ),
    // chart value
    headline4: GoogleFonts.montserrat(
      fontSize: 18,
      fontWeight: FontWeight.w800,
      height: 22 / 18,
      color: const Color(0xffffffff),
    ),
    // chart value label
    headline5: GoogleFonts.montserrat(
      fontSize: 10,
      letterSpacing: 14/10,
      fontWeight: FontWeight.w600,
      height: 14/10,
      color: const Color(0xffffffff).withAlpha(193),
    ),
    // chart value unit
    headline6: GoogleFonts.montserrat(
      fontSize: 10,
      letterSpacing: 14/10,
      fontWeight: FontWeight.w700,
      height: 14/10,
      color: const Color(0xffffffff),
    ),
    // capital headline
    caption: GoogleFonts.montserrat(
      fontSize: 16,
      letterSpacing: 24/16,
      fontWeight: FontWeight.w900,
      height: 20/16,
      color: const Color(0xffffffff),
    ),
    // capital subtitle
    subtitle1: GoogleFonts.montserrat(
      fontSize: 14,
      letterSpacing: 22/14,
      fontWeight: FontWeight.w700,
      height: 18/14,
      color: const Color(0xffffffff),
    ),
    // bold action subtitle
    subtitle2: GoogleFonts.montserrat(
      fontSize: 14,
      letterSpacing: 18/14,
      fontWeight: FontWeight.w800,
      height: 18/14,
      color: const Color(0xffffffff),
    ),
  );
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xffffffff),
    backgroundColor: const Color(0xff1A191E),
    textTheme: darkTextTheme,
  );
}
