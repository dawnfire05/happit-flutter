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
    on<HabitNameChanged>((event, emit) {
      final current = state.mapOrNull(form: (s) => s);
      if (current == null) return;
      emit(current.copyWith(habitName: event.value));
    });
    on<HabitDescriptionChanged>((event, emit) {
      final current = state.mapOrNull(form: (s) => s);
      if (current == null) return;
      emit(current.copyWith(habitDescription: event.value));
    });
    on<NoticeTimeChanged>((event, emit) {
      final current = state.mapOrNull(form: (s) => s);
      if (current == null) return;
      emit(
        current.copyWith(noticeHour: event.hour, noticeMinute: event.minute),
      );
    });
    on<SelectRepeatType>((event, emit) {
      final current = state.mapOrNull(form: (s) => s);
      if (current == null) return;
      emit(current.copyWith(repeatType: event.type, repeatDays: []));
    });
    on<ToggleDay>((event, emit) {
      final current = state.mapOrNull(form: (s) => s);
      if (current == null) return;
      final days = List<String>.from(current.repeatDays);
      days.contains(event.day) ? days.remove(event.day) : days.add(event.day);
      emit(current.copyWith(repeatDays: days));
    });
    on<SelectColor>((event, emit) {
      final current = state.mapOrNull(form: (s) => s);
      if (current == null) return;
      emit(current.copyWith(themeColor: event.color));
    });
    on<Add>((event, emit) async {
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
        (failure) => emit(Error(failureToMessage(failure))),
        (_) => emit(
          Success(
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
      HabitNameChanged;
  const factory HabitCreateEvent.habitDescriptionChanged(String value) =
      HabitDescriptionChanged;
  const factory HabitCreateEvent.noticeTimeChanged(int hour, int minute) =
      NoticeTimeChanged;
  const factory HabitCreateEvent.selectRepeatType(String type) =
      SelectRepeatType;
  const factory HabitCreateEvent.toggleDay(String day) = ToggleDay;
  const factory HabitCreateEvent.selectColor(String color) = SelectColor;
  const factory HabitCreateEvent.add() = Add;
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
  }) = Form;
  const factory HabitCreateState.error(String error) = Error;
  const factory HabitCreateState.success(Habit habit) = Success;
}
