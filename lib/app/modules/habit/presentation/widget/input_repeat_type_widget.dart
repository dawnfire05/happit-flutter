import 'package:flutter/material.dart';
import 'package:happit_flutter/values/palette.dart';

class InputRepeatTypeWidget extends StatelessWidget {
  final String selectedRepeatType;
  final ValueChanged<String> onSelected;

  const InputRepeatTypeWidget({
    super.key,
    required this.selectedRepeatType,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      height: 56,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadows: Palette.inputShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildRepeatTypeSelector('daily', '매일'),
          const SizedBox(width: 12),
          _buildRepeatTypeSelector('weekly', '요일별'),
        ],
      ),
    );
  }

  Widget _buildRepeatTypeSelector(String repeatType, String label) {
    final isSelected = selectedRepeatType == repeatType;
    return Expanded(
      child: GestureDetector(
        onTap: () => onSelected(repeatType),
        child: Container(
          decoration: ShapeDecoration(
            color: isSelected ? Palette.primary : Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
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
      ),
    );
  }
}
