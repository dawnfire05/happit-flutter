import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/happit_app_bar.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/happit_bottom_navigation_bar.dart';
import 'package:happit_flutter/app/modules/user/presentation/bloc/user_bloc.dart';
import 'package:happit_flutter/routes/routes.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        state.whenOrNull(
            unauthenticated: (e) => const SignInRoute().go(context));
      },
      child: Scaffold(
        appBar: const HappitAppBar(),
        body: widget.child,
        bottomNavigationBar: const HappitBottomNavigationBar(),
      ),
    );
  }
}
