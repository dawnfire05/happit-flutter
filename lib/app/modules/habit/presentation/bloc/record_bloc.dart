import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/record.dart';
import 'package:happit_flutter/app/modules/habit/domain/usecase/check_record_use_case.dart';
import 'package:happit_flutter/app/modules/habit/domain/usecase/get_records_use_case.dart';
import 'package:happit_flutter/app/modules/habit/domain/usecase/uncheck_record_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

part 'record_bloc.freezed.dart';

/// 한 습관의 기록 조회 + 오늘 완료/미완료 토글 전용.
/// 잔디 그리드 전체 데이터는 [GrassBloc](getGrass) 사용.
@injectable
class RecordBloc extends Bloc<RecordEvent, RecordState> {
  RecordBloc(
    this._getRecordsUseCase,
    this._checkRecordUseCase,
    this._uncheckRecordUseCase,
  ) : super(const Initial()) {
    on<Initialize>(_onInitialize);
    on<Get>(_onGet);
    on<Check>(_onCheck);
    on<Toggle>(_onToggle);
  }

  final GetRecordsUseCase _getRecordsUseCase;
  final CheckRecordUseCase _checkRecordUseCase;
  final UncheckRecordUseCase _uncheckRecordUseCase;

  /// Dashboard API로 이미 받은 데이터로 초기화 (API 호출 없음)
  Future<void> _onInitialize(Initialize event, Emitter<RecordState> emit) async {
    emit(_buildSuccess(event.records));
  }

  Future<void> _onGet(Get event, Emitter<RecordState> emit) async {
    emit(const Loading());
    final result = await _getRecordsUseCase(event.habitId);
    result.fold(
      (failure) => emit(Error(failureToMessage(failure))),
      (records) => emit(_buildSuccess(records)),
    );
  }

  Future<void> _onCheck(Check event, Emitter<RecordState> emit) async {
    final result = await _checkRecordUseCase(event.habitId);
    result.fold(
      (failure) => emit(Error(failureToMessage(failure))),
      (response) {
        // Streak 업데이트 콜백 호출
        event.onStreakUpdated?.call(response.updatedStreak);
        // Record 상태만 업데이트
        emit(RecordState.success([response.record], response.record.state));
      },
    );
  }

  /// 완료 상태면 미완료로, 미완료 상태면 완료로 토글. 즉시 UI 반영을 위해 낙관적 업데이트 후 API 호출.
  Future<void> _onToggle(Toggle event, Emitter<RecordState> emit) async {
    final todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final previousState = state;
    final wasDone = previousState.maybeWhen(
      success: (_, todayStatus) => todayStatus == 'done',
      orElse: () => false,
    );

    // 낙관적 업데이트: 기존 success 상태면 즉시 토글된 상태로 emit
    previousState.maybeWhen(
      success: (records, todayStatus) {
        final newStatus = todayStatus == 'done' ? 'notDone' : 'done';
        final optimisticRecords = _applyTodayState(
          records,
          event.habitId,
          todayStr,
          newStatus,
        );
        emit(RecordState.success(optimisticRecords, newStatus));
      },
      orElse: () {},
    );

    final result = wasDone
        ? await _uncheckRecordUseCase(event.habitId)
        : await _checkRecordUseCase(event.habitId);

    result.fold((failure) {
      // 실패 시 이전 상태로 복구 (사용자가 다시 시도 가능)
      if (previousState is Success) {
        emit(previousState);
      } else {
        emit(Error(failureToMessage(failure)));
      }
    }, (response) {
      // Streak 업데이트 콜백 호출
      event.onStreakUpdated?.call(response.updatedStreak);
      
      // 기존 records에 오늘 record만 업데이트
      previousState.maybeWhen(
        success: (records, _) {
          final updatedRecords = _applyTodayState(
            records,
            event.habitId,
            response.record.date,
            response.record.state,
          );
          emit(RecordState.success(updatedRecords, response.record.state));
        },
        orElse: () {
          emit(RecordState.success([response.record], response.record.state));
        },
      );
    });
  }

  List<Record> _applyTodayState(
    List<Record> records,
    int habitId,
    String todayStr,
    String newState,
  ) {
    final found = records.any((r) => r.date == todayStr);
    if (found) {
      return records
          .map(
            (r) => r.date == todayStr
                ? Record(
                    id: r.id,
                    date: r.date,
                    state: newState,
                    createdAt: r.createdAt,
                    updatedAt: r.updatedAt,
                  )
                : r,
          )
          .toList();
    }
    return [...records, Record(id: habitId, date: todayStr, state: newState)];
  }

  RecordState _buildSuccess(List<Record> records) {
    final map = {for (var r in records) r.date: r.state};
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return RecordState.success(records, map[today] ?? 'notDone');
  }
}

@freezed
sealed class RecordEvent with _$RecordEvent {
  const factory RecordEvent.initialize(List<Record> records) = Initialize;
  const factory RecordEvent.check(
    int habitId, {
    void Function(int updatedStreak)? onStreakUpdated,
  }) = Check;
  const factory RecordEvent.get(int habitId) = Get;
  const factory RecordEvent.toggle(
    int habitId, {
    void Function(int updatedStreak)? onStreakUpdated,
  }) = Toggle;
}

@freezed
sealed class RecordState with _$RecordState {
  const factory RecordState.initial() = Initial;
  const factory RecordState.loading() = Loading;
  const factory RecordState.error(String error) = Error;
  const factory RecordState.success(List<Record> records, String todayStatus) =
      Success;
}
