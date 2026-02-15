import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/habit_with_grass.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/record.dart';
import 'package:happit_flutter/app/modules/habit/domain/usecase/get_grass_use_case.dart';
import 'package:happit_flutter/app/modules/habit/domain/usecase/get_habits_use_case.dart';
import 'package:injectable/injectable.dart';

part 'habit_list_bloc.freezed.dart';

@injectable
class HabitListBloc extends Bloc<HabitListEvent, HabitListState> {
  final GetHabitsUseCase _getHabitsUseCase;
  final GetGrassUseCase _getGrassUseCase;

  HabitListBloc(
    this._getHabitsUseCase,
    this._getGrassUseCase,
  ) : super(const Initial()) {
    on<Get>(_onGet);
  }

  Future<void> _onGet(Get event, Emitter<HabitListState> emit) async {
    // 이전 성공 데이터가 있으면 loading 상태에 포함
    final previousHabits = state is Success
        ? (state as Success).habitsWithGrass
        : null;

    emit(Loading(previousHabits: previousHabits));

    // Habit 목록과 Grass 데이터를 병렬로 가져오기
    final habitsResult = await _getHabitsUseCase();
    final grassResult = await _getGrassUseCase(3); // 최근 3개월

    // 두 결과를 결합
    final combined = habitsResult.fold(
      (failure) => throw failure,
      (habits) => grassResult.fold(
        (failure) => throw failure,
        (grassList) {
          // Habit과 Grass를 habitId로 매핑
          final grassMap = <int, List<Record>>{};
          for (final grass in grassList) {
            grassMap[grass.habitId] = grass.records
                .map((r) => Record(
                      id: grass.habitId,
                      date: r.date,
                      state: r.state,
                    ))
                .toList();
          }

          // HabitWithGrass 리스트 생성
          return habits
              .map((habit) => HabitWithGrass(
                    habit: habit,
                    grassRecords: grassMap[habit.id],
                  ))
              .toList();
        },
      ),
    );

    try {
      emit(Success(combined));
    } catch (e) {
      if (e is Failure) {
        emit(Error(failureToMessage(e)));
      } else {
        emit(const Error('알 수 없는 오류가 발생했습니다.'));
      }
    }
  }
}

@freezed
sealed class HabitListEvent with _$HabitListEvent {
  const factory HabitListEvent.get() = Get;
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
