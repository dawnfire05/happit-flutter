import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/record.dart';

part 'toggle_record_response.freezed.dart';

@freezed
abstract class ToggleRecordResponse with _$ToggleRecordResponse {
  const factory ToggleRecordResponse({
    required Record record,
    required int updatedStreak,
    required int longestStreak,
    DateTime? lastCompletedAt,
    required DateTime timestamp,
  }) = _ToggleRecordResponse;
}
