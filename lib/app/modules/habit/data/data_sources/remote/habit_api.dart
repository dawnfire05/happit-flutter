import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'habit_api.g.dart';

@injectable
@RestApi(baseUrl: 'habit')
abstract class HabitApi {
  @factoryMethod
  factory HabitApi(Dio dio) = _HabitApi;

  @POST('')
  Future<HabitModel> createHabit(@Body)
}
