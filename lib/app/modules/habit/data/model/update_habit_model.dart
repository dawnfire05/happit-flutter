import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_habit_model.freezed.dart';
part 'update_habit_model.g.dart';

@Freezed(toJson: true, fromJson: true)
abstract class UpdateHabitModel with _$UpdateHabitModel {
  @JsonSerializable(includeIfNull: false)
  const factory UpdateHabitModel({
    String? name,
    String? type,
    String? description,
    bool? archiveStatus,
    String? repeatType,
    List<String>? repeatDay,
    List<dynamic>? noticeTime,
    String? themeColor,
  }) = _UpdateHabitModel;

  factory UpdateHabitModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateHabitModelFromJson(json);
}
