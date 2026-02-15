import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/auth/domain/usecase/sign_up_use_case.dart';
import 'package:injectable/injectable.dart';

part 'sign_up_bloc.freezed.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpBloc(this._signUpUseCase) : super(const SignUpState.form()) {
    on<_EmailChanged>((event, emit) {
      final form = state.mapOrNull(form: (s) => s);
      if (form != null) {
        emit(form.copyWith(email: event.value));
        return;
      }
      final error = state.mapOrNull(error: (s) => s);
      if (error != null) {
        emit(SignUpState.form(
            email: event.value,
            username: error.username,
            password: error.password));
      }
    });
    on<_UsernameChanged>((event, emit) {
      final form = state.mapOrNull(form: (s) => s);
      if (form != null) {
        emit(form.copyWith(username: event.value));
        return;
      }
      final error = state.mapOrNull(error: (s) => s);
      if (error != null) {
        emit(SignUpState.form(
            email: error.email,
            username: event.value,
            password: error.password));
      }
    });
    on<_PasswordChanged>((event, emit) {
      final form = state.mapOrNull(form: (s) => s);
      if (form != null) {
        emit(form.copyWith(password: event.value));
        return;
      }
      final error = state.mapOrNull(error: (s) => s);
      if (error != null) {
        emit(SignUpState.form(
            email: error.email,
            username: error.username,
            password: event.value));
      }
    });
    on<_SignUp>((event, emit) async {
      final email = state.formEmail;
      final username = state.formUsername;
      final password = state.formPassword;
      if (email.isEmpty || username.isEmpty || password.isEmpty) return;
      emit(const SignUpState.loading());
      final result = await _signUpUseCase(email, username, password);
      result.fold(
        (failure) => emit(SignUpState.error(
          failureToMessage(failure),
          email: email,
          username: username,
          password: password,
        )),
        (_) => emit(const SignUpState.success()),
      );
    });
  }
}

@freezed
sealed class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.emailChanged(String value) = _EmailChanged;
  const factory SignUpEvent.usernameChanged(String value) = _UsernameChanged;
  const factory SignUpEvent.passwordChanged(String value) = _PasswordChanged;
  const factory SignUpEvent.signUp() = _SignUp;
}

@freezed
sealed class SignUpState with _$SignUpState {
  const SignUpState._();
  const factory SignUpState.form({
    @Default('') String email,
    @Default('') String username,
    @Default('') String password,
  }) = _Form;
  const factory SignUpState.loading() = _Loading;
  const factory SignUpState.error(
    String error, {
    @Default('') String email,
    @Default('') String username,
    @Default('') String password,
  }) = _Error;
  const factory SignUpState.success() = _Success;

  bool get isSuccess => this is _Success;
  bool get isLoading => this is _Loading;
  bool get isError => this is _Error;

  String? get errorMessage => switch (this) {
        _Error(:final error) => error,
        _ => null,
      };

  String get formEmail => switch (this) {
        _Form(:final email) => email,
        _Error(:final email) => email,
        _ => '',
      };

  String get formUsername => switch (this) {
        _Form(:final username) => username,
        _Error(:final username) => username,
        _ => '',
      };

  String get formPassword => switch (this) {
        _Form(:final password) => password,
        _Error(:final password) => password,
        _ => '',
      };
}
