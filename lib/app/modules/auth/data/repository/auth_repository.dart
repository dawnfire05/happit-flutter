import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happit_flutter/app/modules/auth/data/model/sign_in_model.dart';
import 'package:happit_flutter/app/modules/auth/data/model/token_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_repository.g.dart';

@singleton
@RestApi(baseUrl: 'auth/')
abstract class AuthRepository {
  @factoryMethod
  factory AuthRepository(Dio dio) = _AuthRepository;

  @POST('login')
  Future<TokenModel> login(@Body() SignInModel model);

  @POST('refresh')
  Future<TokenModel> refresh(@Body() String refreshToken);

  @GET('kakao')
  Future<void> kakao();

  @GET('kakao/callback')
  Future<void> kakaoCallback();
}
