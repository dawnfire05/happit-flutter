import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/habit/data/model/record_model.dart';

part 'record_list_model.freezed.dart';
part 'record_list_model.g.dart';

@freezed
class RecordListModel with _$RecordListModel {
  const factory RecordListModel({
    @Default(0) int habitId,
    List<RecordModel>? records,
  }) = _RecordListModel;

  factory RecordListModel.fromJson(Map<String, Object?> json) =>
      _$RecordListModelFromJson(json);
}
