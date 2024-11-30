import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/di/get_it.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/main_button.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit/habit_create_bloc.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_day_of_week_widget.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_notice_time_widget.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_text_widget.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_repeat_type_widget.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_theme_widget.dart';
import 'package:happit_flutter/routes/routes.dart';

class HabitEditScreen extends StatefulWidget {
  const HabitEditScreen({super.key});

  @override
  State<HabitEditScreen> createState() => _HabitEditScreenState();
}

class _HabitEditScreenState extends State<HabitEditScreen> {
  final TextEditingController _habitNameController = TextEditingController();
  final TextEditingController _habitDescriptionController =
      TextEditingController();
  final FocusNode _habitNameFocusNode = FocusNode();
  final FocusNode _habitDescriptionFocusNode = FocusNode();

  String selectedRepeatType = 'daily';
  List<String> repeatDays = [];
  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);
  int themeColor = 0;
  int selectedColorIndex = 0;

  @override
  void dispose() {
    _habitNameController.dispose();
    _habitDescriptionController.dispose();
    _habitNameFocusNode.dispose();
    _habitDescriptionFocusNode.dispose();
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
    setState(() => selectedColorIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HabitCreateBloc>(
      create: (context) => getIt<HabitCreateBloc>(),
      child: BlocListener<HabitCreateBloc, HabitCreateState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            success: () => const HabitAddedRoute().push(context),
            error: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('습관 수정에 실패했습니다: $error')),
              );
            },
          );
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('습관 수정')),
          body: Container(
            decoration: const BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      InputTextWidget.basic(
                        controller: _habitNameController,
                        focusNode: _habitNameFocusNode,
                        hintText: '추가할 습관을 입력해주세요',
                      ),
                      const SizedBox(height: 20),
                      InputTextWidget.basic(
                        controller: _habitDescriptionController,
                        focusNode: _habitDescriptionFocusNode,
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
                      return MainButton.cta(
                          text: '습관 수정하기',
                          onPressed: () => context.read<HabitCreateBloc>().add(
                                HabitCreateEvent.add(
                                  _habitNameController.text,
                                  _habitDescriptionController.text,
                                  selectedRepeatType,
                                  repeatDays,
                                  // selectedTime,
                                  themeColor,
                                ),
                              ));
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