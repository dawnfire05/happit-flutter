import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:happit_flutter/app/di/authorize_interceptor.dart';
import 'package:happit_flutter/app/di/get_it.config.dart';
import 'package:happit_flutter/app/modules/auth/data/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  getIt.init();
  getIt<Dio>().interceptors.add(getIt<AuthorizeInterceptor>());
}

@module
abstract class RegisterModule {
  @singleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @singleton
  Dio get dio => Dio(BaseOptions(
        baseUrl: "http://43.203.208.152:3000",
        contentType: 'application/json',
      ));

  @singleton
  AuthorizeInterceptor authorizeInterceptor(
      FlutterSecureStorage secureStorage, AuthRepository repository) {
    return AuthorizeInterceptor(secureStorage, repository);
  }
}
