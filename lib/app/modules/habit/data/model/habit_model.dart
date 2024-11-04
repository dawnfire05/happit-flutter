import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit_model.freezed.dart';
part 'habit_model.g.dart';

@freezed
class HabitModel with _$HabitModel {
  const factory HabitModel({
    required String name,
    required String description,
    required String repeatType,
    List<String>? repeatDay,
  }) = _HabitModel;

  factory HabitModel.fromJson(Map<String, Object?> json) =>
      _$HabitModelFromJson(json);
}
