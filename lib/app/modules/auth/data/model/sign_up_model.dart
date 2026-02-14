import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_model.freezed.dart';
part 'sign_up_model.g.dart';

@freezed
abstract class SignUpModel with _$SignUpModel {
  factory SignUpModel(
    String email,
    String username,
    String password,
  ) = _SignUpModel;

  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpModelFromJson(json);
}
