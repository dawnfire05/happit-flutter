import 'package:dartz/dartz.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/habit/domain/repository/habit_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CreateHabitUseCase {
  final HabitRepository _repository;

  CreateHabitUseCase(this._repository);

  Future<Either<Failure, void>> call({
    required String name,
    required String description,
    required String repeatType,
    List<String>? repeatDay,
    required String themeColor,
  }) {
    return _repository.createHabit(
      name: name,
      description: description,
      repeatType: repeatType,
      repeatDay: repeatDay,
      themeColor: themeColor,
    );
  }
}
