import 'package:flutter/material.dart';

/// 화면 진입 시 한 번만 [onEnter]를 호출한 뒤 [child]를 표시하는 래퍼.
/// 라우트 진입 시 데이터 로딩 등을 트리거할 때 재사용할 수 있다.
class LoadOnEnter extends StatefulWidget {
  const LoadOnEnter({
    super.key,
    required this.onEnter,
    required this.child,
  });

  final void Function(BuildContext context) onEnter;
  final Widget child;

  @override
  State<LoadOnEnter> createState() => _LoadOnEnterState();
}

class _LoadOnEnterState extends State<LoadOnEnter> {
  @override
  void initState() {
    super.initState();
    widget.onEnter(context);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
