import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit.freezed.dart';

@freezed
class Habit with _$Habit {
  const factory Habit({
    required int id,
    required String name,
    required String description,
    required String repeatType,
    List<String>? repeatDay,
  }) = _Habit;
}
