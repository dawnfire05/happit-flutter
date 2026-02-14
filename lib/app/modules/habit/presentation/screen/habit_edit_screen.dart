import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/di/get_it.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/main_button.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit_list_bloc.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit_edit_bloc.dart';
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
      create: (context) => sl<HabitEditBloc>()..add(HabitEditEvent.load(id)),
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

  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);
  bool _controllersInitialized = false;

  @override
  void dispose() {
    _habitNameController.dispose();
    _habitDescriptionController.dispose();
    _habitNameFocusNode.dispose();
    _habitDescriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HabitEditBloc, HabitEditState>(
      listener: (context, state) {
        state.whenOrNull(
          loaded: (habit, repeatType, repeatDays, colorIndex) {
            if (!_controllersInitialized) {
              _habitNameController.text = habit.name;
              _habitDescriptionController.text = habit.description;
              _controllersInitialized = true;
            }
          },
          success: () {
            context.read<HabitListBloc>().add(const HabitListEvent.get());
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
          color: Colors.white,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
            child: BlocBuilder<HabitEditBloc, HabitEditState>(
              builder: (context, state) {
                final loaded = state.mapOrNull(loaded: (s) => s);
                final repeatType = loaded?.repeatType ?? 'daily';
                final repeatDays = loaded?.repeatDays ?? [];
                final colorIndex = loaded?.colorIndex ?? 0;

                return Column(
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
                        selectedRepeatType: repeatType,
                        onSelected: (value) => context
                            .read<HabitEditBloc>()
                            .add(HabitEditEvent.selectRepeatType(value))),
                    const SizedBox(height: 20),
                    if (repeatType == 'weekly')
                      Column(
                        children: [
                          InputDayOfWeekWidget(
                            selectedDays: repeatDays,
                            onDaySelected: (day) => context
                                .read<HabitEditBloc>()
                                .add(HabitEditEvent.toggleDay(day)),
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
                      selectedColorIndex: colorIndex,
                      onThemeChanged: (index) => context
                          .read<HabitEditBloc>()
                          .add(HabitEditEvent.selectColor(index)),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                            child: MainButton.destructive(
                                text: '삭제',
                                onPressed: () {
                                  context
                                      .read<HabitEditBloc>()
                                      .add(HabitEditEvent.delete(widget.id));
                                })),
                        const SizedBox(width: 24),
                        Expanded(
                          child: MainButton.cta(
                            text: '수정 완료',
                            onPressed: () =>
                                context.read<HabitEditBloc>().add(
                                      HabitEditEvent.edit(
                                        widget.id,
                                        name: _habitNameController.text,
                                        description:
                                            _habitDescriptionController.text,
                                        repeatDay: repeatDays,
                                        repeatType: repeatType,
                                      ),
                                    ),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
