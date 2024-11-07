import 'package:dio/dio.dart';
import 'package:happit_flutter/app/modules/auth/data/model/sign_in_model.dart';
import 'package:happit_flutter/app/modules/auth/data/model/sign_in_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_repository.g.dart';

@RestApi(baseUrl: 'http://43.203.208.152:3000/auth/')
abstract class AuthRepository {
  factory AuthRepository(Dio dio) = _AuthRepository;

  @POST('login')
  Future<SignInResponseModel> login(@Body() SignInModel model);

  @POST('refresh')
  Future<void> refresh();

  @GET('kakao')
  Future<void> kakao();

  @GET('kakao/callback')
  Future<void> kakaoCallback();
}
