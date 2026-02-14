import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/di/get_it.dart';
import 'package:happit_flutter/app/modules/auth/presentation/bloc/sign_up_bloc.dart';
import 'package:happit_flutter/app/modules/auth/presentation/widget/sign_up_content.dart';
import 'package:happit_flutter/routes/routes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignUpBloc>(),
      child: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state.isSuccess) {
            const SignInRoute().go(context);
          }
        },
        child: const SignUpContent(),
      ),
    );
  }
}
