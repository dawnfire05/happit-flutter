import 'package:dio/dio.dart';
import 'package:happit_flutter/app/modules/habit/data/model/add_or_update_record_model.dart';
import 'package:happit_flutter/app/modules/habit/data/model/grass_item_model.dart';
import 'package:happit_flutter/app/modules/habit/data/model/record_list_model.dart';
import 'package:happit_flutter/app/modules/habit/data/model/record_model.dart';
import 'package:happit_flutter/app/modules/habit/data/model/toggle_record_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'record_data_source.g.dart';

@singleton
@RestApi(baseUrl: 'record/')
abstract class RecordDataSource {
  @factoryMethod
  factory RecordDataSource(Dio dio) = _RecordDataSource;

  @GET('')
  Future<List<RecordListModel>> getRecordOfAllHabit();

  @GET('grass')
  Future<List<GrassItemModel>> getGrass(@Query('months') int months);

  @GET('{id}')
  Future<List<RecordModel>> getRecordOfOneHabit(@Path() String id);

  @POST('')
  Future<ToggleRecordResponseModel> addOrUpdateRecord(
      @Body() AddOrUpdateRecordModel addOrUpdateRecordModel);

  @DELETE('{id}')
  Future<void> removeRecord(@Path() String id);
}
