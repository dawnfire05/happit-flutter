import 'package:flutter/material.dart';
import 'package:happit_flutter/values/palette.dart';

/// 다양한 상황에서 재사용 가능한 확인 다이얼로그.
///
/// [title] 제목, [message] 본문(선택), [cancelLabel]/[confirmLabel] 버튼 텍스트,
/// [isDestructive]가 true이면 확인 버튼을 빨간색(위험 액션)으로 표시.
class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.title,
    this.message,
    this.cancelLabel = '아니요',
    this.confirmLabel = '확인',
    this.isDestructive = false,
    required this.onCancel,
    required this.onConfirm,
  });

  final String title;
  final String? message;
  final String cancelLabel;
  final String confirmLabel;
  final bool isDestructive;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  /// 다이얼로그를 띄우고 사용자 선택을 반환한다.
  /// [true] 확인, [false] 취소, [null] 배경 탭 등으로 닫힌 경우.
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    String? message,
    String cancelLabel = '아니요',
    String confirmLabel = '확인',
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmDialog(
        title: title,
        message: message,
        cancelLabel: cancelLabel,
        confirmLabel: confirmLabel,
        isDestructive: isDestructive,
        onCancel: () => Navigator.of(context).pop(false),
        onConfirm: () => Navigator.of(context).pop(true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final confirmColor = isDestructive ? Palette.error : Palette.primary;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: ShapeDecoration(
          color: Palette.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Palette.black100,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: -1.44,
              ),
            ),
            if (message != null && message!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                message!,
                style: const TextStyle(
                  color: Palette.black80,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.56,
                  height: 1.4,
                ),
              ),
            ],
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _DialogButton(
                    label: cancelLabel,
                    backgroundColor: Palette.white,
                    textColor: Palette.black100,
                    side: const BorderSide(color: Color(0xFFDBE5EC)),
                    onPressed: onCancel,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DialogButton(
                    label: confirmLabel,
                    backgroundColor: confirmColor,
                    textColor: Palette.white,
                    onPressed: onConfirm,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    this.side,
    required this.onPressed,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;
  final BorderSide? side;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 48,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: side ?? BorderSide.none,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: -1.28,
            ),
          ),
        ),
      ),
    );
  }
}
