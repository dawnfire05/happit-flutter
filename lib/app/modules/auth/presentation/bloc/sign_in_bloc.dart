import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/auth/data/model/sign_in_model.dart';
import 'package:happit_flutter/app/modules/auth/data/model/sign_in_response_model.dart';
import 'package:happit_flutter/app/modules/auth/data/repository/auth_repository.dart';

part 'sign_in_bloc.freezed.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  AuthRepository repository = AuthRepository(
      Dio(BaseOptions(headers: {'Content-Type': 'application/json'})));
  final storage = const FlutterSecureStorage();

  SignInBloc() : super(const SignInState.initial()) {
    on<_SignIn>((event, emit) async {
      try {
        SignInResponseModel response =
            await repository.login(SignInModel(event.username, event.password));
        storage
          ..write(key: 'accessToken', value: response.access_token.toString())
          ..write(
              key: 'refreshToken', value: response.refresh_token.toString());
        emit(const SignInState.success());
        log(response.toString());
      } catch (e) {
        emit(SignInState.error(e.toString()));
      }
    });
  }
}

@freezed
sealed class SignInEvent with _$SignInEvent {
  const factory SignInEvent.signIn(
    String username,
    String password,
  ) = _SignIn;
}

@freezed
sealed class SignInState with _$SignInState {
  const factory SignInState.initial() = _Initial;
  const factory SignInState.error(String error) = _Error;
  const factory SignInState.success() = _Success;
}
