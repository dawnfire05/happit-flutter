import 'package:flutter/painting.dart';

abstract class Palette {
  Palette._();
  static const primary = Color(0xff66D271);
  static const primaryText = Color(0xff56B45F);
  static const white = Color(0xFFFFFFFF);
  static const black20 = Color(0xFFF0F2F6);
  static const black80 = Color(0xFF8D939D);
  static const black100 = Color(0xFF1F2329);
  static const error = Color(0xFFFE2929);

  static const inputShadow = [
    BoxShadow(color: Color(0x99DBE5EC), blurRadius: 8, offset: Offset(0, 4)),
    BoxShadow(color: Color(0x99DBE5EC), blurRadius: 1, offset: Offset(0, 0)),
  ];
}
