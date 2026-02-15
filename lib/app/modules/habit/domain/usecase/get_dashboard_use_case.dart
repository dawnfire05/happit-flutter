import 'package:dartz/dartz.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/dashboard_data.dart';
import 'package:happit_flutter/app/modules/habit/domain/repository/habit_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetDashboardUseCase {
  final HabitRepository _repository;

  GetDashboardUseCase(this._repository);

  Future<Either<Failure, DashboardData>> call(int months) {
    return _repository.getDashboard(months);
  }
}
