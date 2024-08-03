import 'package:flutter/material.dart';
import 'package:happit_flutter/widgets/bottom_navigation_bar.dart';
import 'package:happit_flutter/widgets/habit_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('happit'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: HabitWidget(),
          ),
        ),
        bottomNavigationBar: const MyBottomNavigationBar());
  }
}
