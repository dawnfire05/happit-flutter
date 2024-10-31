import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit_entity.freezed.dart';
part 'habit_entity.g.dart';

@freezed
class HabitEntity with _$HabitEntity {
  factory HabitEntity() = _HabitEntity;

  factory HabitEntity.fromJson(Map<String, dynamic> json) =>
      _$HabitEntityFromJson(json);
}
