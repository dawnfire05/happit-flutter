import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/grass.dart';
import 'package:happit_flutter/app/modules/habit/domain/usecase/get_grass_use_case.dart';
import 'package:injectable/injectable.dart';

part 'grass_bloc.freezed.dart';

/// 잔디(그리드) 전용: 전체 습관 × 최근 N개월 기록을 한 번에 조회.
/// 표시 전용(read-only). 완료 토글/단일 습관 상세는 [RecordBloc] 사용.
@injectable
class GrassBloc extends Bloc<GrassEvent, GrassState> {
  final GetGrassUseCase _getGrassUseCase;

  GrassBloc(this._getGrassUseCase) : super(const GrassState.initial()) {
    on<Get>(_onGet);
  }

  Future<void> _onGet(Get event, Emitter<GrassState> emit) async {
    emit(const GrassState.loading());
    final result = await _getGrassUseCase(event.months);
    result.fold(
      (failure) => emit(GrassState.error(failureToMessage(failure))),
      (grass) => emit(GrassState.success(grass)),
    );
  }
}

@freezed
sealed class GrassEvent with _$GrassEvent {
  const factory GrassEvent.get(int months) = Get;
}

@freezed
sealed class GrassState with _$GrassState {
  const factory GrassState.initial() = GrassInitial;
  const factory GrassState.loading() = GrassLoading;
  const factory GrassState.success(List<Grass> grass) = GrassSuccess;
  const factory GrassState.error(String error) = GrassError;
}
