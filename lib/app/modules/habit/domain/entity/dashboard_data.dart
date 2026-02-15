import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/habit_with_grass.dart';

part 'dashboard_data.freezed.dart';

/// 대시보드 API 응답 엔티티
/// 습관 목록 + 기록을 단일 API 호출로 조회
@freezed
abstract class DashboardData with _$DashboardData {
  const factory DashboardData({
    required List<HabitWithGrass> habits,
    required DateTime syncedAt,
  }) = _DashboardData;
}
