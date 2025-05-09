import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/modules/auth/presentation/bloc/auth_bloc.dart';
import 'package:happit_flutter/routes/routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('프로필'),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(const AuthEvent.logout());
                      const SignInRoute().go(context);
                    },
                    child: const Text('로그아웃'));
              },
            )
          ],
        ),
      ),
    );
  }
}
