import 'package:flutter/material.dart';
import 'package:happit_flutter/values/palette.dart';

enum ButtonType { cta, basic, custom }

class MainButton extends StatelessWidget {
  MainButton.cta({
    super.key,
    this.onPressed,
    required this.text,
  })  : type = ButtonType.cta,
        color = Palette.primary,
        shadow = [
          const BoxShadow(
            color: Color(0x4C66D271),
            blurRadius: 24,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ];

  MainButton.basic({
    super.key,
    this.onPressed,
    required this.text,
  })  : type = ButtonType.basic,
        color = Palette.white,
        shadow = [
          const BoxShadow(
            color: Color(0x99DBE5EC),
            blurRadius: 8,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
          const BoxShadow(
            color: Color(0x99DBE5EC),
            blurRadius: 1,
            offset: Offset(0, 0),
            spreadRadius: 1,
          )
        ];

  const MainButton.custom({
    super.key,
    this.onPressed,
    required this.text,
    required this.shadow,
    required this.color,
  }) : type = ButtonType.custom;

  final VoidCallback? onPressed;
  final String text;
  final List<BoxShadow> shadow;
  final Color color;
  final ButtonType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: shadow,
      ),
      child: Builder(
        builder: (context) {
          return TextButton(
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: type == ButtonType.basic
                        ? Palette.black100
                        : Palette.white,
                    fontSize: 16,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1.28,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
