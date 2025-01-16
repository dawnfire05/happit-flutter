import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/auth/data/model/sign_up_model.dart';
import 'package:happit_flutter/app/modules/auth/data/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

part 'sign_up_bloc.freezed.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _repository;

  SignUpBloc(this._repository) : super(const _Initial()) {
    on<SignUpEvent>((event, emit) async {
      try {
        SignUpModel response = await _repository.signUp(SignUpModel(
          event.email,
          event.username,
          event.password,
        ));
        emit(const SignUpState.success());
        log(response.toString());
      } catch (e) {
        emit(SignUpState.error(e.toString()));
        log(e.toString());
      }
    });
  }
}

@freezed
sealed class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.signUp(
    String email,
    String username,
    String password,
  ) = _SignUp;
}

@freezed
sealed class SignUpState with _$SignUpState {
  const factory SignUpState.initial() = _Initial;
  const factory SignUpState.error(String error) = _Error;
  const factory SignUpState.success() = _Success;
}
