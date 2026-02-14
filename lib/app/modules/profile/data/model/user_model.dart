import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/auth/domain/entity/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const UserModel._();
  const factory UserModel({required int id, required String username}) =
      _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

extension UserModelX on UserModel {
  User toEntity() => User(id: id, username: username);
}
