import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happit_flutter/routes/routes.dart';

class HappitBottomNavigationBar extends StatefulWidget {
  const HappitBottomNavigationBar({super.key});

  @override
  HappitBottomNavigationBarState createState() =>
      HappitBottomNavigationBarState();
}

class HappitBottomNavigationBarState extends State<HappitBottomNavigationBar> {
  int _currentIndex = 0;

  void _onTap(BuildContext context, int index) {
    if (index == 2) {
      const HabitCreatingRoute().push(context);
      return;
    }
    if (_currentIndex != index) {
      setState(() => _currentIndex = index);
      switch (index) {
        case 0:
          const HabitListRoute().push(context);
        case 1:
          const ProfileRoute().push(context);
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      backgroundColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      enableFeedback: false,
      onTap: (index) => _onTap(context, index),
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
