import 'package:flutter/painting.dart';

enum Palette {
  mBlack(0xFF402961),
  mWhite(0xFFFFFFFF);

  const Palette(this.color);
  final int color;
}

extension PaletteX on Palette {
  Color toColor() {
    return Color(color);
  }
}
