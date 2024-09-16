import 'package:flutter/material.dart';

class InputRepeatTypeWidget extends StatelessWidget {
  final String selectedRepeatType = 'daily';
  const InputRepeatTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildRepeatTypeSelector('daily', '매일', context),
          const SizedBox(width: 12),
          _buildRepeatTypeSelector('weekly', '요일별', context)
        ],
      ),
    );
  }

  Widget _buildRepeatTypeSelector(
      String repeatType, String label, BuildContext context) {
    bool isSelected = selectedRepeatType == repeatType;
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: ShapeDecoration(
            shadows: const [
              BoxShadow(
                color: Color(0x99DBE5EC),
                blurRadius: 24,
                offset: Offset(0, 8),
                spreadRadius: 0,
              )
            ],
            color: isSelected ? const Color(0xff66D271) : Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xff8C929D),
                fontSize: 15,
                fontFamily: 'Noto Sans KR',
                fontWeight: FontWeight.w400,
                height: 0,
                letterSpacing: -1.20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
