import 'package:dio/dio.dart';
import 'package:happit_flutter/app/modules/habit/data/model/create_habit_model.dart';
import 'package:retrofit/retrofit.dart';

part 'habit_repository.g.dart';

@RestApi(baseUrl: 'http://43.203.208.152:3000/habit')
abstract class HabitRepository {
  factory HabitRepository(Dio dio, {String baseUrl}) = _HabitRepository;

  @POST('')
  Future<String> addHabit(@Body() CreateHabitModel createHabitModel);
}


/**
  Future<String> addHabit(
    String habitName,
    String habitDescription,
    String habitRepeatType,
    List<String> repeatDays,
    int selectedColorIndex,
  ) async {
    const String endpoint = 'http://43.203.208.152:3000/habit';

    final Map<String, dynamic> habitData = {
      'name': habitName,
      'description': habitDescription,
      'repeatType': habitRepeatType,
      'repeatDay': repeatDays,
      'themeColor': selectedColorIndex
    };

    final response = await http.post(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3QiLCJzdWIiOjEsImlhdCI6MTczMDM3NjUwNywiZXhwIjoxNzMwMzc4MzA3fQ.7fl3T5ZTzSN0k8DmUuid8lSGiwZWGyZDU8W6_uARTCE',
      },
      body: jsonEncode(habitData),
    );

    if (response.statusCode == 201) {
      return '201';
    } else {
      return ('Failed to add habit: ${response.body}');
    }
  }

  **/