import 'package:dio/dio.dart';
import 'package:happit_flutter/app/modules/habit/data/model/create_habit_model.dart';
import 'package:happit_flutter/app/modules/habit/data/model/habit_model.dart';
import 'package:happit_flutter/app/modules/habit/data/model/update_habit_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'habit_data_source.g.dart';

@singleton
@RestApi(baseUrl: 'habit/')
abstract class HabitDataSource {
  @factoryMethod
  factory HabitDataSource(Dio dio) = _HabitDataSource;

  @POST('')
  Future<void> createHabit(@Body() CreateHabitModel createHabitModel);

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
