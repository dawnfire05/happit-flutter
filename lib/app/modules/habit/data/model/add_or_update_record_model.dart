import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_or_update_record_model.freezed.dart';
part 'add_or_update_record_model.g.dart';

@freezed
class AddOrUpdateRecordModel with _$AddOrUpdateRecordModel {
  const factory AddOrUpdateRecordModel({
    required String habitId,
    required String date,
    required String state,
  }) = _AddOrUpdateRecordModel;

  factory AddOrUpdateRecordModel.fromJson(Map<String, dynamic> json) =>
      _$AddOrUpdateRecordModelFromJson(json);
}
