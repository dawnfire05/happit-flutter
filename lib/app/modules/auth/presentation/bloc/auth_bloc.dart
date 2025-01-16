import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/auth/data/model/refresh_model.dart';
import 'package:happit_flutter/app/modules/auth/data/model/sign_in_model.dart';
import 'package:happit_flutter/app/modules/auth/data/model/sign_up_model.dart';
import 'package:happit_flutter/app/modules/auth/data/model/token_model.dart';
import 'package:happit_flutter/app/modules/auth/data/repository/auth_repository.dart';
import 'package:happit_flutter/app/modules/auth/data/repository/token_repository.dart';
import 'package:happit_flutter/app/modules/auth/data/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final TokenRepository _tokenRepository;

  AuthBloc(this._authRepository, this._userRepository, this._tokenRepository)
      : super(const AuthState.initial()) {
    on<_Load>((event, emit) {
      emit(const _Loading());
      return emit.forEach(_userRepository.isUserLoggedIn,
          onData: (v) => v ? const _Authenticated() : const _Unauthenticated());
    });
    on<_SignIn>((event, emit) async {
      emit(const _Loading());
      try {
        TokenModel response = await _authRepository
            .login(SignInModel(event.username, event.password));
        _tokenRepository.saveToken(response);
        emit(const AuthState.authenticated());
      } catch (e) {
        emit(AuthState.error(e.toString()));
      }
    });
    on<_SignUp>((event, emit) async {
      emit(const _Loading());
      try {
        await _userRepository.signUp(SignUpModel(
          event.email,
          event.username,
          event.password,
        ));
        emit(const AuthState.unauthenticated());
      } catch (e) {
        emit(AuthState.error(e.toString()));
      }
    });
    on<_Logout>((event, emit) async {
      emit(const _Loading());
      try {
        final token = await _tokenRepository.token.first;
        if (token == null) {
          emit(const AuthState.unauthenticated());
          return;
        }
        final refreshToken = token.refresh_token;
        _authRepository.logout(RefreshModel(refreshToken: refreshToken));
        _tokenRepository.deleteToken();
        emit(const AuthState.unauthenticated());
      } on Exception catch (e) {
        emit(AuthState.error(e.toString()));
      }
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
  const factory AuthState.authenticated() = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
}
