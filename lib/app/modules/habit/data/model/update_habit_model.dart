import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_habit_model.freezed.dart';
part 'update_habit_model.g.dart';

@freezed
class UpdateHabitModel with _$UpdateHabitModel {
  factory UpdateHabitModel(
    String name,
    String description,
    String repeatType,
    List<String>? repeatDay,
  ) = _UpdateHabitModel;

  factory UpdateHabitModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateHabitModelFromJson(json);
}
