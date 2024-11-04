import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/main_button.dart';
import 'package:happit_flutter/app/modules/habit/data/repository/habit_repository.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit/habit_bloc.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_day_of_week_widget.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_notice_time_widget.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_text_widget.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_repeat_type_widget.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_theme_widget.dart';
import 'package:happit_flutter/routes/routes.dart';

class HabitCreatingScreen extends StatefulWidget {
  const HabitCreatingScreen({super.key});

  @override
  State<HabitCreatingScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<HabitCreatingScreen> {
  final TextEditingController habitNameController = TextEditingController();
  final TextEditingController habitDescriptionController =
      TextEditingController();
  String selectedRepeatType = 'daily';
  List<String> repeatDays = [];
  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);
  int themeColor = 0;
  int selectedColorIndex = 0;

  late HabitRepository _habitRepository;

  @override
  void initState() {
    super.initState();
    final dio = Dio(BaseOptions(headers: {'Content-Type': 'application/json'}));
    _habitRepository = HabitRepository(dio);
  }

  @override
  void dispose() {
    habitNameController.dispose();
    habitDescriptionController.dispose();
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

  void selectColor(int index) {
    setState(() {
      selectedColorIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HabitBloc>(
      create: (context) => HabitBloc(client: _habitRepository),
      child: BlocListener<HabitBloc, HabitState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            success: () {
              const HabitAddedRoute().push(context);
            },
            error: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('습관 추가에 실패했습니다: $error')),
              );
            },
          );
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('습관 추가')),
          body: Container(
            decoration: const BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      InputTextWidget(
                        habitNameController: habitNameController,
                        hintText: '추가할 습관을 입력해주세요',
                      ),
                      const SizedBox(height: 20),
                      InputTextWidget(
                        habitNameController: habitDescriptionController,
                        hintText: '설명을 입력해주세요',
                      ),
                      const SizedBox(height: 20),
                      InputRepeatTypeWidget(
                          selectedRepeatType: selectedRepeatType,
                          onSelected: (value) =>
                              setState(() => selectedRepeatType = value)),
                      const SizedBox(height: 20),
                      if (selectedRepeatType == 'weekly')
                        Column(
                          children: [
                            InputDayOfWeekWidget(
                              selectedDays: repeatDays,
                              onDaySelected: addDayOfWeek,
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      InputNoticeTimeWidget(
                          selectedTime: selectedTime,
                          onTimeSelected: (newTime) =>
                              setState(() => selectedTime = newTime)),
                      const SizedBox(height: 20),
                      InputThemeWidget(
                        selectedColorIndex: selectedColorIndex,
                        onThemeChanged: selectColor,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  Builder(
                    builder: (context) {
                      return MainButton(
                        text: '습관 추가하기',
                        onPressed: () {
                          context.read<HabitBloc>().add(
                                HabitEvent.add(
                                  habitNameController.text,
                                  habitDescriptionController.text,
                                  selectedRepeatType,
                                  repeatDays,
                                  selectedTime,
                                  themeColor,
                                ),
                              );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}