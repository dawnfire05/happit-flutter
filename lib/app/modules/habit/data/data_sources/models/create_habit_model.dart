import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_habit_model.freezed.dart';
part 'create_habit_model.g.dart';

@freezed
sealed class CreateHabitModel with _$CreateHabitModel {
  const factory CreateHabitModel({
    required String name,
    required String description,
    required String repeatType,
    String? repeatDay,
  }) = _CreateHabitModel;

  factory CreateHabitModel.fromJson(Map<String, Object?> json) =>
      _$CreateHabitModelFromJson(json);
}
