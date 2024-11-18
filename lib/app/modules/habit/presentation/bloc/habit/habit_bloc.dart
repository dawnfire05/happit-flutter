import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/habit/data/model/habit_model.dart';
import 'package:happit_flutter/app/modules/habit/data/repository/habit_repository.dart';
import 'package:injectable/injectable.dart';

part 'habit_bloc.freezed.dart';

@injectable
class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final HabitRepository _repository;

  HabitBloc(this._repository) : super(const _Initial()) {
    on<_Get>(
      (event, emit) async {
        try {
          emit(const _Loading());
          final habits = await _repository.getHabits();
          emit(_Success(habits));
        } on Exception catch (e) {
          emit(_Error(e.toString()));
          print(e);
        }
      },
    );
  }
}

@freezed
sealed class HabitEvent with _$HabitEvent {
  const factory HabitEvent.get() = _Get;
}

@freezed
class HabitState with _$HabitState {
  const factory HabitState.initial() = _Initial;
  const factory HabitState.loading() = _Loading;
  const factory HabitState.error(String error) = _Error;
  const factory HabitState.success(List<HabitModel> habits) = _Success;
}
