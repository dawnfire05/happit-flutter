import 'package:dartz/dartz.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/grass.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/record.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/toggle_record_response.dart';

abstract class RecordRepository {
  Future<Either<Failure, List<Record>>> getRecords(int habitId);
  Future<Either<Failure, ToggleRecordResponse>> checkRecord(int habitId);
  Future<Either<Failure, ToggleRecordResponse>> uncheckRecord(int habitId);
  Future<Either<Failure, List<Grass>>> getGrass(int months);
}
