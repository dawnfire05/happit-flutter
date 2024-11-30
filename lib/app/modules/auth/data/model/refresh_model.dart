import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_model.freezed.dart';
part 'refresh_model.g.dart';

@freezed
class RefreshModel with _$RefreshModel {
  factory RefreshModel(
          {@JsonKey(name: 'refresh_token') required String refreshToken}) =
      _RefreshModel;

  factory RefreshModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshModelFromJson(json);
}
