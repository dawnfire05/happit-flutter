import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/habit.dart';

part 'habit_model.freezed.dart';
part 'habit_model.g.dart';

@freezed
abstract class HabitModel with _$HabitModel {
  const factory HabitModel({
    @Default(0) int id,
    @Default(0) int userId,
    @Default('') String name,
    @Default('none') String type,
    @Default('') String description,
    @Default(false) bool archiveStatus,
    @Default('') String repeatType,
    @Default([]) List<String> repeatDay,
    @Default([]) List<dynamic> noticeTime,
    @Default(0) int themeColor,
    @Default('') String createdAt,
    @Default('') String updatedAt,
  }) = _HabitModel;

  factory HabitModel.fromJson(Map<String, dynamic> json) =>
      _$HabitModelFromJson(json);
}

extension HabitModelX on HabitModel {
  Habit toEntity() => Habit(
        id: id,
        name: name,
        description: description,
        repeatType: repeatType,
        repeatDay: repeatDay.isEmpty ? null : repeatDay,
      );
}
