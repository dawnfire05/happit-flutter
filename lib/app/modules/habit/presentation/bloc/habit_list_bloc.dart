import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/habit.dart';
import 'package:happit_flutter/app/modules/habit/domain/usecase/get_habits_use_case.dart';
import 'package:injectable/injectable.dart';

part 'habit_list_bloc.freezed.dart';

@injectable
class HabitListBloc extends Bloc<HabitListEvent, HabitListState> {
  final GetHabitsUseCase _getHabitsUseCase;

  HabitListBloc(this._getHabitsUseCase) : super(const Initial()) {
    on<Get>((event, emit) async {
      // 이전 성공 데이터가 있으면 loading 상태에 포함
      final previousHabits = state is Success
          ? (state as Success).habits
          : null;

      emit(Loading(previousHabits: previousHabits));
      final result = await _getHabitsUseCase();
      result.fold(
        (failure) => emit(Error(failureToMessage(failure))),
        (habits) => emit(Success(habits)),
      );
    });
  }
}

@freezed
sealed class HabitListEvent with _$HabitListEvent {
  const factory HabitListEvent.get() = Get;
}

@freezed
sealed class HabitListState with _$HabitListState {
  const factory HabitListState.initial() = Initial;
  const factory HabitListState.loading({List<Habit>? previousHabits}) = Loading;
  const factory HabitListState.error(String error) = Error;
  const factory HabitListState.success(List<Habit> habits) = Success;
}
