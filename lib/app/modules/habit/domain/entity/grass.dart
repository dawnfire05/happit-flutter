import 'package:freezed_annotation/freezed_annotation.dart';

part 'grass.freezed.dart';

@freezed
abstract class GrassRecordEntry with _$GrassRecordEntry {
  const factory GrassRecordEntry({
    required String date,
    required String state,
  }) = _GrassRecordEntry;
}

@freezed
abstract class Grass with _$Grass {
  const factory Grass({
    required int habitId,
    required List<GrassRecordEntry> records,
  }) = _Grass;
}
