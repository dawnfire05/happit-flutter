import 'package:flutter/material.dart';
import 'package:happit_flutter/values/palette.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    this.onPressed,
    required this.text,
    this.color,
  });

  final VoidCallback? onPressed;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: ShapeDecoration(
          color: color ?? Palette.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x4C66D271),
              blurRadius: 24,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ]),
      child: Builder(builder: (context) {
        return TextButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w700,
                  height: 0,
                  letterSpacing: -1.28,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
