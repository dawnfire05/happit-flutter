import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/record.dart';

part 'record_model.freezed.dart';
part 'record_model.g.dart';

@freezed
class RecordModel with _$RecordModel {
  const factory RecordModel({
    @Default(0) int id,
    @Default("") String date,
    @Default("") String state,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _RecordModel;

  factory RecordModel.fromJson(Map<String, Object?> json) =>
      _$RecordModelFromJson(json);
}

extension RecordModelX on RecordModel {
  Record toEntity() => Record(
        id: id,
        date: date,
        state: state,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
