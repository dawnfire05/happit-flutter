import 'package:flutter/material.dart';
import 'package:happit_flutter/app/modules/common/presentation/widgets/bottom_navigation_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
      ),
      body: Center(
        child: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
              // MaterialPageRoute(builder: (context) => const Home()),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
