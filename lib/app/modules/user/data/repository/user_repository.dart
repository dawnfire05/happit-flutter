import 'package:dio/dio.dart';
import 'package:happit_flutter/app/modules/auth/data/model/sign_up_model.dart';
import 'package:retrofit/retrofit.dart';

part 'user_repository.g.dart';

@RestApi(baseUrl: 'http://43.203.208.152:3000/user/')
abstract class UserRepository {
  factory UserRepository(Dio dio) = _UserRepository;

  @POST('')
  Future<SignUpModel> signUp(@Body() SignUpModel model);

  @GET('profile')
  Future<void> getProfile();

  @GET('{id}')
  Future<void> getUser();

  @PUT('{id}')
  Future<void> updateUser();

  @DELETE('{id}')
  Future<void> deleteUser();
}
