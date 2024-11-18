import 'dart:io';

import 'package:flutter/material.dart';

class HappitAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HappitAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.white,
      shadowColor: Colors.white,
      title: Row(
        children: [
          Text(
            'happit.',
            style: TextStyle(
              color: const Color(0xff56B45F),
              letterSpacing: Platform.isIOS ? -0.96 : 0,
              fontSize: 24,
              fontFamily: 'Montserrat Alternates',
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
