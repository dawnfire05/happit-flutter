import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/modules/habit/data/habit.dart';

part 'habit_event.dart';
part 'habit_state.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  HabitBloc() : super(HabitState.initial()) {
    on<AddHabitEvent>((event, emit) {
      addHabit(
        event.habitName,
        event.habitDescription,
        event.repeatType,
        event.repeatDays,
        event.themeColor,
      );
    });
  }
}
