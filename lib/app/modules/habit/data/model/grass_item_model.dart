import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/habit/data/model/grass_record_item_model.dart';

part 'grass_item_model.freezed.dart';
part 'grass_item_model.g.dart';

@freezed
abstract class GrassItemModel with _$GrassItemModel {
  const factory GrassItemModel({
    required int habitId,
    required List<GrassRecordItemModel> records,
  }) = _GrassItemModel;

  factory GrassItemModel.fromJson(Map<String, dynamic> json) =>
      _$GrassItemModelFromJson(json);
}
