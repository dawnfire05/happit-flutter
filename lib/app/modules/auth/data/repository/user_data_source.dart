import 'package:dio/dio.dart';
import 'package:happit_flutter/app/modules/auth/data/model/sign_up_model.dart';
import 'package:happit_flutter/app/modules/profile/data/model/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'user_data_source.g.dart';

@singleton
@RestApi(baseUrl: 'user/')
abstract class UserDataSource {
  @factoryMethod
  factory UserDataSource(Dio dio) = _UserDataSource;

  @POST('')
  Future<SignUpModel> signUp(@Body() SignUpModel model);

  @GET('profile')
  Future<UserModel> getProfile();

  @GET('{id}')
  Future<void> getUser(@Path() String id);

  @PUT('{id}')
  Future<void> updateUser(@Path() String id, @Body() Map<String, dynamic> data);

  @DELETE('{id}')
  Future<void> deleteUser(@Path() String id);
}
