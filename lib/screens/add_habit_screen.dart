import 'package:flutter/material.dart';
import 'package:happit_flutter/widgets/bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final TextEditingController habitNameController = TextEditingController();
  final TextEditingController habitDescriptionController =
      TextEditingController();
  final TextEditingController habitRepeatTypeController =
      TextEditingController();
  final TextEditingController habitRepeatDayController =
      TextEditingController();
  List<String> repeatDays = [];

  @override
  void dispose() {
    habitNameController.dispose();
    habitDescriptionController.dispose();
    habitRepeatTypeController.dispose();
    habitRepeatDayController.dispose();
    super.dispose();
  }

  Future<void> addHabit() async {
    final String habitName = habitNameController.text;
    final String habitDescription = habitDescriptionController.text;
    final String habitRepeatType = habitRepeatTypeController.text;

    const String endpoint = 'http://localhost:3000/habit';

    final Map<String, dynamic> habitData = {
      'name': habitName,
      'description': habitDescription,
      'repeatType': habitRepeatType,
      'repeatDay': repeatDays,
    };

    final response = await http.post(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3QiLCJzdWIiOjUsImlhdCI6MTcyMjY1MTM3OCwiZXhwIjoxNzIyNjUzMTc4fQ.-rbh6lU-5EUcr7Uj-_Tisw4PQ3RAGIhnANxr8rRdA_Q',
      },
      body: jsonEncode(habitData),
    );

    if (response.statusCode == 201) {
      // Handle success
      print('Habit added successfully');
    } else {
      // Handle error
      print('Failed to add habit: ${response.body}');
    }
  }

  void addDayOfWeek(String day) {
    setState(() {
      if (repeatDays.contains(day)) {
        repeatDays.remove(day);
      } else {
        repeatDays.add(day);
      }
    });
  }

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
              TextField(
                controller: habitNameController,
                decoration: const InputDecoration(labelText: '추가할 습관을 입력해주세요'),
              ),
              TextField(
                controller: habitDescriptionController,
                decoration: const InputDecoration(labelText: '설명을 입력해주세요'),
              ),
              TextField(
                controller: habitRepeatTypeController,
                decoration: const InputDecoration(labelText: '매일 / 요일별'),
              ),
              Wrap(
                spacing: 8.0,
                children: [
                  _buildDayButton('월', 'mon'),
                  _buildDayButton('화', 'tue'),
                  _buildDayButton('수', 'wed'),
                  _buildDayButton('목', 'thu'),
                  _buildDayButton('금', 'fri'),
                  _buildDayButton('토', 'sat'),
                  _buildDayButton('일', 'sun'),
                ],
              ),
              ElevatedButton(
                onPressed: addHabit,
                child: const Text('습관 추가하기'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }

  Widget _buildDayButton(String label, String day) {
    return TextButton(
      onPressed: () => addDayOfWeek(day),
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: repeatDays.contains(day) ? Colors.blue : Colors.grey,
      ),
      child: Text(label),
    );
  }
}
