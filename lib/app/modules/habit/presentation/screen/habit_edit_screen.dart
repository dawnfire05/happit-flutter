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
      child: BlocListener<HabitEditBloc, HabitEditState>(
        listenWhen: (prev, curr) =>
            curr.mapOrNull(success: (_) => true, error: (_) => true) ?? false,
        listener: (context, state) {
          state.map(
            initial: (_) {},
            loading: (_) {},
            loaded: (_) {},
            error: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('습관 수정에 실패했습니다: $error')),
              );
            },
            success: (_) {
              context.read<HabitListBloc>().add(const HabitListEvent.get());
              const HabitListRoute().go(context);
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
                buildWhen: (prev, curr) {
                  final p = prev.mapOrNull(loaded: (s) => s);
                  final c = curr.mapOrNull(loaded: (s) => s);
                  return p != c;
                },
                builder: (context, state) {
                  final loaded = state.mapOrNull(loaded: (s) => s);
                  if (loaded == null) {
                    return state.mapOrNull(loading: (_) => true) ?? false
                        ? const Center(child: CircularProgressIndicator())
                        : const SizedBox.shrink();
                  }

                  final repeatType = loaded.repeatType;
                  final repeatDays = loaded.repeatDays;
                  final colorIndex = loaded.colorIndex;
                  const selectedTime = TimeOfDay(hour: 0, minute: 0);

                  return Column(
                    children: [
                      InputTextWidget.basic(
                        value: loaded.name,
                        onChanged: (v) => context
                            .read<HabitEditBloc>()
                            .add(HabitEditEvent.nameChanged(v)),
                        hintText: '추가할 습관을 입력해주세요',
                      ),
                      const SizedBox(height: 20),
                      InputTextWidget.basic(
                        value: loaded.description,
                        onChanged: (v) => context
                            .read<HabitEditBloc>()
                            .add(HabitEditEvent.descriptionChanged(v)),
                        hintText: '설명을 입력해주세요',
                      ),
                      const SizedBox(height: 20),
                      InputRepeatTypeWidget(
                        selectedRepeatType: repeatType,
                        onSelected: (value) => context
                            .read<HabitEditBloc>()
                            .add(HabitEditEvent.selectRepeatType(value)),
                      ),
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
                        onTimeSelected: (_) {},
                      ),
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
                              onPressed: () => context
                                  .read<HabitEditBloc>()
                                  .add(HabitEditEvent.delete(id)),
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: MainButton.cta(
                              text: '수정 완료',
                              onPressed: () => context
                                  .read<HabitEditBloc>()
                                  .add(HabitEditEvent.edit(id)),
                            ),
                          ),
                        ],
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
