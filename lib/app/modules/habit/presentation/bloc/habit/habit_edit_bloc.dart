import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/habit/data/model/habit_model.dart';
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
        emit(_Loaded(habit));
      } on Exception catch (e) {
        print(e.toString());
        emit(_Error(e.toString()));
      }
    });
    on<_Delete>((event, emit) async {
      emit(const _Loading());
      try {
        await _repository.deleteHabit(event.id);
        print('file deleted');
        emit(const _Success());
      } on Exception catch (e) {
        emit(_Error(e.toString()));
      }
    });
    on<_Edit>((event, emit) {
      emit(const _Loading());
      emit(const _Success());
    });
  }
}

@freezed
sealed class HabitEditEvent with _$HabitEditEvent {
  const factory HabitEditEvent.load(int id) = _Load;
  const factory HabitEditEvent.delete(int id) = _Delete;
  const factory HabitEditEvent.edit(
    String habitName,
    String habitDescription,
    String repeatType,
    List<String> repeatDays,
    // TimeOfDay selectedTime,
    int themeColor,
  ) = _Edit;
}

@freezed
sealed class HabitEditState with _$HabitEditState {
  const factory HabitEditState.initial() = _Initial;
  const factory HabitEditState.loading() = _Loading;
  const factory HabitEditState.loaded(HabitModel habit) = _Loaded;
  const factory HabitEditState.error(String error) = _Error;
  const factory HabitEditState.success() = _Success;
}
