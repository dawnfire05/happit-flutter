import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happit_flutter/app/modules/common/widgets/main_button.dart';
import 'package:happit_flutter/app/modules/habit/presentation/blocs/habit/habit_bloc.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widgets/input_widget.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widgets/select_repeat_type_widget.dart';

class HabitAddScreen extends StatefulWidget {
  const HabitAddScreen({super.key});

  @override
  State<HabitAddScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<HabitAddScreen> {
  final TextEditingController habitNameController = TextEditingController();
  final TextEditingController habitDescriptionController =
      TextEditingController();

  String selectedRepeatType = 'daily';
  List<String> repeatDays = [];
  TimeOfDay? picked;
  int themeColor = 0;

  final FocusNode myFocusNode = FocusNode();
  List<String> repeatTypes = ['매일', '요일별'];

  int selectedColorIndex = 0;

  @override
  void dispose() {
    habitNameController.dispose();
    habitDescriptionController.dispose();
    myFocusNode.dispose();
    super.dispose();
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

  void selectColor(int index, Color color) {
    setState(() {
      selectedColorIndex = index;
      themeColor = color.value; // Save the color value as int
    });
  }

  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);

  // 메인
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HabitBloc>(
      create: (context) => HabitBloc(),
      child: Scaffold(
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
                    const SizedBox(height: 20),
                    const SelectRepeatTypeWidget(),
                    const SizedBox(height: 20),
                    _selectDayOfWeek(),
                    const SizedBox(height: 20),
                    selectNoticeTime(context),
                    const SizedBox(height: 20),
                    _selectTheme(),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Builder(builder: (context) {
                  return MainButton(
                    text: '습관 추가하기',
                    onPressed: () => context.read<HabitBloc>().add(
                          AddHabitEvent(
                            habitName: habitNameController.text,
                            habitDescription: habitDescriptionController.text,
                            repeatType: selectedRepeatType,
                            repeatDays: repeatDays,
                            selectedTime: selectedTime,
                            themeColor: themeColor,
                          ),
                        ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container selectNoticeTime(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
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
          const Expanded(
            flex: 1,
            child: Text(
              '알림 시각',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Noto Sans KR',
                fontWeight: FontWeight.w400,
                height: 0,
                letterSpacing: -1.04,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  child: Text(
                    selectedTime.format(context),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  onPressed: () async {
                    //   final picked = await showTimePicker(
                    //     context: context,
                    //     initialTime: selectedTime,
                    //   );
                    //   if (picked != null && picked != selectedTime) {
                    //     context
                    //         .watch<HabitBloc>()
                    //         .state
                    //         .copyWith(selectedTime: picked);
                    //     setState(() {
                    //       selectedTime = picked;
                    //       print("wowwowwow $selectedTime");
                    //     });
                    //   }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _selectTheme() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
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
              color: Colors.black,
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
              _buildColorThemeContainer(0, const Color(0xff66D271)),
              _buildColorThemeContainer(1, const Color(0xff7D5BA6)),
              _buildColorThemeContainer(2, const Color(0xffFC6471)),
              _buildColorThemeContainer(3, const Color(0xffF8C630)),
              _buildColorThemeContainer(4, const Color(0xff30C5FF))
            ],
          )
        ],
      ),
    );
  }

  Widget _buildColorThemeContainer(int index, Color color) {
    bool isSelected =
        selectedColorIndex == index; // Check if the color is selected
    return GestureDetector(
      onTap: () => selectColor(index, color),
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
            visible: isSelected, // Change visibility based on selection
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
