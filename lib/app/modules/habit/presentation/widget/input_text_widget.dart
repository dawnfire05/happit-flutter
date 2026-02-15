import 'package:flutter/material.dart';
import 'package:happit_flutter/values/palette.dart';

const _focusShadow = [
  BoxShadow(
    color: Color(0x4C66D271),
    blurRadius: 24,
    offset: Offset(0, 0),
  ),
];

class InputTextWidget extends StatefulWidget {
  final String? label;
  final bool necessary;
  final String? informationText;
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? value;
  final ValueChanged<String>? onChanged;
  final bool obscureText;

  const InputTextWidget.basic({
    super.key,
    required this.hintText,
    this.controller,
    this.focusNode,
    this.value,
    this.onChanged,
    this.obscureText = false,
  }) : label = null,
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
    this.value,
    this.onChanged,
    this.obscureText = false,
  });

  @override
  State<InputTextWidget> createState() => _InputTextWidgetState();
}

class _InputTextWidgetState extends State<InputTextWidget> {
  bool isFocused = false;
  TextEditingController? _internalController;

  @override
  void initState() {
    super.initState();
    widget.focusNode?.addListener(_handleFocusChange);
    if (widget.value != null && widget.onChanged != null) {
      _internalController = TextEditingController(text: widget.value);
      _internalController!.addListener(_onInternalTextChanged);
    }
  }

  @override
  void didUpdateWidget(InputTextWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != null &&
        widget.onChanged != null &&
        widget.value != oldWidget.value &&
        _internalController != null &&
        _internalController!.text != widget.value) {
      _internalController!.text = widget.value!;
      _internalController!.selection = TextSelection.collapsed(
        offset: widget.value!.length,
      );
    }
  }

  void _onInternalTextChanged() {
    if (_internalController != null && widget.onChanged != null) {
      widget.onChanged!(_internalController!.text);
    }
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_handleFocusChange);
    _internalController?.removeListener(_onInternalTextChanged);
    _internalController?.dispose();
    super.dispose();
  }

  void _handleFocusChange() =>
      setState(() => isFocused = widget.focusNode?.hasFocus ?? false);

  static const style = TextStyle(
    color: Palette.black100,
    fontSize: 13,

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
                          ),
                        ],
                      )
                    : TextSpan(style: style, text: widget.label!),
              ),
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
                color: isFocused ? const Color(0xFF66D271) : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            shadows: isFocused ? _focusShadow : Palette.inputShadow,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: widget.value != null && widget.onChanged != null
                    ? _internalController
                    : widget.controller,
                focusNode: widget.focusNode,
                obscureText: widget.obscureText,
                style: const TextStyle(
                  color: Palette.black100,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -1.04,
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                    color: Color(0xFF8C929D),
                    fontSize: 13,
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

                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.96,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
