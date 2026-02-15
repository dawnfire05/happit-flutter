import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/habit.dart';
import 'package:happit_flutter/app/modules/habit/domain/usecase/create_habit_use_case.dart';
import 'package:injectable/injectable.dart';

part 'habit_create_bloc.freezed.dart';

@injectable
class HabitCreateBloc extends Bloc<HabitCreateEvent, HabitCreateState> {
  final CreateHabitUseCase _createHabitUseCase;

  HabitCreateBloc(this._createHabitUseCase)
    : super(const HabitCreateState.form()) {
    on<_HabitNameChanged>((event, emit) {
      final current = state.mapOrNull(form: (s) => s);
      if (current == null) return;
      emit(current.copyWith(habitName: event.value));
    });
    on<_HabitDescriptionChanged>((event, emit) {
      final current = state.mapOrNull(form: (s) => s);
      if (current == null) return;
      emit(current.copyWith(habitDescription: event.value));
    });
    on<_NoticeTimeChanged>((event, emit) {
      final current = state.mapOrNull(form: (s) => s);
      if (current == null) return;
      emit(
        current.copyWith(noticeHour: event.hour, noticeMinute: event.minute),
      );
    });
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
      emit(current.copyWith(themeColor: event.color));
    });
    on<_Add>((event, emit) async {
      final form = state.mapOrNull(form: (s) => s);
      if (form == null) return;
      final result = await _createHabitUseCase(
        name: form.habitName,
        description: form.habitDescription,
        repeatType: form.repeatType,
        repeatDay: form.repeatDays,
        themeColor: form.themeColor,
      );
      result.fold(
        (failure) => emit(_Error(failureToMessage(failure))),
        (_) => emit(
          _Success(
            Habit(
              id: 0,
              name: form.habitName,
              description: form.habitDescription,
              repeatType: form.repeatType,
              repeatDay: form.repeatDays,
              themeColor: form.themeColor,
            ),
          ),
        ),
      );
    });
  }
}

@freezed
sealed class HabitCreateEvent with _$HabitCreateEvent {
  const factory HabitCreateEvent.habitNameChanged(String value) =
      _HabitNameChanged;
  const factory HabitCreateEvent.habitDescriptionChanged(String value) =
      _HabitDescriptionChanged;
  const factory HabitCreateEvent.noticeTimeChanged(int hour, int minute) =
      _NoticeTimeChanged;
  const factory HabitCreateEvent.selectRepeatType(String type) =
      _SelectRepeatType;
  const factory HabitCreateEvent.toggleDay(String day) = _ToggleDay;
  const factory HabitCreateEvent.selectColor(String color) = _SelectColor;
  const factory HabitCreateEvent.add() = _Add;
}

@freezed
sealed class HabitCreateState with _$HabitCreateState {
  const factory HabitCreateState.form({
    @Default('') String habitName,
    @Default('') String habitDescription,
    @Default(0) int noticeHour,
    @Default(0) int noticeMinute,
    @Default('daily') String repeatType,
    @Default([]) List<String> repeatDays,
    @Default('#66D271') String themeColor,
  }) = _Form;
  const factory HabitCreateState.error(String error) = _Error;
  const factory HabitCreateState.success(Habit habit) = _Success;
}
