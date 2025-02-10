import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/habit/data/model/create_habit_model.dart';
import 'package:happit_flutter/app/modules/habit/data/repository/habit_repository.dart';
import 'package:injectable/injectable.dart';

part 'habit_create_bloc.freezed.dart';

@injectable
class HabitCreateBloc extends Bloc<HabitCreateEvent, HabitCreateState> {
  final HabitRepository _repository;

  HabitCreateBloc(this._repository) : super(const _Initial()) {
    on<_Add>((event, emit) async {
      try {
        await _repository.addHabit(
          CreateHabitModel(
            name: event.habitName,
            description: event.habitDescription,
            repeatType: event.repeatType,
            repeatDay: event.repeatDays,
            // noticeTime: event.selectedTime,
            themeColor: event.themeColor,
          ),
        );
        emit(const _Success());
      } catch (e) {
        log(e.toString());
        emit(_Error(e.toString()));
      }
    });
  }
}

@freezed
sealed class HabitCreateEvent with _$HabitCreateEvent {
  const factory HabitCreateEvent.add(
    String habitName,
    String habitDescription,
    String repeatType,
    List<String> repeatDays,
    // TimeOfDay selectedTime,
    int themeColor,
  ) = _Add;
}

@freezed
sealed class HabitCreateState with _$HabitCreateState {
  const factory HabitCreateState.initial() = _Initial;
  const factory HabitCreateState.error(String error) = _Error;
  const factory HabitCreateState.success() = _Success;
}
