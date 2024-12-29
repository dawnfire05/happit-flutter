import 'package:dio/dio.dart';
import 'package:happit_flutter/app/modules/auth/data/model/refresh_model.dart';
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
  Future<TokenModel> refresh(@Body() RefreshModel refreshToken);

  @GET('kakao')
  Future<void> kakao();

  @GET('kakao/callback')
  Future<void> kakaoCallback();

  @POST('logout')
  Future<void> logout(@Body() RefreshModel refreshToken);
}
