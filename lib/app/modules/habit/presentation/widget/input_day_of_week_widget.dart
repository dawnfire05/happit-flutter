import 'package:flutter/material.dart';
import 'package:happit_flutter/values/palette.dart';

class InputDayOfWeekWidget extends StatelessWidget {
  const InputDayOfWeekWidget({
    super.key,
    required this.selectedDays,
    required this.onDaySelected,
  });

  final List<String> selectedDays;
  final ValueChanged<String> onDaySelected;

  static const _days = [
    ('월', 'mon'),
    ('화', 'tue'),
    ('수', 'wed'),
    ('목', 'thu'),
    ('금', 'fri'),
    ('토', 'sat'),
    ('일', 'sun'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadows: Palette.inputShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _days
            .map((day) => _buildDayButton(day.$1, day.$2))
            .toList(),
      ),
    );
  }

  Widget _buildDayButton(String label, String day) {
    final isSelected = selectedDays.contains(day);
    return GestureDetector(
      onTap: () => onDaySelected(day),
      child: Container(
        height: 36,
        width: 36,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: isSelected ? Palette.primary : Colors.transparent,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Palette.black80,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 0,
              letterSpacing: -1.20,
            ),
          ),
        ),
      ),
    );
  }
}
