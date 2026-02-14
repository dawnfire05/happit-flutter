import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/habit.dart';
import 'package:happit_flutter/app/modules/habit/domain/usecase/create_habit_use_case.dart';
import 'package:injectable/injectable.dart';

part 'habit_create_bloc.freezed.dart';

@injectable
class HabitCreateBloc extends Bloc<HabitCreateEvent, HabitCreateState> {
  final CreateHabitUseCase _createHabitUseCase;

  HabitCreateBloc(this._createHabitUseCase)
      : super(const HabitCreateState.form()) {
    on<_SelectRepeatType>((event, emit) {
      final current = state.mapOrNull(form: (s) => s);
      if (current == null) return;
      emit(current.copyWith(repeatType: event.type, repeatDays: []));
    });
    on<_ToggleDay>((event, emit) {
      final current = state.mapOrNull(form: (s) => s);
      if (current == null) return;
      final days = List<String>.from(current.repeatDays);
      days.contains(event.day) ? days.remove(event.day) : days.add(event.day);
      emit(current.copyWith(repeatDays: days));
    });
    on<_SelectColor>((event, emit) {
      final current = state.mapOrNull(form: (s) => s);
      if (current == null) return;
      emit(current.copyWith(colorIndex: event.index));
    });
    on<_Add>((event, emit) async {
      final result = await _createHabitUseCase(
        name: event.habitName,
        description: event.habitDescription,
        repeatType: event.repeatType,
        repeatDay: event.repeatDays,
        themeColor: event.themeColor,
      );
      result.fold(
        (failure) => emit(_Error(failure.when(
          server: (m) => m,
          network: (m) => m,
          unknown: (m) => m,
        ))),
        (_) => emit(_Success(Habit(
          id: 0,
          name: event.habitName,
          description: event.habitDescription,
          repeatType: event.repeatType,
          repeatDay: event.repeatDays,
        ))),
      );
    });
  }
}

@freezed
sealed class HabitCreateEvent with _$HabitCreateEvent {
  const factory HabitCreateEvent.selectRepeatType(String type) =
      _SelectRepeatType;
  const factory HabitCreateEvent.toggleDay(String day) = _ToggleDay;
  const factory HabitCreateEvent.selectColor(int index) = _SelectColor;
  const factory HabitCreateEvent.add(
    String habitName,
    String habitDescription,
    String repeatType,
    List<String> repeatDays,
    int themeColor,
  ) = _Add;
}

@freezed
sealed class HabitCreateState with _$HabitCreateState {
  const factory HabitCreateState.form({
    @Default('daily') String repeatType,
    @Default([]) List<String> repeatDays,
    @Default(0) int colorIndex,
  }) = _Form;
  const factory HabitCreateState.error(String error) = _Error;
  const factory HabitCreateState.success(Habit habit) = _Success;
}
