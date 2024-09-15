import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({super.key, this.onPressed, required this.text});

  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: ShapeDecoration(
          color: const Color(0xff66D271),
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
