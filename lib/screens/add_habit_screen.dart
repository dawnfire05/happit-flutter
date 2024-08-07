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
  final FocusNode myFocusNode = FocusNode();

  @override
  void dispose() {
    habitNameController.dispose();
    habitDescriptionController.dispose();
    habitRepeatTypeController.dispose();
    habitRepeatDayController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  Future<void> addHabit() async {
    final String habitName = habitNameController.text;
    final String habitDescription = habitDescriptionController.text;
    final String habitRepeatType = habitRepeatTypeController.text;

    const String endpoint = 'http://43.203.208.152:3000/habit';

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
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3QiLCJzdWIiOjEsImlhdCI6MTcyMzAxNDIzMiwiZXhwIjoxNzIzMDE2MDMyfQ.Edy4Z3WQs96C5sz6O67HRFbtnxX_lDJs0BaZRs_lGT8',
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
    setState(
      () {
        if (repeatDays.contains(day)) {
          repeatDays.remove(day);
        } else {
          repeatDays.add(day);
        }
      },
    );
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
              InputWidget(
                habitNameController: habitNameController,
                labelName: '추가할 습관을 입력해주세요',
              ),
              const SizedBox(
                height: 20,
              ),
              InputWidget(
                  habitNameController: habitDescriptionController,
                  labelName: '설명을 입력해주세요'),
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
              SizedBox(
                height: 64,
                child: ElevatedButton(
                  style: const ButtonStyle(),
                  onPressed: addHabit,
                  child: const Text('습관 추가하기'),
                ),
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

class InputWidget extends StatefulWidget {
  const InputWidget({
    super.key,
    required this.habitNameController,
    required this.labelName,
  });

  final TextEditingController habitNameController;
  final String labelName;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  List<BoxShadow> focus = [
    const BoxShadow(
      color: Color(0x4C66D271),
      blurRadius: 24,
      offset: Offset(0, 0),
      spreadRadius: 0,
    )
  ];
  List<BoxShadow> done = [
    const BoxShadow(
      color: Color(0x99DBE5EC),
      blurRadius: 8,
      offset: Offset(0, 4),
      spreadRadius: 0,
    ),
    const BoxShadow(
      color: Color(0x99DBE5EC),
      blurRadius: 1,
      offset: Offset(0, 0),
      spreadRadius: 1,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 2,
                color:
                    _isFocused ? const Color(0xFF66D271) : Colors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: _isFocused ? focus : done),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: widget.habitNameController,
            focusNode: _focusNode,
            style: const TextStyle(
              color: Color(0xFF1F2329),
              fontSize: 13,
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w400,
              letterSpacing: -1.04,
            ),
            decoration: InputDecoration(
              hintText: widget.labelName,
              hintStyle: const TextStyle(
                color: Color(0xFF8C929D),
                fontSize: 13,
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.w400,
                height: 0,
                letterSpacing: -1.04,
              ),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
