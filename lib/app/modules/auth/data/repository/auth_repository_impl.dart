import 'package:dartz/dartz.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/auth/data/model/refresh_model.dart';
import 'package:happit_flutter/app/modules/auth/data/model/sign_in_model.dart';
import 'package:happit_flutter/app/modules/auth/data/model/sign_up_model.dart';
import 'package:happit_flutter/app/modules/auth/data/repository/auth_data_source.dart';
import 'package:happit_flutter/app/modules/auth/data/repository/token_repository.dart';
import 'package:happit_flutter/app/modules/auth/data/repository/user_data_source.dart';
import 'package:happit_flutter/app/modules/auth/domain/entity/user.dart';
import 'package:happit_flutter/app/modules/auth/domain/repository/auth_repository.dart';
import 'package:happit_flutter/app/modules/profile/data/model/user_model.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;
  final UserDataSource _userDataSource;
  final TokenRepository _tokenRepository;

  AuthRepositoryImpl(
      this._authDataSource, this._userDataSource, this._tokenRepository);

  @override
  Future<Either<Failure, User>> signIn(
      String username, String password) async {
    try {
      final response =
          await _authDataSource.login(SignInModel(username, password));
      final token = await _tokenRepository.saveToken(response);
      if (token == null) {
        return left(const Failure.unknown(message: '토큰 저장에 실패했습니다.'));
      }
      final userModel = await _userDataSource.getProfile();
      return right(userModel.toEntity());
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> signUp(
      String email, String username, String password) async {
    try {
      await _userDataSource
          .signUp(SignUpModel(email, username, password));
      return right(null);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final userModel = await _userDataSource.getProfile();
      return right(userModel.toEntity());
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final token = await _tokenRepository.token.first;
      if (token == null) {
        return left(const Failure.unknown(message: '토큰이 없습니다.'));
      }
      await _authDataSource
          .logout(RefreshModel(refreshToken: token.refresh_token));
      await _tokenRepository.deleteToken();
      return right(null);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
