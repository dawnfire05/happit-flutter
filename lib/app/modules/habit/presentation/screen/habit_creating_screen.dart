import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/di/get_it.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/main_button.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit_list_bloc.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit_create_bloc.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_day_of_week_widget.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_notice_time_widget.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_text_widget.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_repeat_type_widget.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_theme_widget.dart';
import 'package:happit_flutter/routes/routes.dart';

class HabitCreatingScreen extends StatelessWidget {
  const HabitCreatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HabitCreateBloc>(),
      child: BlocListener<HabitCreateBloc, HabitCreateState>(
        listenWhen: (prev, curr) =>
            curr.mapOrNull(error: (_) => true, success: (_) => true) ?? false,
        listener: (context, state) {
          state.map(
            form: (_) {},
            error: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('습관 추가에 실패했습니다: $error')),
              );
            },
            success: (successState) {
              context.read<HabitListBloc>().add(const HabitListEvent.get());
              HabitCreatedRoute(successState.habit).go(context);
            },
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              '습관 추가',
              style: TextStyle(
                color: Color(0xFF1F2329),
                fontSize: 18,
                fontFamily: 'Noto Sans KR',
                fontWeight: FontWeight.w700,
                height: 0,
                letterSpacing: -1.44,
              ),
            ),
          ),
          body: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
              child: BlocBuilder<HabitCreateBloc, HabitCreateState>(
                buildWhen: (prev, curr) {
                  final p = prev.mapOrNull(form: (s) => s);
                  final c = curr.mapOrNull(form: (s) => s);
                  return p != c;
                },
                builder: (context, state) {
                  final form = state.mapOrNull(form: (s) => s);
                  if (form == null) return const SizedBox.shrink();

                  final repeatType = form.repeatType;
                  final repeatDays = form.repeatDays;
                  final colorIndex = form.colorIndex;
                  final selectedTime = TimeOfDay(
                    hour: form.noticeHour,
                    minute: form.noticeMinute,
                  );

                  return Column(
                    children: [
                      InputTextWidget.basic(
                        value: form.habitName,
                        onChanged: (v) => context
                            .read<HabitCreateBloc>()
                            .add(HabitCreateEvent.habitNameChanged(v)),
                        hintText: '추가할 습관을 입력해주세요',
                      ),
                      const SizedBox(height: 20),
                      InputTextWidget.basic(
                        value: form.habitDescription,
                        onChanged: (v) => context
                            .read<HabitCreateBloc>()
                            .add(HabitCreateEvent.habitDescriptionChanged(v)),
                        hintText: '설명을 입력해주세요',
                      ),
                      const SizedBox(height: 20),
                      InputRepeatTypeWidget(
                        selectedRepeatType: repeatType,
                        onSelected: (value) => context
                            .read<HabitCreateBloc>()
                            .add(HabitCreateEvent.selectRepeatType(value)),
                      ),
                      const SizedBox(height: 20),
                      if (repeatType == 'weekly')
                        Column(
                          children: [
                            InputDayOfWeekWidget(
                              selectedDays: repeatDays,
                              onDaySelected: (day) => context
                                  .read<HabitCreateBloc>()
                                  .add(HabitCreateEvent.toggleDay(day)),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      InputNoticeTimeWidget(
                        selectedTime: selectedTime,
                        onTimeSelected: (newTime) => context
                            .read<HabitCreateBloc>()
                            .add(HabitCreateEvent.noticeTimeChanged(
                              newTime.hour,
                              newTime.minute,
                            )),
                      ),
                      const SizedBox(height: 20),
                      InputThemeWidget(
                        selectedColorIndex: colorIndex,
                        onThemeChanged: (index) => context
                            .read<HabitCreateBloc>()
                            .add(HabitCreateEvent.selectColor(index)),
                      ),
                      const SizedBox(height: 20),
                      MainButton.cta(
                        text: '습관 추가하기',
                        onPressed: () => context
                            .read<HabitCreateBloc>()
                            .add(const HabitCreateEvent.add()),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
