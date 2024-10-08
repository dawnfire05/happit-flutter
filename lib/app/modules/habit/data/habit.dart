import 'dart:convert';

import 'package:http/http.dart' as http;

void addHabit(
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
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3QiLCJzdWIiOjEsImlhdCI6MTcyNDc2MzU4NywiZXhwIjoxNzI0NzY1Mzg3fQ.uSBT1xGtIqwMHxYKNpjZgqCPCsWEt74GttSo2FtLWEw',
    },
    body: jsonEncode(habitData),
  );

  if (response.statusCode == 201) {
    print('Habit added successfully');
  } else {
    print('Failed to add habit: ${response.body}');
  }
}
