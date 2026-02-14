import 'package:dartz/dartz.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/habit.dart';

abstract class HabitRepository {
  Future<Either<Failure, List<Habit>>> getHabits();
  Future<Either<Failure, Habit>> getHabit(int id);
  Future<Either<Failure, void>> createHabit({
    required String name,
    required String description,
    required String repeatType,
    List<String>? repeatDay,
    required int themeColor,
  });
  Future<Either<Failure, void>> updateHabit(
    int id, {
    String? name,
    String? description,
    String? repeatType,
    List<String>? repeatDay,
  });
  Future<Either<Failure, void>> deleteHabit(int id);
}
