import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happit_flutter/app/modules/habit/domain/theme_color.dart';

class InputThemeWidget extends StatelessWidget {
  const InputThemeWidget({
    super.key,
    required this.selectedColor,
    required this.onThemeChanged,
  });

  final String selectedColor;
  final ValueChanged<String> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      height: 56,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadows: const [
          BoxShadow(
            color: Color(0x99DBE5EC),
            blurRadius: 8,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x99DBE5EC),
            blurRadius: 1,
            offset: Offset(0, 0),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '테마 색상',
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,

              fontWeight: FontWeight.w400,
              height: 0,
              letterSpacing: -1.04,
            ),
          ),
          Wrap(
            spacing: 12,
            children: habitThemeColorHexList
                .map((hex) => _buildColorThemeContainer(hex))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildColorThemeContainer(String hex) {
    bool isSelected = selectedColor == hex;
    return GestureDetector(
      onTap: () => onThemeChanged(hex),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: ShapeDecoration(
              shadows: const [
                BoxShadow(
                  color: Color(0x99DBE5EC),
                  blurRadius: 24,
                  offset: Offset(0, 8),
                  spreadRadius: 0,
                ),
              ],
              color: colorFromHex(hex) ?? const Color(0xff66D271),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Visibility(
            visible: isSelected,
            child: SvgPicture.asset('assets/icons/Check.svg'),
          ),
        ],
      ),
    );
  }
}
