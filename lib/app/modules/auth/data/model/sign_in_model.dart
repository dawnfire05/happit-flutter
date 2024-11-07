import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_model.freezed.dart';
part 'sign_in_model.g.dart';

@freezed
class SignInModel with _$SignInModel {
  factory SignInModel(
    String username,
    String password,
  ) = _SignInModel;

  factory SignInModel.fromJson(Map<String, dynamic> json) =>
      _$SignInModelFromJson(json);
}
