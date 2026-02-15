import 'package:dartz/dartz.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/habit/data/model/create_habit_model.dart';
import 'package:happit_flutter/app/modules/habit/data/model/habit_model.dart';
import 'package:happit_flutter/app/modules/habit/data/model/update_habit_model.dart';
import 'package:happit_flutter/app/modules/habit/data/repository/habit_data_source.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/habit.dart';
import 'package:happit_flutter/app/modules/habit/domain/repository/habit_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: HabitRepository)
class HabitRepositoryImpl implements HabitRepository {
  final HabitDataSource _dataSource;

  HabitRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<Habit>>> getHabits() async {
    try {
      final models = await _dataSource.getHabits();
      models.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      return right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Habit>> getHabit(int id) async {
    try {
      final model = await _dataSource.getHabit(id);
      return right(model.toEntity());
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> createHabit({
    required String name,
    required String description,
    required String repeatType,
    List<String>? repeatDay,
    required String themeColor,
  }) async {
    try {
      await _dataSource.createHabit(
        CreateHabitModel(
          name: name,
          description: description,
          repeatType: repeatType,
          repeatDay: repeatDay,
          themeColor: themeColor,
        ),
      );
      return right(null);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> updateHabit(
    int id, {
    String? name,
    String? description,
    String? repeatType,
    List<String>? repeatDay,
    String? themeColor,
  }) async {
    try {
      await _dataSource.updateHabit(
        id,
        UpdateHabitModel(
          name: name,
          description: description,
          repeatType: repeatType,
          repeatDay: repeatDay,
          themeColor: themeColor,
        ),
      );
      return right(null);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteHabit(int id) async {
    try {
      await _dataSource.deleteHabit(id);
      return right(null);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
