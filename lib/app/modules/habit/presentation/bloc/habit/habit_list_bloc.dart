import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/auth/data/repository/token_repository.dart';
import 'package:happit_flutter/app/modules/auth/data/repository/user_repository.dart';
import 'package:happit_flutter/app/modules/habit/data/model/habit_model.dart';
import 'package:happit_flutter/app/modules/habit/data/repository/habit_repository.dart';
import 'package:injectable/injectable.dart';

part 'habit_list_bloc.freezed.dart';

@injectable
class HabitListBloc extends Bloc<HabitListEvent, HabitListState> {
  final HabitRepository _repository;
  final UserRepository _userRepository;

  HabitListBloc(this._repository, this._userRepository)
      : super(const _Initial()) {
    on<_Load>(
      (event, emit) {
        // return emit.forEach(_userRepository.isUserLoggedIn,
        //     onData: (v) => v
        //         ? add(const HabitListEvent.get())
        //         : emit(const HabitListState.initial()));
        // _userRepository.isUserLoggedIn.asyncMap((v) {
        //   if (v) {
        //     _repository.getHabits();
        //   } else {
        //     emit(const _Initial());
        //   }
        // });
      },
    );
    on<_Get>(
      (event, emit) async {
        try {
          emit(const _Loading());
          final habits = await _repository.getHabits();
          emit(_Success(habits));
        } on Exception catch (e) {
          emit(_Error(e.toString()));
        }
      },
    );
  }
}

@freezed
sealed class HabitListEvent with _$HabitListEvent {
  const factory HabitListEvent.load() = _Load;
  const factory HabitListEvent.get() = _Get;
}

@freezed
class HabitListState with _$HabitListState {
  const factory HabitListState.initial() = _Initial;
  const factory HabitListState.loading() = _Loading;
  const factory HabitListState.error(String error) = _Error;
  const factory HabitListState.success(List<HabitModel> habits) = _Success;
}
