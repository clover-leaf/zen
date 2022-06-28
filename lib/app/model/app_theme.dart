
import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/common.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Palette.mBlack.toColor(),
    backgroundColor: Palette.mWhite.toColor(),
  );
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Palette.mWhite.toColor(),
    backgroundColor: Palette.mBlack.toColor(),
  );
}
