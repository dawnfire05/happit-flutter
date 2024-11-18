import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_model.freezed.dart';
part 'token_model.g.dart';

@freezed
class TokenModel with _$TokenModel {
  factory TokenModel(
    // ignore: non_constant_identifier_names
    String access_token,
    // ignore: non_constant_identifier_names
    String refresh_token,
  ) = _TokenModel;

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);
}
