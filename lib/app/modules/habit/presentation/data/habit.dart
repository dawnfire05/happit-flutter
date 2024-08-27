import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> habitPost(String habitName, String habitDescription) async {
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
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3QiLCJzdWIiOjEsImlhdCI6MTcyMzUzNDEyOSwiZXhwIjoxNzIzNTM1OTI5fQ.DoflVCuTYxIPCNOR3hCHdz1A9tx2QYqdayhFBRfCxFU',
    },
    body: jsonEncode(habitData),
  );
}
