import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/habit.dart';
import 'package:happit_flutter/app/modules/habit/domain/usecase/get_habits_use_case.dart';
import 'package:injectable/injectable.dart';

part 'habit_list_bloc.freezed.dart';

@injectable
class HabitListBloc extends Bloc<HabitListEvent, HabitListState> {
  final GetHabitsUseCase _getHabitsUseCase;

  HabitListBloc(this._getHabitsUseCase) : super(const _Initial()) {
    on<_Get>(
      (event, emit) async {
        emit(const _Loading());
        final result = await _getHabitsUseCase();
        result.fold(
          (failure) => emit(_Error(failure.when(
            server: (m) => m,
            network: (m) => m,
            unknown: (m) => m,
          ))),
          (habits) => emit(_Success(habits)),
        );
      },
    );
  }
}

@freezed
sealed class HabitListEvent with _$HabitListEvent {
  const factory HabitListEvent.get() = _Get;
}

@freezed
class HabitListState with _$HabitListState {
  const factory HabitListState.initial() = _Initial;
  const factory HabitListState.loading() = _Loading;
  const factory HabitListState.error(String error) = _Error;
  const factory HabitListState.success(List<Habit> habits) = _Success;
}
