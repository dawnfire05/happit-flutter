import 'package:dartz/dartz.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/auth/domain/entity/user.dart';
import 'package:happit_flutter/app/modules/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignInUseCase {
  final AuthRepository _repository;

  SignInUseCase(this._repository);

  Future<Either<Failure, User>> call(String username, String password) {
    return _repository.signIn(username, password);
  }
}
