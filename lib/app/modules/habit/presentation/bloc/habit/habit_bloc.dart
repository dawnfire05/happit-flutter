import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/habit/data/model/create_habit_model.dart';
import 'package:happit_flutter/app/modules/habit/data/repository/habit_repository.dart';

part 'habit_bloc.freezed.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final HabitRepository client;

  HabitBloc({required this.client}) : super(const HabitState.initial()) {
    on<_Add>((event, emit) async {
      try {
        await client.addHabit(
          CreateHabitModel(
              name: event.habitName,
              description: event.habitDescription,
              repeatType: event.repeatType,
              repeatDay: event.repeatDays),
        );
        emit(const _Success());
      } catch (e) {
        emit(_Error(e.toString()));
      }
    });
  }
}

@freezed
sealed class HabitEvent with _$HabitEvent {
  const factory HabitEvent.add(
    String habitName,
    String habitDescription,
    String repeatType,
    List<String> repeatDays,
    TimeOfDay selectedTime,
    int themeColor,
  ) = _Add;
}

@freezed
sealed class HabitState with _$HabitState {
  const factory HabitState.initial() = _Initial;
  const factory HabitState.error(String error) = _Error;
  const factory HabitState.success() = _Success;
}
