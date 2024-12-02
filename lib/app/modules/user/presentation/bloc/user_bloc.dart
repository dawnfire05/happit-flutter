import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/user/data/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

part 'user_bloc.freezed.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _repository;
  UserBloc(this._repository) : super(const _Initial()) {
    on<_Load>((event, emit) async {
      emit(const _Loading());

      try {
        final profile = await _repository.getProfile();
        emit(_Authenticated());
      } on Exception catch (e) {
        emit(const _Unauthenticated());
      }
    });
    on<_GetProfile>((event, emit) {});
  }
}

@freezed
abstract class UserEvent with _$UserEvent {
  const factory UserEvent.load() = _Load;
  const factory UserEvent.getProfile() = _GetProfile;
}

@freezed
abstract class UserState with _$UserState {
  const UserState._();
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.unauthenticated() = _Unauthenticated;
  const factory UserState.authenticated() = _Authenticated;

  bool get isAuthenticated => this is _Authenticated;
}
