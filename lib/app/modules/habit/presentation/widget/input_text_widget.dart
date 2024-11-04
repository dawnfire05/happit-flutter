import 'package:flutter/material.dart';

class InputTextWidget extends StatefulWidget {
  const InputTextWidget({
    super.key,
    required this.habitNameController,
    required this.hintText,
  });

  final TextEditingController habitNameController;
  final String hintText;

  @override
  State<InputTextWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputTextWidget> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  _onFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  List<BoxShadow> focus = [
    const BoxShadow(
      color: Color(0x4C66D271),
      blurRadius: 24,
      offset: Offset(0, 0),
      spreadRadius: 0,
    )
  ];
  List<BoxShadow> done = [
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 2,
                color:
                    _isFocused ? const Color(0xFF66D271) : Colors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: _isFocused ? focus : done),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: widget.habitNameController,
            focusNode: _focusNode,
            style: const TextStyle(
              color: Color(0xFF1F2329),
              fontSize: 13,
              fontFamily: 'Noto Sans KR',
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Color(0xFF8C929D),
                fontSize: 13,
                fontFamily: 'Noto Sans KR',
                fontWeight: FontWeight.w400,
                letterSpacing: -1.04,
              ),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
