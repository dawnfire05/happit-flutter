import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/habit_with_grass.dart';
import 'package:happit_flutter/app/modules/habit/domain/usecase/get_dashboard_use_case.dart';
import 'package:injectable/injectable.dart';

part 'habit_list_bloc.freezed.dart';

@injectable
class HabitListBloc extends Bloc<HabitListEvent, HabitListState> {
  final GetDashboardUseCase _getDashboardUseCase;

  HabitListBloc(
    this._getDashboardUseCase,
  ) : super(const Initial()) {
    on<Get>(_onGet);
    on<UpdateHabitStreak>(_onUpdateHabitStreak);
  }

  Future<void> _onGet(Get event, Emitter<HabitListState> emit) async {
    // 이전 성공 데이터가 있으면 loading 상태에 포함
    final previousHabits = state is Success
        ? (state as Success).habitsWithGrass
        : null;

    emit(Loading(previousHabits: previousHabits));

    // 단일 API 호출로 습관 목록 + 기록 조회 (최근 3개월)
    final result = await _getDashboardUseCase(3);

    result.fold(
      (failure) => emit(Error(failureToMessage(failure))),
      (dashboard) => emit(Success(dashboard.habits)),
    );
  }

  /// Record toggle 후 특정 습관의 Streak만 업데이트 (전체 fetch 없음)
  Future<void> _onUpdateHabitStreak(
    UpdateHabitStreak event,
    Emitter<HabitListState> emit,
  ) async {
    if (state is! Success) return;

    final currentState = state as Success;
    final updatedHabits = currentState.habitsWithGrass.map((item) {
      if (item.habit.id == event.habitId) {
        return item.copyWith(
          habit: item.habit.copyWith(currentStreak: event.currentStreak),
        );
      }
      return item;
    }).toList();

    emit(Success(updatedHabits));
  }
}

@freezed
sealed class HabitListEvent with _$HabitListEvent {
  const factory HabitListEvent.get() = Get;
  const factory HabitListEvent.updateHabitStreak({
    required int habitId,
    required int currentStreak,
  }) = UpdateHabitStreak;
}

@freezed
sealed class HabitListState with _$HabitListState {
  const factory HabitListState.initial() = Initial;
  const factory HabitListState.loading({
    List<HabitWithGrass>? previousHabits,
  }) = Loading;
  const factory HabitListState.error(String error) = Error;
  const factory HabitListState.success(List<HabitWithGrass> habitsWithGrass) =
      Success;
}
