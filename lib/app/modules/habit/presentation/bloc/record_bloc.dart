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
  ) : super(const _Initial()) {
    on<_Get>(_onGet);
    on<_Check>(_onCheck);
    on<_Toggle>(_onToggle);
  }

  final GetRecordsUseCase _getRecordsUseCase;
  final CheckRecordUseCase _checkRecordUseCase;
  final UncheckRecordUseCase _uncheckRecordUseCase;

  Future<void> _onGet(_Get event, Emitter<RecordState> emit) async {
    emit(const _Loading());
    final result = await _getRecordsUseCase(event.habitId);
    result.fold(
      (failure) => emit(_Error(failureToMessage(failure))),
      (records) => emit(_buildSuccess(records)),
    );
  }

  Future<void> _onCheck(_Check event, Emitter<RecordState> emit) async {
    final result = await _checkRecordUseCase(event.habitId);
    result.fold(
      (failure) => emit(_Error(failureToMessage(failure))),
      (records) => emit(_buildSuccess(records)),
    );
  }

  /// 완료 상태면 미완료로, 미완료 상태면 완료로 토글. 즉시 UI 반영을 위해 낙관적 업데이트 후 API 호출.
  Future<void> _onToggle(_Toggle event, Emitter<RecordState> emit) async {
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
      if (previousState is _Success) {
        emit(previousState);
      } else {
        emit(_Error(failureToMessage(failure)));
      }
    }, (records) => emit(_buildSuccess(records)));
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
  const factory RecordEvent.check(int habitId) = _Check;
  const factory RecordEvent.get(int habitId) = _Get;
  const factory RecordEvent.toggle(int habitId) = _Toggle;
}

@freezed
class RecordState with _$RecordState {
  const factory RecordState.initial() = _Initial;
  const factory RecordState.loading() = _Loading;
  const factory RecordState.error(String error) = _Error;
  const factory RecordState.success(List<Record> records, String todayStatus) =
      _Success;
}
