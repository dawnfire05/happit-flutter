import 'package:dartz/dartz.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/habit/data/model/add_or_update_record_model.dart';
import 'package:happit_flutter/app/modules/habit/data/model/record_model.dart';
import 'package:happit_flutter/app/modules/habit/data/model/toggle_record_response_model.dart';
import 'package:happit_flutter/app/modules/habit/data/repository/record_data_source.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/grass.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/record.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/toggle_record_response.dart';
import 'package:happit_flutter/app/modules/habit/domain/repository/record_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@Singleton(as: RecordRepository)
class RecordRepositoryImpl implements RecordRepository {
  final RecordDataSource _dataSource;

  RecordRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<Record>>> getRecords(int habitId) async {
    try {
      final models = await _dataSource.getRecordOfOneHabit(habitId.toString());
      return right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, ToggleRecordResponse>> checkRecord(int habitId) async {
    try {
      final response = await _dataSource.addOrUpdateRecord(
        AddOrUpdateRecordModel(
          habitId: habitId,
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          state: 'done',
        ),
      );
      return right(response.toEntity());
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, ToggleRecordResponse>> uncheckRecord(int habitId) async {
    try {
      final response = await _dataSource.addOrUpdateRecord(
        AddOrUpdateRecordModel(
          habitId: habitId,
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          state: 'notDone',
        ),
      );
      return right(response.toEntity());
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<Grass>>> getGrass(int months) async {
    try {
      final models = await _dataSource.getGrass(months);
      return right(
        models
            .map(
              (m) => Grass(
                habitId: m.habitId,
                records: m.records
                    .map((r) => GrassRecordEntry(date: r.date, state: r.state))
                    .toList(),
              ),
            )
            .toList(),
      );
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
