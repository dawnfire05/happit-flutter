import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/habit.dart';

part 'habit_model.freezed.dart';
part 'habit_model.g.dart';

@freezed
abstract class HabitModel with _$HabitModel {
  const factory HabitModel({
    @Default(0) int id,
    @Default("") String name,
    @Default("") String description,
    @Default("") String repeatType,
    @Default([]) List<String>? repeatDay,
  }) = _HabitModel;

  factory HabitModel.fromJson(Map<String, Object?> json) =>
      _$HabitModelFromJson(json);
}

extension HabitModelX on HabitModel {
  Habit toEntity() => Habit(
        id: id,
        name: name,
        description: description,
        repeatType: repeatType,
        repeatDay: repeatDay,
      );
}
