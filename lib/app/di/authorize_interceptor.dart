import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:happit_flutter/app/di/get_it.dart';
import 'package:happit_flutter/app/modules/auth/data/model/refresh_model.dart';
import 'package:happit_flutter/app/modules/auth/data/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

class AuthorizeInterceptor extends Interceptor {
  final FlutterSecureStorage _secureStorage;
  final AuthRepository _authRepository;

  AuthorizeInterceptor(
    this._secureStorage,
    this._authRepository,
  );

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await _secureStorage.read(key: 'accessToken');
    options.headers['Authorization'] = 'Bearer $accessToken';
    return handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    final refreshToken = await _secureStorage.read(key: 'refreshToken');
    if (err.response?.statusCode == 401 && refreshToken != null) {
      try {
        final token = await _authRepository
            .refresh(RefreshModel(refreshToken: refreshToken));
        final newAccessToken = token.access_token;
        final newRefreshToken = token.refresh_token;

        await _secureStorage.write(key: 'accessToken', value: newAccessToken);
        await _secureStorage.write(key: 'refreshToken', value: newRefreshToken);

        err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        final clonedRequest = await getIt<Dio>().request(
          err.requestOptions.path,
          options: Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
          ),
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );
        return handler.resolve(clonedRequest);
      } catch (e) {
        print("Token refresh failed: ${e.toString()}");
        return handler.next(err);
      }
    }
    return handler.next(err);
  }
}
