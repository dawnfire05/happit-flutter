import 'package:flutter/material.dart';

/// 습관 테마 색상 팔레트.
const List<String> habitThemeColorHexList = [
  '#66D271',
  '#7D5BA6',
  '#FC6471',
  '#F8C630',
  '#30C5FF',
];

/// Hex 문자열을 [Color]로 파싱. 실패 시 null.
Color? colorFromHex(String? hex) {
  if (hex == null || hex.isEmpty) return null;
  final h = hex.startsWith('#') ? hex : '#$hex';
  if (h.length != 7) return null;
  final value = int.tryParse(h.substring(1), radix: 16);
  if (value == null) return null;
  return Color(0xFF000000 | value);
}
