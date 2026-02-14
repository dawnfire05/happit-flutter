import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/modules/auth/presentation/bloc/auth_bloc.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/main_button.dart';
import 'package:happit_flutter/routes/routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '프로필',
          style: TextStyle(
            color: Color(0xFF1F2329),
            fontSize: 18,
            fontFamily: 'Noto Sans KR',
            fontWeight: FontWeight.w700,
            height: 0,
            letterSpacing: -1.44,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            unauthenticated: () => const SignInRoute().go(context),
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    authenticated: (user) => Row(
                      children: [
                        Text(
                          '${user.username}님, 환영합니다.',
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w700,
                            letterSpacing: -1.28,
                          ),
                        ),
                      ],
                    ),
                    orElse: () => const Text(''),
                  );
                },
              ),
              MainButton.destructive(
                text: '로그아웃',
                onPressed: () =>
                    context.read<AuthBloc>().add(const AuthEvent.logout()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
