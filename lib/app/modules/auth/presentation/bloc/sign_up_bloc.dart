import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/auth/domain/usecase/sign_up_use_case.dart';
import 'package:injectable/injectable.dart';

part 'sign_up_bloc.freezed.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpBloc(this._signUpUseCase) : super(const _Initial()) {
    on<SignUpEvent>((event, emit) async {
      final result =
          await _signUpUseCase(event.email, event.username, event.password);
      result.fold(
        (failure) => emit(SignUpState.error(failure.when(
          server: (m) => m,
          network: (m) => m,
          unknown: (m) => m,
        ))),
        (_) => emit(const SignUpState.success()),
      );
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
