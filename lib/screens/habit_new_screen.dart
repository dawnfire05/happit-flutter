import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:happit_flutter/widgets/bottom_navigation_bar.dart';

class HabitNewScreen extends StatefulWidget {
  const HabitNewScreen({super.key});

  @override
  State<HabitNewScreen> createState() => _HabitNewScreenState();
}

class _HabitNewScreenState extends State<HabitNewScreen> {
  var habitName = '';
  var habitRepeatType = 0;
  List<int> repeatDay = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('습관 추가'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(labelText: '추가할 습관을 입력하세요.'),
              ),
              const TextField(
                decoration: InputDecoration(labelText: '매일/요일별'),
              ),
              const TextField(
                decoration: InputDecoration(labelText: '시간'),
              ),
              const TextField(
                decoration: InputDecoration(labelText: '색상 선택'),
              ),
              ElevatedButton(
                onPressed: () => {},
                child: const Text('습관 추가하기'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
