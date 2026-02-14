import 'package:flutter/material.dart';
import 'package:happit_flutter/values/constants.dart';
import 'package:happit_flutter/values/palette.dart';

class HappitAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HappitAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.white,
      shadowColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'happit.',
            style: TextStyle(
              color: Palette.primaryText,
              letterSpacing: -0.96,
              fontSize: 24,
              fontFamily: Constants.montserratAlternates,
              fontWeight: FontWeight.w800,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
