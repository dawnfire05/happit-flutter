import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/modules/auth/presentation/bloc/auth_bloc.dart';
import 'package:happit_flutter/routes/routes.dart';
import 'package:happit_flutter/values/palette.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: () => const HabitListRoute().go(context),
          unauthenticated: () => const SignInRoute().go(context),
        );
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/logo/logo.svg',
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                '매일 조금씩',
                style: TextStyle(
                  color: Palette.black100,
                  fontSize: 24,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -2.40,
                ),
              ),
              const Text(
                '성장하는 나.',
                style: TextStyle(
                  color: Palette.black100,
                  fontSize: 24,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -2.40,
                ),
              ),
              // MainButton.cta(
              //   text: '메인 화면',
              //   onPressed: () => const HabitListRoute().go(context),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
