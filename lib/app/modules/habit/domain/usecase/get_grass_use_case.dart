import 'package:dartz/dartz.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/grass.dart';
import 'package:happit_flutter/app/modules/habit/domain/repository/record_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetGrassUseCase {
  final RecordRepository _repository;

  GetGrassUseCase(this._repository);

  Future<Either<Failure, List<Grass>>> call(int months) {
    return _repository.getGrass(months);
  }
}
