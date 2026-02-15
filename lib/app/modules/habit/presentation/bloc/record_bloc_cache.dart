import 'package:get_it/get_it.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/record_bloc.dart';

/// habitId별 [RecordBloc] 인스턴스를 캐시하여, 화면 재진입 시 불필요한 get() 재호출을 막는다.
/// [RecordBloc]은 "한 습관의 기록 + 오늘 완료 토글" 전용이므로 습관마다 하나씩 유지한다.
class RecordBlocCache {
  RecordBlocCache(this._getIt);

  final GetIt _getIt;
  final Map<int, RecordBloc> _cache = {};

  RecordBloc getBloc(int habitId) {
    return _cache.putIfAbsent(habitId, () {
      final bloc = _getIt<RecordBloc>();
      bloc.add(RecordEvent.get(habitId));
      return bloc;
    });
  }
}
