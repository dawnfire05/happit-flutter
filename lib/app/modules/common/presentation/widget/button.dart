import 'package:flutter/material.dart';
import 'package:happit_flutter/values/palette.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.content, required this.onPressed});

  final String content;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: Palette.black20,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          '습관 추가하러 가기',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: -1.44,
            color: Palette.black100,
          ),
        ),
      ),
    );
  }
}
