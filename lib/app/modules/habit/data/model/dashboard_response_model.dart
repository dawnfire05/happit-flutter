import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/habit/data/model/habit_model.dart';
import 'package:happit_flutter/app/modules/habit/data/model/record_model.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/dashboard_data.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/habit_with_grass.dart';

part 'dashboard_response_model.freezed.dart';
part 'dashboard_response_model.g.dart';

/// 단일 습관 + 기록 항목 모델
@freezed
abstract class HabitWithRecordsModel with _$HabitWithRecordsModel {
  const factory HabitWithRecordsModel({
    required HabitModel habit,
    @Default([]) List<RecordModel> records,
  }) = _HabitWithRecordsModel;

  factory HabitWithRecordsModel.fromJson(Map<String, dynamic> json) =>
      _$HabitWithRecordsModelFromJson(json);
}

/// 대시보드 API 응답 모델
@freezed
abstract class DashboardResponseModel with _$DashboardResponseModel {
  const factory DashboardResponseModel({
    @Default([]) List<HabitWithRecordsModel> data,
    required String syncedAt,
  }) = _DashboardResponseModel;

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardResponseModelFromJson(json);
}

extension DashboardResponseModelX on DashboardResponseModel {
  DashboardData toEntity() => DashboardData(
        habits: data.map((item) {
          return HabitWithGrass(
            habit: item.habit.toEntity(),
            grassRecords: item.records.map((r) => r.toEntity()).toList(),
          );
        }).toList(),
        syncedAt: DateTime.parse(syncedAt),
      );
}
