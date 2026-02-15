import 'package:get_it/get_it.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/record.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/record_bloc.dart';

/// habitId별 [RecordBloc] 인스턴스를 캐시하여, 화면 재진입 시 불필요한 get() 재호출을 막는다.
/// [RecordBloc]은 "한 습관의 기록 + 오늘 완료 토글" 전용이므로 습관마다 하나씩 유지한다.
///
/// 주의: BottomNavigationBar 구조상 탭 전환 시에도 캐시를 유지합니다.
/// dispose는 의도적으로 호출하지 않습니다 (빠른 탭 전환을 위한 캐싱).
class RecordBlocCache {
  RecordBlocCache(this._getIt);

  final GetIt _getIt;
  final Map<int, RecordBloc> _cache = {};

  /// RecordBloc을 가져오거나 생성합니다.
  ///
  /// [initialRecords]가 제공되면 API 호출 없이 초기 데이터로 상태를 설정합니다.
  /// (Dashboard API로 이미 데이터를 받은 경우 사용)
  RecordBloc getBloc(int habitId, {List<Record>? initialRecords}) {
    return _cache.putIfAbsent(habitId, () {
      final bloc = _getIt<RecordBloc>();

      if (initialRecords != null && initialRecords.isNotEmpty) {
        // 초기 데이터가 있으면 API 호출 없이 상태 설정
        bloc.add(RecordEvent.initialize(initialRecords));
      } else {
        // 초기 데이터가 없으면 API 호출
        bloc.add(RecordEvent.get(habitId));
      }

      return bloc;
    });
  }

  /// 습관 삭제 시에만 호출하여 해당 BLoC을 정리합니다.
  void removeBloc(int habitId) {
    final bloc = _cache.remove(habitId);
    bloc?.close();
  }

  /// 디버깅용: 현재 캐시된 BLoC 개수를 반환합니다.
  int get cachedCount => _cache.length;
}
