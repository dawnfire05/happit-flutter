import 'package:dartz/dartz.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/record.dart';

abstract class RecordRepository {
  Future<Either<Failure, List<Record>>> getRecords(int habitId);
  Future<Either<Failure, List<Record>>> checkRecord(int habitId);
}
