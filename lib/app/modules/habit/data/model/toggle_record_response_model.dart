import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/habit/data/model/record_model.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/toggle_record_response.dart';

part 'toggle_record_response_model.freezed.dart';
part 'toggle_record_response_model.g.dart';

@freezed
abstract class ToggleRecordResponseModel with _$ToggleRecordResponseModel {
  const factory ToggleRecordResponseModel({
    required RecordModel record,
    required int updatedStreak,
    required int longestStreak,
    DateTime? lastCompletedAt,
    required String timestamp,
  }) = _ToggleRecordResponseModel;

  factory ToggleRecordResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ToggleRecordResponseModelFromJson(json);
}

extension ToggleRecordResponseModelX on ToggleRecordResponseModel {
  ToggleRecordResponse toEntity() => ToggleRecordResponse(
        record: record.toEntity(),
        updatedStreak: updatedStreak,
        longestStreak: longestStreak,
        lastCompletedAt: lastCompletedAt,
        timestamp: DateTime.parse(timestamp),
      );
}
