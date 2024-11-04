import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_repository.g.dart';

@RestApi(baseUrl: 'http://43.203.208.152:3000/auth')
abstract class AuthRepository {
  factory AuthRepository(Dio dio) = _AuthRepository;

  @POST('login')
  Future<void> login();

  @POST('refresh')
  Future<void> refresh();

  @POST('logout')
  Future<void> logout();

  @GET('kakao')
  Future<void> kakao();

  @GET('kakao/callback')
  Future<void> kakaoCallback();
}
