import 'package:flutter/material.dart';

/// 공통 로딩 화면 위젯
/// 
/// Column이나 ListView 등의 flex container 내부에서 사용할 수 있도록
/// Expanded로 감싸져 있습니다.
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

/// 일반적인 로딩 위젯 (Expanded 없이 사용)
/// 
/// SingleChildScrollView나 일반 Container 내부에서 사용
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
