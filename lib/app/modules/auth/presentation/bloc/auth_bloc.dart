import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/auth/domain/entity/user.dart';
import 'package:happit_flutter/app/modules/auth/domain/usecase/get_current_user_use_case.dart';
import 'package:happit_flutter/app/modules/auth/domain/usecase/logout_use_case.dart';
import 'package:happit_flutter/app/modules/auth/domain/usecase/sign_in_use_case.dart';
import 'package:happit_flutter/app/modules/auth/domain/usecase/sign_up_use_case.dart';
import 'package:injectable/injectable.dart';

part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthBloc(this._signInUseCase, this._signUpUseCase, this._getCurrentUserUseCase,
      this._logoutUseCase)
      : super(const _Initial()) {
    on<_Load>((event, emit) async {
      emit(const _Loading());
      final result = await _getCurrentUserUseCase();
      result.fold(
        (failure) => emit(const _Unauthenticated()),
        (user) => emit(_Authenticated(user)),
      );
    });
    on<_SignIn>((event, emit) async {
      emit(const _Loading());
      final result = await _signInUseCase(event.username, event.password);
      result.fold(
        (failure) => emit(_Error(failure.when(
          server: (m) => m,
          network: (m) => m,
          unknown: (m) => m,
        ))),
        (user) => emit(_Authenticated(user)),
      );
    });
    on<_SignUp>((event, emit) async {
      emit(const _Loading());
      final result =
          await _signUpUseCase(event.email, event.username, event.password);
      result.fold(
        (failure) => emit(_Error(failure.when(
          server: (m) => m,
          network: (m) => m,
          unknown: (m) => m,
        ))),
        (_) => emit(const _Unauthenticated()),
      );
    });
    on<_Logout>((event, emit) async {
      emit(const _Loading());
      final result = await _logoutUseCase();
      result.fold(
        (failure) => emit(_Error(failure.when(
          server: (m) => m,
          network: (m) => m,
          unknown: (m) => m,
        ))),
        (_) => emit(const _Unauthenticated()),
      );
    });
  }
}

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.load() = _Load;
  const factory AuthEvent.signIn(
    String username,
    String password,
  ) = _SignIn;
  const factory AuthEvent.signUp(
    String email,
    String username,
    String password,
  ) = _SignUp;
  const factory AuthEvent.logout() = _Logout;
}

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.error(String error) = _Error;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
}
