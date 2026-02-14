import 'package:dartz/dartz.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<Either<Failure, void>> call(
      String email, String username, String password) {
    return _repository.signUp(email, username, password);
  }
}
