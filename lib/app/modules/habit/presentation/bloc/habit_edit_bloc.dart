import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/habit/data/model/habit_model.dart';
import 'package:happit_flutter/app/modules/habit/data/model/update_habit_model.dart';
import 'package:happit_flutter/app/modules/habit/data/repository/habit_repository.dart';
import 'package:injectable/injectable.dart';

part 'habit_edit_bloc.freezed.dart';

@injectable
class HabitEditBloc extends Bloc<HabitEditEvent, HabitEditState> {
  final HabitRepository _repository;
  HabitEditBloc(this._repository) : super(const _Initial()) {
    on<_Load>((event, emit) async {
      emit(const _Loading());
      try {
        final habit = await _repository.getHabit(event.id);
        emit(_Loaded(
          habit: habit,
          repeatType: habit.repeatType,
          repeatDays: habit.repeatDay ?? [],
        ));
      } on Exception catch (e) {
        emit(_Error(e.toString()));
      }
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
      try {
        await _repository.deleteHabit(event.id);
        emit(const _Success());
      } on Exception catch (e) {
        emit(_Error(e.toString()));
      }
    });
    on<_Edit>((event, emit) async {
      emit(const _Loading());
      try {
        await _repository.updateHabit(event.id, event.habit);
        emit(const _Success());
      } on Exception catch (e) {
        emit(_Error(e.toString()));
      }
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
  const factory HabitEditEvent.edit(int id, UpdateHabitModel habit) = _Edit;
}

@freezed
sealed class HabitEditState with _$HabitEditState {
  const factory HabitEditState.initial() = _Initial;
  const factory HabitEditState.loading() = _Loading;
  const factory HabitEditState.loaded({
    required HabitModel habit,
    @Default('daily') String repeatType,
    @Default([]) List<String> repeatDays,
    @Default(0) int colorIndex,
  }) = _Loaded;
  const factory HabitEditState.error(String error) = _Error;
  const factory HabitEditState.success() = _Success;
}
