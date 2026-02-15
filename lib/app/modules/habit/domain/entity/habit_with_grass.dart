import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/habit.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/record.dart';

part 'habit_with_grass.freezed.dart';

/// 습관 정보와 잔디(grass) 기록을 함께 담는 엔티티.
/// HabitListScreen에서 Habit과 Grass 데이터를 통합하여 제공.
@freezed
abstract class HabitWithGrass with _$HabitWithGrass {
  const factory HabitWithGrass({
    required Habit habit,
    List<Record>? grassRecords,
  }) = _HabitWithGrass;
}
