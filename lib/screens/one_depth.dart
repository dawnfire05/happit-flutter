import 'package:flutter/material.dart';
import 'package:happit_flutter/screens/home.dart';
import 'package:happit_flutter/widgets/bottom_navigation_bar.dart';

class OneDepth extends StatelessWidget {
  const OneDepth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('depth 1'),
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
