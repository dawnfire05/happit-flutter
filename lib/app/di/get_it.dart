import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:happit_flutter/app/di/authorize_interceptor.dart';
import 'package:happit_flutter/app/di/get_it.config.dart';
import 'package:happit_flutter/app/modules/auth/data/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'dart:io';
import 'package:dio/io.dart';

final sl = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await dotenv.load();
  await sl.init();
  sl<Dio>().interceptors.add(sl<AuthorizeInterceptor>());
}

@module
abstract class RegisterModule {
  @singleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @singleton
  Dio get dio {
    final dio = Dio(BaseOptions(
      baseUrl: dotenv.get('SERVER_URL'),
      contentType: 'application/json',
      validateStatus: (status) => true,
    ));

    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback = (cert, host, port) => true;
      return client;
    };

    return dio;
  }

  @singleton
  AuthorizeInterceptor authorizeInterceptor(
      FlutterSecureStorage secureStorage, AuthRepository repository) {
    return AuthorizeInterceptor(secureStorage, repository);
  }
}
