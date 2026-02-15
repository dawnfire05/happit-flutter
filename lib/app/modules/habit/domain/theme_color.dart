import 'package:flutter/material.dart';

/// 습관 테마 색상 팔레트 (InputThemeWidget과 동일한 순서).
const List<String> habitThemeColorHexList = [
  '#66D271',
  '#7D5BA6',
  '#FC6471',
  '#F8C630',
  '#30C5FF',
];

/// [hex]에 해당하는 팔레트 인덱스. 없으면 0.
int habitThemeColorHexToIndex(String hex) {
  final normalized = hex.startsWith('#') ? hex.toUpperCase() : '#${hex.toUpperCase()}';
  final index = habitThemeColorHexList.indexWhere(
    (h) => h.toUpperCase() == normalized,
  );
  return index >= 0 ? index : 0;
}

/// [index]번 팔레트 색상의 Hex 문자열.
String habitThemeColorIndexToHex(int index) {
  final i = index.clamp(0, habitThemeColorHexList.length - 1);
  return habitThemeColorHexList[i];
}

/// Hex 문자열을 [Color]로 파싱. 실패 시 null.
Color? colorFromHex(String? hex) {
  if (hex == null || hex.isEmpty) return null;
  final h = hex.startsWith('#') ? hex : '#$hex';
  if (h.length != 7) return null;
  final value = int.tryParse(h.substring(1), radix: 16);
  if (value == null) return null;
  return Color(0xFF000000 | value);
}
