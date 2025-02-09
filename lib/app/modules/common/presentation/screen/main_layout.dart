import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/modules/auth/presentation/bloc/auth_bloc.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/happit_app_bar.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/happit_bottom_navigation_bar.dart';
import 'package:happit_flutter/routes/routes.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HappitAppBar(),
      body: child,
      bottomNavigationBar: const HappitBottomNavigationBar(),
    );
  }
}
