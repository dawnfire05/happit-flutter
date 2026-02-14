import 'package:dartz/dartz.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/habit/domain/repository/habit_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteHabitUseCase {
  final HabitRepository _repository;

  DeleteHabitUseCase(this._repository);

  Future<Either<Failure, void>> call(int id) {
    return _repository.deleteHabit(id);
  }
}
