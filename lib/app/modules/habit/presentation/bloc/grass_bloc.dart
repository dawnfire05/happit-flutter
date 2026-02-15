import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/core/error/failure.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/grass.dart';
import 'package:happit_flutter/app/modules/habit/domain/usecase/get_grass_use_case.dart';
import 'package:injectable/injectable.dart';

/// 잔디(그리드) 전용: 전체 습관 × 최근 N개월 기록을 한 번에 조회.
/// 표시 전용(read-only). 완료 토글/단일 습관 상세는 [RecordBloc] 사용.
@injectable
class GrassBloc extends Bloc<GrassEvent, GrassState> {
  GrassBloc(this._getGrassUseCase) : super(GrassInitial()) {
    on<GrassGet>(_onGet);
  }

  final GetGrassUseCase _getGrassUseCase;

  Future<void> _onGet(GrassGet event, Emitter<GrassState> emit) async {
    emit(GrassLoading());
    final result = await _getGrassUseCase(event.months);
    result.fold(
      (failure) => emit(GrassError(failureToMessage(failure))),
      (grass) => emit(GrassSuccess(grass)),
    );
  }
}

sealed class GrassEvent {
  const GrassEvent();
}

class GrassGet extends GrassEvent {
  const GrassGet(this.months);
  final int months;
}

sealed class GrassState {
  const GrassState();
}

class GrassInitial extends GrassState {}

class GrassLoading extends GrassState {}

class GrassSuccess extends GrassState {
  GrassSuccess(this.grass);
  final List<Grass> grass;
}

class GrassError extends GrassState {
  GrassError(this.error);
  final String error;
}
