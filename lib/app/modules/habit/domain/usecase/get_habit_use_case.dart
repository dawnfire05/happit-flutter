import 'package:dartz/dartz.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/habit.dart';
import 'package:happit_flutter/app/modules/habit/domain/repository/habit_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetHabitUseCase {
  final HabitRepository _repository;

  GetHabitUseCase(this._repository);

  Future<Either<Failure, Habit>> call(int id) {
    return _repository.getHabit(id);
  }
}
