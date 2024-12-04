import 'package:flutter/material.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/happit_bottom_navigation_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [Text('프로필')],
        ),
      ),
    );
  }
}
