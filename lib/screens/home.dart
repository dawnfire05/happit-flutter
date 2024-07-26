import 'package:flutter/material.dart';
import 'package:happit_flutter/screens/one_depth.dart';
import 'package:happit_flutter/widgets/bottom_navigation_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('happit'),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OneDepth(),
                ),
              );
            },
            child: const Text('press this!')),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
