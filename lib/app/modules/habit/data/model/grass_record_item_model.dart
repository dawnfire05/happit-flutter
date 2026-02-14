import 'package:freezed_annotation/freezed_annotation.dart';

part 'grass_record_item_model.freezed.dart';
part 'grass_record_item_model.g.dart';

@freezed
abstract class GrassRecordItemModel with _$GrassRecordItemModel {
  const factory GrassRecordItemModel({
    required String date,
    required String state,
  }) = _GrassRecordItemModel;

  factory GrassRecordItemModel.fromJson(Map<String, dynamic> json) =>
      _$GrassRecordItemModelFromJson(json);
}
