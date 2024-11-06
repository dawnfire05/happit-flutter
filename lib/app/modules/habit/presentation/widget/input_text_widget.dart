import 'package:flutter/material.dart';

class InputTextWidget extends StatefulWidget {
  const InputTextWidget({
    super.key,
    required this.hintText,
    this.controller,
    this.focusNode,
  });

  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  @override
  State<InputTextWidget> createState() => _InputTextWidgetState();
}

class _InputTextWidgetState extends State<InputTextWidget> {
  bool isFocused = false;

  final List<BoxShadow> focus = [
    const BoxShadow(
      color: Color(0x4C66D271),
      blurRadius: 24,
      offset: Offset(0, 0),
      spreadRadius: 0,
    )
  ];

  final List<BoxShadow> done = [
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
  void initState() {
    super.initState();
    widget.focusNode?.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_handleFocusChange);
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      isFocused = widget.focusNode?.hasFocus ?? false;
    });
  }

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
              color: isFocused ? const Color(0xFF66D271) : Colors.transparent),
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: isFocused ? focus : done,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
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
