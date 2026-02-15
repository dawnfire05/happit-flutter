import 'package:dartz/dartz.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/habit/domain/repository/habit_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateHabitUseCase {
  final HabitRepository _repository;

  UpdateHabitUseCase(this._repository);

  Future<Either<Failure, void>> call(
    int id, {
    String? name,
    String? description,
    String? repeatType,
    List<String>? repeatDay,
    String? themeColor,
  }) {
    return _repository.updateHabit(
      id,
      name: name,
      description: description,
      repeatType: repeatType,
      repeatDay: repeatDay,
      themeColor: themeColor,
    );
  }
}
