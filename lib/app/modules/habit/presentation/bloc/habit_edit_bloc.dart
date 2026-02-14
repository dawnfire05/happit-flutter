import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/habit.dart';
import 'package:happit_flutter/app/modules/habit/domain/usecase/delete_habit_use_case.dart';
import 'package:happit_flutter/app/modules/habit/domain/usecase/get_habit_use_case.dart';
import 'package:happit_flutter/app/modules/habit/domain/usecase/update_habit_use_case.dart';
import 'package:injectable/injectable.dart';

part 'habit_edit_bloc.freezed.dart';

@injectable
class HabitEditBloc extends Bloc<HabitEditEvent, HabitEditState> {
  final GetHabitUseCase _getHabitUseCase;
  final UpdateHabitUseCase _updateHabitUseCase;
  final DeleteHabitUseCase _deleteHabitUseCase;

  HabitEditBloc(
      this._getHabitUseCase, this._updateHabitUseCase, this._deleteHabitUseCase)
      : super(const _Initial()) {
    on<_Load>((event, emit) async {
      emit(const _Loading());
      final result = await _getHabitUseCase(event.id);
      result.fold(
        (failure) => emit(_Error(failure.when(
          server: (m) => m,
          network: (m) => m,
          unknown: (m) => m,
        ))),
        (habit) => emit(_Loaded(
          habit: habit,
          repeatType: habit.repeatType,
          repeatDays: habit.repeatDay ?? [],
        )),
      );
    });
    on<_SelectRepeatType>((event, emit) {
      final current = state.mapOrNull(loaded: (s) => s);
      if (current == null) return;
      emit(current.copyWith(repeatType: event.type, repeatDays: []));
    });
    on<_ToggleDay>((event, emit) {
      final current = state.mapOrNull(loaded: (s) => s);
      if (current == null) return;
      final days = List<String>.from(current.repeatDays);
      days.contains(event.day) ? days.remove(event.day) : days.add(event.day);
      emit(current.copyWith(repeatDays: days));
    });
    on<_SelectColor>((event, emit) {
      final current = state.mapOrNull(loaded: (s) => s);
      if (current == null) return;
      emit(current.copyWith(colorIndex: event.index));
    });
    on<_Delete>((event, emit) async {
      emit(const _Loading());
      final result = await _deleteHabitUseCase(event.id);
      result.fold(
        (failure) => emit(_Error(failure.when(
          server: (m) => m,
          network: (m) => m,
          unknown: (m) => m,
        ))),
        (_) => emit(const _Success()),
      );
    });
    on<_Edit>((event, emit) async {
      emit(const _Loading());
      final result = await _updateHabitUseCase(
        event.id,
        name: event.name,
        description: event.description,
        repeatType: event.repeatType,
        repeatDay: event.repeatDay,
      );
      result.fold(
        (failure) => emit(_Error(failure.when(
          server: (m) => m,
          network: (m) => m,
          unknown: (m) => m,
        ))),
        (_) => emit(const _Success()),
      );
    });
  }
}

@freezed
sealed class HabitEditEvent with _$HabitEditEvent {
  const factory HabitEditEvent.load(int id) = _Load;
  const factory HabitEditEvent.selectRepeatType(String type) = _SelectRepeatType;
  const factory HabitEditEvent.toggleDay(String day) = _ToggleDay;
  const factory HabitEditEvent.selectColor(int index) = _SelectColor;
  const factory HabitEditEvent.delete(int id) = _Delete;
  const factory HabitEditEvent.edit(
    int id, {
    String? name,
    String? description,
    String? repeatType,
    List<String>? repeatDay,
  }) = _Edit;
}

@freezed
sealed class HabitEditState with _$HabitEditState {
  const factory HabitEditState.initial() = _Initial;
  const factory HabitEditState.loading() = _Loading;
  const factory HabitEditState.loaded({
    required Habit habit,
    @Default('daily') String repeatType,
    @Default([]) List<String> repeatDays,
    @Default(0) int colorIndex,
  }) = _Loaded;
  const factory HabitEditState.error(String error) = _Error;
  const factory HabitEditState.success() = _Success;
}
