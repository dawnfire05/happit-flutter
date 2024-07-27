import 'package:flutter/material.dart';

class HabitWidget extends StatelessWidget {
  const HabitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Row(
            children: [Text('습관 이름'), Text('연속 n일')],
          ),
          Row(
            children: [
              Container(
                child: const Text('잔디밭이 여기에 들어옵니다.'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/habit/new'),
                child: const Icon(Icons.add),
              )
            ],
          )
        ],
      ),
    );
  }
}
