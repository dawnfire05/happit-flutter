import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/di/get_it.dart';
import 'package:happit_flutter/app/modules/auth/presentation/bloc/sign_in_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignInBloc>(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Text('프로필'),
              BlocBuilder<SignInBloc, SignInState>(
                builder: (context, state) {
                  return ElevatedButton(
                      onPressed: () {
                        context
                            .read<SignInBloc>()
                            .add(const SignInEvent.logout());
                      },
                      child: const Text('로그아웃'));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
