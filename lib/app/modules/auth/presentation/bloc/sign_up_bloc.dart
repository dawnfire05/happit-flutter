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
      final current = state.mapOrNull(form: (s) => s);
      if (current == null) return;
      emit(current.copyWith(email: event.value));
    });
    on<_UsernameChanged>((event, emit) {
      final current = state.mapOrNull(form: (s) => s);
      if (current == null) return;
      emit(current.copyWith(username: event.value));
    });
    on<_PasswordChanged>((event, emit) {
      final current = state.mapOrNull(form: (s) => s);
      if (current == null) return;
      emit(current.copyWith(password: event.value));
    });
    on<_SignUp>((event, emit) async {
      final form = state.mapOrNull(form: (s) => s);
      if (form == null) return;
      emit(const SignUpState.loading());
      final result =
          await _signUpUseCase(form.email, form.username, form.password);
      result.fold(
        (failure) => emit(SignUpState.error(failureToMessage(failure))),
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
  const factory SignUpState.error(String error) = _Error;
  const factory SignUpState.success() = _Success;

  bool get isSuccess => this is _Success;
}
