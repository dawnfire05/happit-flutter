import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/record.dart';
import 'package:happit_flutter/app/modules/habit/domain/usecase/check_record_use_case.dart';
import 'package:happit_flutter/app/modules/habit/domain/usecase/get_records_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

part 'record_bloc.freezed.dart';

@injectable
class RecordBloc extends Bloc<RecordEvent, RecordState> {
  final GetRecordsUseCase _getRecordsUseCase;
  final CheckRecordUseCase _checkRecordUseCase;

  RecordBloc(this._getRecordsUseCase, this._checkRecordUseCase)
      : super(const _Initial()) {
    on<_Get>((event, emit) async {
      emit(const _Loading());
      final result = await _getRecordsUseCase(event.habitId);
      result.fold(
        (failure) => emit(_Error(failure.when(
          server: (m) => m,
          network: (m) => m,
          unknown: (m) => m,
        ))),
        (records) => emit(_buildSuccess(records)),
      );
    });
    on<_Check>((event, emit) async {
      final result = await _checkRecordUseCase(event.habitId);
      result.fold(
        (failure) => emit(_Error(failure.when(
          server: (m) => m,
          network: (m) => m,
          unknown: (m) => m,
        ))),
        (records) => emit(_buildSuccess(records)),
      );
    });
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
}

@freezed
class RecordState with _$RecordState {
  const factory RecordState.initial() = _Initial;
  const factory RecordState.loading() = _Loading;
  const factory RecordState.error(String error) = _Error;
  const factory RecordState.success(
      List<Record> records, String todayStatus) = _Success;
}
