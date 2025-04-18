import 'package:freezed_annotation/freezed_annotation.dart';

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
