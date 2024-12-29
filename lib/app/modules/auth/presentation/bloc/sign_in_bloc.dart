import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/auth/data/model/refresh_model.dart';
import 'package:happit_flutter/app/modules/auth/data/model/sign_in_model.dart';
import 'package:happit_flutter/app/modules/auth/data/model/token_model.dart';
import 'package:happit_flutter/app/modules/auth/data/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_bloc.freezed.dart';

@Singleton()
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository _repository;
  final FlutterSecureStorage _storage;

  SignInBloc(this._repository, this._storage)
      : super(const SignInState.initial()) {
    on<_SignIn>((event, emit) async {
      try {
        TokenModel response = await _repository
            .login(SignInModel(event.username, event.password));
        _storage
          ..write(key: 'accessToken', value: response.access_token.toString())
          ..write(
              key: 'refreshToken', value: response.refresh_token.toString());
        emit(const SignInState.success());
        log(response.toString());
      } catch (e) {
        log(e.toString());
        emit(SignInState.error(e.toString()));
      }
    });
    on<_Logout>((event, emit) async {
      final refreshToken = await _storage.read(key: 'refreshToken');
      if (refreshToken != null) {
        _repository.logout(RefreshModel(refreshToken: refreshToken));
      }
      _storage
        ..delete(key: 'accessToken')
        ..delete(key: 'refreshToken');
    });
  }
}

@freezed
sealed class SignInEvent with _$SignInEvent {
  const factory SignInEvent.signIn(
    String username,
    String password,
  ) = _SignIn;
  const factory SignInEvent.logout() = _Logout;
}

@freezed
sealed class SignInState with _$SignInState {
  const factory SignInState.initial() = _Initial;
  const factory SignInState.error(String error) = _Error;
  const factory SignInState.success() = _Success;
}
