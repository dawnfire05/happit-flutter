import 'package:dartz/dartz.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/record.dart';
import 'package:happit_flutter/app/modules/habit/domain/repository/record_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckRecordUseCase {
  final RecordRepository _repository;

  CheckRecordUseCase(this._repository);

  Future<Either<Failure, List<Record>>> call(int habitId) {
    return _repository.checkRecord(habitId);
  }
}
