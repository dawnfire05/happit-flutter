import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: [
      BottomNavigationBarItem(
        icon: IconButton(
          icon: SvgPicture.asset('assets/icons/home-black.svg'),
          onPressed: () => Navigator.pushReplacementNamed(context, '/'),
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          icon: SvgPicture.asset('assets/icons/profile-outline.svg'),
          onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          icon: Container(
            height: 48,
            width: 48,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xff66D271),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset('assets/icons/Pluse.svg'),
          ),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, '/habit/add'),
        ),
        label: '',
      ),
    ]);
  }
}
