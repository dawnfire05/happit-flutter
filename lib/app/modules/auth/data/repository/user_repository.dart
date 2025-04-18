import 'package:dio/dio.dart';
import 'package:happit_flutter/app/modules/auth/data/model/sign_up_model.dart';
import 'package:happit_flutter/app/modules/auth/data/repository/token_repository.dart';
import 'package:happit_flutter/app/modules/profile/data/model/user_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserRepository {
  final Dio _dio;
  final TokenRepository _tokenRepository;

  @factoryMethod
  UserRepository(this._dio, this._tokenRepository);

  static const String _baseUrl = '/user';

  Future<SignUpModel> signUp(SignUpModel model) async {
    try {
      final response = await _dio.post(
        _baseUrl,
        data: model.toJson(),
      );
      return SignUpModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getProfile() async {
    try {
      final response = await _dio.get('$_baseUrl/profile');
      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getUser(String id) async {
    try {
      await _dio.get('$_baseUrl/$id');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(String id, Map<String, dynamic> data) async {
    try {
      await _dio.put(
        '$_baseUrl/$id',
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _dio.delete('$_baseUrl/$id');
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> get isUserLoggedIn async {
    try {
      await getProfile();
      return true;
    } catch (e) {
      return false;
    }
  }
}
