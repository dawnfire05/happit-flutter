import 'package:dartz/dartz.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/auth/domain/entity/user.dart';
import 'package:happit_flutter/app/modules/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCurrentUserUseCase {
  final AuthRepository _repository;

  GetCurrentUserUseCase(this._repository);

  Future<Either<Failure, User>> call() {
    return _repository.getCurrentUser();
  }
}
