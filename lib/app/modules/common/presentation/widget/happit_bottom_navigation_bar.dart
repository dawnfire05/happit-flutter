import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:happit_flutter/routes/routes.dart';

class HappitBottomNavigationBar extends StatefulWidget {
  const HappitBottomNavigationBar({super.key});

  @override
  _HappitBottomNavigationBarState createState() =>
      _HappitBottomNavigationBarState();
}

class _HappitBottomNavigationBarState extends State<HappitBottomNavigationBar> {
  int _currentIndex = 0;

  final List<String> _routes = [
    const HabitListRoute().location,
    const ProfileRoute().location,
    const HabitCreatingRoute().location,
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      backgroundColor: Colors.white,
      onTap: (index) {
        setState(() => _currentIndex = index);
        if (index == 2) {
          context.push(_routes[index]);
        } else {
          context.go(_routes[index]);
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: _currentIndex == 0
              ? SvgPicture.asset('assets/icons/home-black.svg')
              : SvgPicture.asset('assets/icons/home-outline.svg'),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: _currentIndex == 1
              ? SvgPicture.asset('assets/icons/profile-black.svg')
              : SvgPicture.asset('assets/icons/profile-outline.svg'),
          label: '',
        ),
        BottomNavigationBarItem(
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
          label: '',
        ),
      ],
    );
  }
}
