import 'package:freezed_annotation/freezed_annotation.dart';

part 'record.freezed.dart';

@freezed
class Record with _$Record {
  const factory Record({
    required int id,
    required String date,
    required String state,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Record;
}
