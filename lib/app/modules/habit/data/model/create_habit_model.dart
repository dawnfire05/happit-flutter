import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_habit_model.freezed.dart';
part 'create_habit_model.g.dart';

@freezed
abstract class CreateHabitModel with _$CreateHabitModel {
  const factory CreateHabitModel({
    required String name,
    @Default('none') String type,
    String? description,
    @Default(false) bool archiveStatus,
    required String repeatType,
    List<String>? repeatDay,
    List<dynamic>? noticeTime,
    required int themeColor,
  }) = _CreateHabitModel;

  factory CreateHabitModel.fromJson(Map<String, Object?> json) =>
      _$CreateHabitModelFromJson(json);
}
