import 'package:dio/dio.dart';
import 'package:happit_flutter/app/modules/auth/data/model/sign_up_model.dart';
import 'package:happit_flutter/app/modules/user/data/model/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'user_repository.g.dart';

@injectable
@RestApi(baseUrl: 'user/')
abstract class UserRepository {
  @factoryMethod
  factory UserRepository(Dio dio) = _UserRepository;

  @POST('')
  Future<SignUpModel> signUp(@Body() SignUpModel model);

  @GET('profile')
  Future<UserModel> getProfile();

  @GET('{id}')
  Future<void> getUser();

  @PUT('{id}')
  Future<void> updateUser();

  @DELETE('{id}')
  Future<void> deleteUser();
}
