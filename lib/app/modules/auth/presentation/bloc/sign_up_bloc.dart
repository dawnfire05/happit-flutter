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
    on<EmailChanged>((event, emit) {
      final form = state.mapOrNull(form: (s) => s);
      if (form != null) {
        emit(form.copyWith(email: event.value));
        return;
      }
      final error = state.mapOrNull(error: (s) => s);
      if (error != null) {
        emit(
          SignUpState.form(
            email: event.value,
            username: error.username,
            password: error.password,
          ),
        );
      }
    });
    on<UsernameChanged>((event, emit) {
      final form = state.mapOrNull(form: (s) => s);
      if (form != null) {
        emit(form.copyWith(username: event.value));
        return;
      }
      final error = state.mapOrNull(error: (s) => s);
      if (error != null) {
        emit(
          SignUpState.form(
            email: error.email,
            username: event.value,
            password: error.password,
          ),
        );
      }
    });
    on<PasswordChanged>((event, emit) {
      final form = state.mapOrNull(form: (s) => s);
      if (form != null) {
        emit(form.copyWith(password: event.value));
        return;
      }
      final error = state.mapOrNull(error: (s) => s);
      if (error != null) {
        emit(
          SignUpState.form(
            email: error.email,
            username: error.username,
            password: event.value,
          ),
        );
      }
    });
    on<SignUp>((event, emit) async {
      final email = state.formEmail;
      final username = state.formUsername;
      final password = state.formPassword;
      if (email.isEmpty || username.isEmpty || password.isEmpty) return;
      emit(const SignUpState.loading());
      final result = await _signUpUseCase(email, username, password);
      result.fold(
        (failure) => emit(
          SignUpState.error(
            failureToMessage(failure),
            email: email,
            username: username,
            password: password,
          ),
        ),
        (_) => emit(const SignUpState.success()),
      );
    });
  }
}

@freezed
sealed class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.emailChanged(String value) = EmailChanged;
  const factory SignUpEvent.usernameChanged(String value) = UsernameChanged;
  const factory SignUpEvent.passwordChanged(String value) = PasswordChanged;
  const factory SignUpEvent.signUp() = SignUp;
}

@freezed
sealed class SignUpState with _$SignUpState {
  const SignUpState._();
  const factory SignUpState.form({
    @Default('') String email,
    @Default('') String username,
    @Default('') String password,
  }) = Form;
  const factory SignUpState.loading() = Loading;
  const factory SignUpState.error(
    String error, {
    @Default('') String email,
    @Default('') String username,
    @Default('') String password,
  }) = Error;
  const factory SignUpState.success() = Success;

  bool get isSuccess => this is Success;
  bool get isLoading => this is Loading;
  bool get isError => this is Error;

  String? get errorMessage => switch (this) {
    Error(:final error) => error,
    _ => null,
  };

  String get formEmail => switch (this) {
    Form(:final email) => email,
    Error(:final email) => email,
    _ => '',
  };

  String get formUsername => switch (this) {
    Form(:final username) => username,
    Error(:final username) => username,
    _ => '',
  };

  String get formPassword => switch (this) {
    Form(:final password) => password,
    Error(:final password) => password,
    _ => '',
  };
}
