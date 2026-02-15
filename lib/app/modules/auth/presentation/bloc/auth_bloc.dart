import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
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

  AuthBloc(
    this._signInUseCase,
    this._signUpUseCase,
    this._getCurrentUserUseCase,
    this._logoutUseCase,
  ) : super(const Initial()) {
    on<Load>((event, emit) async {
      emit(const Loading());
      final result = await _getCurrentUserUseCase();
      result.fold(
        (failure) => emit(const Unauthenticated()),
        (user) => emit(Authenticated(user)),
      );
    });
    on<SignInUsernameChanged>((event, emit) {
      final u = state.mapOrNull(unauthenticated: (s) => s);
      if (u != null) {
        emit(u.copyWith(username: event.value));
        return;
      }
      final e = state.mapOrNull(error: (s) => s);
      if (e != null) {
        emit(Unauthenticated(username: event.value, password: e.password));
      }
    });
    on<SignInPasswordChanged>((event, emit) {
      final u = state.mapOrNull(unauthenticated: (s) => s);
      if (u != null) {
        emit(u.copyWith(password: event.value));
        return;
      }
      final e = state.mapOrNull(error: (s) => s);
      if (e != null) {
        emit(Unauthenticated(username: e.username, password: event.value));
      }
    });
    on<SignIn>((event, emit) async {
      final unauthenticated = state.mapOrNull(unauthenticated: (s) => s);
      if (unauthenticated == null) return;
      final username = unauthenticated.username;
      final password = unauthenticated.password;
      emit(const Loading());
      final result = await _signInUseCase(username, password);
      result.fold(
        (failure) => emit(
          Error(
            failureToMessage(failure),
            username: username,
            password: password,
          ),
        ),
        (user) => emit(Authenticated(user)),
      );
    });
    on<SignUp>((event, emit) async {
      emit(const Loading());
      final result = await _signUpUseCase(
        event.email,
        event.username,
        event.password,
      );
      result.fold(
        (failure) => emit(Error(failureToMessage(failure))),
        (_) => emit(const Unauthenticated()),
      );
    });
    on<Logout>((event, emit) async {
      emit(const Loading());
      final result = await _logoutUseCase();
      result.fold(
        (failure) => emit(Error(failureToMessage(failure))),
        (_) => emit(const Unauthenticated()),
      );
    });
  }
}

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.load() = Load;
  const factory AuthEvent.signInUsernameChanged(String value) =
      SignInUsernameChanged;
  const factory AuthEvent.signInPasswordChanged(String value) =
      SignInPasswordChanged;
  const factory AuthEvent.signIn() = SignIn;
  const factory AuthEvent.signUp(
    String email,
    String username,
    String password,
  ) = SignUp;
  const factory AuthEvent.logout() = Logout;
}

@freezed
sealed class AuthState with _$AuthState {
  const AuthState._();
  const factory AuthState.initial() = Initial;
  const factory AuthState.loading() = Loading;
  const factory AuthState.error(
    String error, {
    @Default('') String username,
    @Default('') String password,
  }) = Error;
  const factory AuthState.authenticated(User user) = Authenticated;
  const factory AuthState.unauthenticated({
    @Default('') String username,
    @Default('') String password,
  }) = Unauthenticated;

  /// 공개 API: 다른 라이브러리에서 switch 없이 에러 메시지/인증 여부 접근용.
  String? get errorMessage => switch (this) {
    Error(:final error) => error,
    _ => null,
  };

  bool get isAuthenticated => this is Authenticated;
  bool get isLoading => this is Loading;

  String get formUsername => switch (this) {
    Unauthenticated(:final username) => username,
    Error(:final username) => username,
    _ => '',
  };

  String get formPassword => switch (this) {
    Unauthenticated(:final password) => password,
    Error(:final password) => password,
    _ => '',
  };
}
