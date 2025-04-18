import 'package:dio/dio.dart';
import 'package:happit_flutter/app/modules/habit/data/model/add_or_update_record_model.dart';
import 'package:happit_flutter/app/modules/habit/data/model/record_list_model.dart';
import 'package:happit_flutter/app/modules/habit/data/model/record_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'record_repository.g.dart';

@singleton
@RestApi(baseUrl: 'record/')
abstract class RecordRepository {
  @factoryMethod
  factory RecordRepository(Dio dio) = _RecordRepository;

  @GET('')
  Future<List<RecordListModel>> getRecordOfAllHabit();

  @GET('{id}')
  Future<List<RecordModel>> getRecordOfOneHabit(@Path() int id);

  @POST('')
  Future<void> addOrUpdateRecord(
      @Body() AddOrUpdateRecordModel addOrUpdateRecordModel);
}
