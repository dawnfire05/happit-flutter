import 'package:flutter/material.dart';

class InputDayOfWeekWidget extends StatelessWidget {
  const InputDayOfWeekWidget({
    super.key,
    required this.selectedDays,
    required this.onDaySelected,
  });

  final List<String> selectedDays;
  final ValueChanged<String> onDaySelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDayButton('월', 'mon'),
          _buildDayButton('화', 'tue'),
          _buildDayButton('수', 'wed'),
          _buildDayButton('목', 'thu'),
          _buildDayButton('금', 'fri'),
          _buildDayButton('토', 'sat'),
          _buildDayButton('일', 'sun'),
        ],
      ),
    );
  }

  Widget _buildDayButton(String label, String day) {
    bool isSelected = selectedDays.contains(day);
    return Container(
      height: 36,
      width: 36,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: isSelected ? const Color(0xff66D271) : Colors.transparent,
      ),
      child: TextButton(
        onPressed: () => onDaySelected(day),
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
        ),
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
    );
  }
}
