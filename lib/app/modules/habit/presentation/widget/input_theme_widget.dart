import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InputThemeWidget extends StatelessWidget {
  const InputThemeWidget({
    super.key,
    required this.selectedColorIndex,
    required this.onThemeChanged,
  });

  final int selectedColorIndex;
  final ValueChanged<int> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      height: 56,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
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
          )
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
              fontFamily: 'Noto Sans KR',
              fontWeight: FontWeight.w400,
              height: 0,
              letterSpacing: -1.04,
            ),
          ),
          Wrap(
            spacing: 12,
            children: [
              _buildColorThemeContainer(0, const Color(0xff66D271)),
              _buildColorThemeContainer(1, const Color(0xff7D5BA6)),
              _buildColorThemeContainer(2, const Color(0xffFC6471)),
              _buildColorThemeContainer(3, const Color(0xffF8C630)),
              _buildColorThemeContainer(4, const Color(0xff30C5FF))
            ],
          )
        ],
      ),
    );
  }

  Widget _buildColorThemeContainer(int index, Color color) {
    bool isSelected = selectedColorIndex == index;
    return GestureDetector(
      onTap: () => onThemeChanged(index),
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
                )
              ],
              color: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
          Visibility(
            visible: isSelected,
            child: SvgPicture.asset('assets/icons/Check.svg'),
          )
        ],
      ),
    );
  }
}
