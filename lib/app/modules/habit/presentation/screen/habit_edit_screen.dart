import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/di/get_it.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/main_button.dart';
import 'package:happit_flutter/app/modules/habit/data/model/update_habit_model.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit/habit_bloc.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit/habit_edit_bloc.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_day_of_week_widget.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_notice_time_widget.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_text_widget.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_repeat_type_widget.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_theme_widget.dart';
import 'package:happit_flutter/routes/routes.dart';

class HabitEditScreen extends StatelessWidget {
  final int id;
  const HabitEditScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HabitEditBloc>()..add(HabitEditEvent.load(id)),
      child: _Layout(id: id),
    );
  }
}

class _Layout extends StatefulWidget {
  final int id;
  const _Layout({required this.id});

  @override
  State<_Layout> createState() => _LayoutState();
}

class _LayoutState extends State<_Layout> {
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
    return BlocListener<HabitEditBloc, HabitEditState>(
      listener: (context, state) {
        state.whenOrNull(
          loaded: (habit) {
            setState(() {
              _habitNameController.text = habit.name;
              _habitDescriptionController.text = habit.description;
              selectedRepeatType = habit.repeatType;
              print(selectedRepeatType);
              repeatDays = habit.repeatDay ?? [];
              // selectedTime =
              //     habit.noticeTime ?? const TimeOfDay(hour: 00, minute: 00);
              // themeColor = habit.themeColor ?? 0;
              selectedColorIndex = themeColor;
            });
          },
          success: () {
            getIt<HabitBloc>().add(const HabitEvent.get());
            const HabitListRoute().go(context);
          },
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
                Row(
                  children: [
                    Expanded(
                        child: MainButton.cta(
                            text: '습관 삭제하기',
                            onPressed: () {
                              context
                                  .read<HabitEditBloc>()
                                  .add(HabitEditEvent.delete(widget.id));
                            })),
                    const SizedBox(width: 24),
                    Expanded(
                      child: MainButton.cta(
                        text: '습관 수정하기',
                        onPressed: () => context.read<HabitEditBloc>().add(
                              HabitEditEvent.edit(
                                  widget.id,
                                  UpdateHabitModel(
                                    name: _habitNameController.text,
                                    description:
                                        _habitDescriptionController.text,
                                    repeatDay: repeatDays,
                                    repeatType: selectedRepeatType,
                                  )),
                            ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
