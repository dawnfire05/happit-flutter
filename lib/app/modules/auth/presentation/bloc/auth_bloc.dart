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
    on<_SignInUsernameChanged>((event, emit) {
      final u = state.mapOrNull(unauthenticated: (s) => s);
      if (u != null) {
        emit(u.copyWith(username: event.value));
        return;
      }
      final e = state.mapOrNull(error: (s) => s);
      if (e != null) {
        emit(_Unauthenticated(username: event.value, password: e.password));
      }
    });
    on<_SignInPasswordChanged>((event, emit) {
      final u = state.mapOrNull(unauthenticated: (s) => s);
      if (u != null) {
        emit(u.copyWith(password: event.value));
        return;
      }
      final e = state.mapOrNull(error: (s) => s);
      if (e != null) {
        emit(_Unauthenticated(username: e.username, password: event.value));
      }
    });
    on<_SignIn>((event, emit) async {
      final unauthenticated = state.mapOrNull(unauthenticated: (s) => s);
      if (unauthenticated == null) return;
      final username = unauthenticated.username;
      final password = unauthenticated.password;
      emit(const _Loading());
      final result = await _signInUseCase(username, password);
      result.fold(
        (failure) => emit(_Error(
          failure.when(
            server: (m) => m,
            network: (m) => m,
            unknown: (m) => m,
          ),
          username: username,
          password: password,
        )),
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
  const factory AuthEvent.signInUsernameChanged(String value) =
      _SignInUsernameChanged;
  const factory AuthEvent.signInPasswordChanged(String value) =
      _SignInPasswordChanged;
  const factory AuthEvent.signIn() = _SignIn;
  const factory AuthEvent.signUp(
    String email,
    String username,
    String password,
  ) = _SignUp;
  const factory AuthEvent.logout() = _Logout;
}

@freezed
sealed class AuthState with _$AuthState {
  const AuthState._();
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.error(
    String error, {
    @Default('') String username,
    @Default('') String password,
  }) = _Error;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.unauthenticated({
    @Default('') String username,
    @Default('') String password,
  }) = _Unauthenticated;

  /// 공개 API: 다른 라이브러리에서 switch 없이 에러 메시지/인증 여부 접근용.
  String? get errorMessage => switch (this) {
        _Error(:final error) => error,
        _ => null,
      };

  bool get isAuthenticated => this is _Authenticated;

  String get formUsername => switch (this) {
        _Unauthenticated(:final username) => username,
        _Error(:final username) => username,
        _ => '',
      };

  String get formPassword => switch (this) {
        _Unauthenticated(:final password) => password,
        _Error(:final password) => password,
        _ => '',
      };
}
