import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
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
        (failure) => emit(_Error(failureToMessage(failure))),
        (habit) => emit(_Loaded(
          habit: habit,
          name: habit.name,
          description: habit.description,
          repeatType: habit.repeatType,
          repeatDays: habit.repeatDay ?? [],
          themeColor: habit.themeColor,
        )),
      );
    });
    on<_NameChanged>((event, emit) {
      final current = state.mapOrNull(loaded: (s) => s);
      if (current == null) return;
      emit(current.copyWith(name: event.value));
    });
    on<_DescriptionChanged>((event, emit) {
      final current = state.mapOrNull(loaded: (s) => s);
      if (current == null) return;
      emit(current.copyWith(description: event.value));
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
      emit(current.copyWith(themeColor: event.color));
    });
    on<_Delete>((event, emit) async {
      emit(const _Loading());
      final result = await _deleteHabitUseCase(event.id);
      result.fold(
        (failure) => emit(_Error(failureToMessage(failure))),
        (_) => emit(const _Success()),
      );
    });
    on<_Edit>((event, emit) async {
      final loaded = state.mapOrNull(loaded: (s) => s);
      if (loaded == null) return;
      emit(const _Loading());
      final result = await _updateHabitUseCase(
        event.id,
        name: loaded.name,
        description: loaded.description,
        repeatType: loaded.repeatType,
        repeatDay: loaded.repeatDays,
        themeColor: loaded.themeColor,
      );
      result.fold(
        (failure) => emit(_Error(failureToMessage(failure))),
        (_) => emit(const _Success()),
      );
    });
  }
}

@freezed
sealed class HabitEditEvent with _$HabitEditEvent {
  const factory HabitEditEvent.load(int id) = _Load;
  const factory HabitEditEvent.nameChanged(String value) = _NameChanged;
  const factory HabitEditEvent.descriptionChanged(String value) =
      _DescriptionChanged;
  const factory HabitEditEvent.selectRepeatType(String type) = _SelectRepeatType;
  const factory HabitEditEvent.toggleDay(String day) = _ToggleDay;
  const factory HabitEditEvent.selectColor(String color) = _SelectColor;
  const factory HabitEditEvent.delete(int id) = _Delete;
  const factory HabitEditEvent.edit(int id) = _Edit;
}

@freezed
sealed class HabitEditState with _$HabitEditState {
  const factory HabitEditState.initial() = _Initial;
  const factory HabitEditState.loading() = _Loading;
  const factory HabitEditState.loaded({
    required Habit habit,
    @Default('') String name,
    @Default('') String description,
    @Default('daily') String repeatType,
    @Default([]) List<String> repeatDays,
    @Default('#66D271') String themeColor,
  }) = _Loaded;
  const factory HabitEditState.error(String error) = _Error;
  const factory HabitEditState.success() = _Success;
}
