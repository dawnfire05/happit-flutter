import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: [
      BottomNavigationBarItem(
        icon: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => Navigator.pushReplacementNamed(context, '/'),
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
        ),
        label: 'profile',
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, '/habit/new'),
        ),
        label: 'new habit',
      ),
    ]);
  }
}
