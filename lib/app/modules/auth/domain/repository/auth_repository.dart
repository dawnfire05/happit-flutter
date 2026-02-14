import 'package:dartz/dartz.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/auth/domain/entity/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signIn(String username, String password);
  Future<Either<Failure, void>> signUp(
      String email, String username, String password);
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, void>> logout();
}
