import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  final TextEditingController habitRepeatDayController =
      TextEditingController();
  List<String> repeatDays = [];
  int themeColor = 0;
  final FocusNode myFocusNode = FocusNode();
  List<String> repeatTypes = ['매일', '요일별'];
  String habitRepeatType = 'daily';

  @override
  void dispose() {
    habitNameController.dispose();
    habitDescriptionController.dispose();
    habitRepeatDayController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  Future<void> addHabit() async {
    final String habitName = habitNameController.text;
    final String habitDescription = habitDescriptionController.text;

    // Map<String, String> repeatType = {
    //   '매일': 'daily',
    //   '요일별': 'weekly',
    // };

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
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3QiLCJzdWIiOjEsImlhdCI6MTcyMzAxOTQ0NywiZXhwIjoxNzIzMDIzMDQ3fQ.gIdPicoMDNukh3-yu5okPH8uWviG89ddG-2Rrfwv3FM',
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
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  InputWidget(
                    habitNameController: habitNameController,
                    hintText: '추가할 습관을 입력해주세요',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputWidget(
                      habitNameController: habitDescriptionController,
                      hintText: '설명을 입력해주세요'),
                  // DropdownButton<String>(
                  //     value: habitRepeatType,
                  //     items: repeatTypes.map(
                  //       (String items) {
                  //         return DropdownMenuItem<String>(
                  //           value: items,
                  //           child: Text(items),
                  //         );
                  //       },
                  //     ).toList(),
                  //     onChanged: (String? newValue) {
                  //       habitRepeatType = newValue!;
                  //     }),
                  const SizedBox(height: 20),
                  _selectDayOfWeek(),
                  const SizedBox(height: 20),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    height: 56,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x99DBE5EC),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Color(0x99DBE5EC),
                          blurRadius: 1,
                          offset: Offset(0, 0),
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '테마 색상',
                          style: TextStyle(
                            color: Color(0xFF8C929D),
                            fontSize: 13,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w400,
                            height: 0,
                            letterSpacing: -1.04,
                          ),
                        ),
                        Wrap(
                          spacing: 12,
                          children: [
                            _buildColorThemeContainer(const Color(0xff66D271)),
                            _buildColorThemeContainer(const Color(0xff7D5BA6)),
                            _buildColorThemeContainer(const Color(0xffFC6471)),
                            _buildColorThemeContainer(const Color(0xffF8C630)),
                            _buildColorThemeContainer(const Color(0xff30C5FF))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                height: 64,
                decoration: ShapeDecoration(
                    color: const Color(0xff66D271),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x4C66D271),
                        blurRadius: 24,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      )
                    ]),
                child: TextButton(
                  style: const ButtonStyle(),
                  onPressed: addHabit,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '습관 추가하기',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: -1.28,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorThemeContainer(Color color) {
    bool isChecked = true;
    return TapRegion(
      onTapInside: (event) => {!isChecked},
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: ShapeDecoration(
              shadows: const [
                BoxShadow(
                  color: Color(0x99DBE5EC),
                  blurRadius: 24,
                  offset: Offset(0, 8),
                  spreadRadius: 0,
                )
              ],
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Visibility(
            visible: isChecked,
            child: SvgPicture.asset(
              'assets/icons/Check.svg',
            ),
          )
        ],
      ),
    );
  }

  Container _selectDayOfWeek() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x99DBE5EC),
              blurRadius: 8,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0x99DBE5EC),
              blurRadius: 1,
              offset: Offset(0, 0),
              spreadRadius: 1,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }

  Widget _buildDayButton(String label, String day) {
    return Container(
      height: 36,
      width: 36,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: repeatDays.contains(day)
            ? const Color(0xff66D271)
            : Colors.transparent,
      ),
      child: TextButton(
        onPressed: () => addDayOfWeek(day),
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: repeatDays.contains(day)
                ? Colors.white
                : const Color(0xff8C929D),
            fontSize: 15,
            fontFamily: 'Noto Sans KR',
            fontWeight: FontWeight.w400,
            height: 0,
            letterSpacing: -1.20,
          ),
        ),
      ),
    );
  }
}

class InputWidget extends StatefulWidget {
  const InputWidget({
    super.key,
    required this.habitNameController,
    required this.hintText,
  });

  final TextEditingController habitNameController;
  final String hintText;

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
              fontFamily: 'Noto Sans KR',
              fontWeight: FontWeight.w400,
              letterSpacing: -1.04,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Color(0xFF8C929D),
                fontSize: 13,
                fontFamily: 'Noto Sans KR',
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
