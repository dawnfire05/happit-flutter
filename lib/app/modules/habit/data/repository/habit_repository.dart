import 'package:dio/dio.dart';
import 'package:happit_flutter/app/modules/habit/data/model/create_habit_model.dart';
import 'package:happit_flutter/app/modules/habit/data/model/habit_model.dart';
import 'package:happit_flutter/app/modules/habit/data/model/update_habit_model.dart';
import 'package:retrofit/retrofit.dart';

part 'habit_repository.g.dart';

@RestApi(baseUrl: 'http://43.203.208.152:3000/habit')
abstract class HabitRepository {
  factory HabitRepository(Dio dio) = _HabitRepository;

  @POST('')
  Future<String> addHabit(@Body() CreateHabitModel createHabitModel);

  @GET('')
  Future<List<HabitModel>> getHabits();

  @GET('{id}')
  Future<HabitModel> getHabit(@Path() int id);

  @PATCH('{id}')
  Future<HabitModel> updateHabit(
    @Path() int id,
    @Body() UpdateHabitModel updateHabitModel,
  );

  @DELETE('{id}')
  Future<void> deleteHabit(@Path() int id);
}
