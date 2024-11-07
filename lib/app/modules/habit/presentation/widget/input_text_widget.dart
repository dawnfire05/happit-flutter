import 'package:flutter/material.dart';
import 'package:happit_flutter/values/palette.dart';

class InputTextWidget extends StatefulWidget {
  final String? label;
  final bool necessary;
  final String? informationText;
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const InputTextWidget.basic({
    super.key,
    required this.hintText,
    this.controller,
    this.focusNode,
  })  : label = null,
        informationText = null,
        necessary = false;

  const InputTextWidget.full({
    super.key,
    required this.label,
    this.necessary = false,
    required this.informationText,
    required this.hintText,
    this.controller,
    this.focusNode,
  });

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

  void _handleFocusChange() =>
      setState(() => isFocused = widget.focusNode?.hasFocus ?? false);

  TextStyle style = const TextStyle(
    color: Palette.black100,
    fontSize: 13,
    fontFamily: 'Noto Sans KR',
    fontWeight: FontWeight.w700,
    letterSpacing: -1.04,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Column(
            children: [
              RichText(
                  text: widget.necessary
                      ? TextSpan(
                          style: style,
                          children: [
                            TextSpan(text: widget.label!),
                            const TextSpan(
                              text: ' *',
                              style: TextStyle(color: Palette.error),
                            )
                          ],
                        )
                      : TextSpan(style: style, text: widget.label!)),
              const SizedBox(height: 8),
            ],
          ),
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 2,
                  color:
                      isFocused ? const Color(0xFF66D271) : Colors.transparent),
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
        ),
        if (widget.informationText != null)
          Column(
            children: [
              const SizedBox(height: 8),
              Text(
                widget.informationText!,
                style: const TextStyle(
                  color: Color(0xFF8C929D),
                  fontSize: 12,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.96,
                ),
              ),
            ],
          )
      ],
    );
  }
}
