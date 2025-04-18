import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/habit/data/model/add_or_update_record_model.dart';
import 'package:happit_flutter/app/modules/habit/data/model/record_model.dart';
import 'package:happit_flutter/app/modules/habit/data/repository/record_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

part 'record_bloc.freezed.dart';

@injectable
class RecordBloc extends Bloc<RecordEvent, RecordState> {
  final RecordRepository _repository;

  late int habitId;

  RecordBloc(this._repository) : super(const _Initial()) {
    on<_Get>((event, emit) async {
      emit(const _Loading());
      habitId = event.habitId;
      final records = await _repository.getRecordOfOneHabit(habitId);
      Map<String, String> dateStateMap = {};
      for (var record in records) {
        dateStateMap[record.date] = record.state;
      }
      String todayStatus =
          dateStateMap[DateFormat('yyyy-MM-dd').format(DateTime.now())] ??
              "notDone";
      emit(RecordState.success(records, todayStatus));
    });
    on<_Check>((event, emit) {
      _repository.addOrUpdateRecord(AddOrUpdateRecordModel(
          habitId: habitId,
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          state: "done"));
    });
  }

  
}

@freezed
sealed class RecordEvent with _$RecordEvent {
  const factory RecordEvent.check() = _Check;
  const factory RecordEvent.get(int habitId) = _Get;
}

@freezed
class RecordState with _$RecordState {
  const factory RecordState.initial() = _Initial;
  const factory RecordState.loading() = _Loading;
  const factory RecordState.error(String error) = _Error;
  const factory RecordState.success(
      List<RecordModel> records, String todayStatus) = _Success;
}
