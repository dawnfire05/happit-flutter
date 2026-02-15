import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/modules/auth/presentation/bloc/auth_bloc.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/main_button.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_text_widget.dart';
import 'package:happit_flutter/routes/routes.dart';
import 'package:happit_flutter/values/palette.dart';

class SignInContent extends StatelessWidget {
  const SignInContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '로그인',
          style: TextStyle(
            color: Palette.black100,
            fontSize: 18,

            fontWeight: FontWeight.w700,
            height: 0,
            letterSpacing: -1.44,
          ),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (prev, curr) =>
            curr.errorMessage != prev.errorMessage ||
            curr.isAuthenticated != prev.isAuthenticated,
        listener: (context, state) {
          final message = state.errorMessage;
          if (message != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          }
          if (state.isAuthenticated) {
            const HabitListRoute().go(context);
          }
        },
        buildWhen: (prev, curr) =>
            prev.formUsername != curr.formUsername ||
            prev.formPassword != curr.formPassword ||
            prev.isLoading != curr.isLoading,
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
            child: Column(
              children: [
                InputTextWidget.full(
                  value: state.formUsername,
                  onChanged: (v) => context.read<AuthBloc>().add(
                    AuthEvent.signInUsernameChanged(v),
                  ),
                  label: '유저이름',
                  informationText: '유저이름을 입력해주세요',
                  hintText: '',
                  necessary: true,
                ),
                const SizedBox(height: 18),
                InputTextWidget.full(
                  value: state.formPassword,
                  onChanged: (v) => context.read<AuthBloc>().add(
                    AuthEvent.signInPasswordChanged(v),
                  ),
                  label: '비밀번호',
                  informationText: '비밀번호를 입력해주세요.',
                  hintText: '',
                  necessary: true,
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                MainButton.basic(
                  text: '회원가입으로 이동',
                  onPressed: state.isLoading
                      ? null
                      : () => const SignUpRoute().go(context),
                ),
                const SizedBox(height: 24),
                MainButton.cta(
                  text: '로그인',
                  onPressed: state.isLoading
                      ? null
                      : () => context
                            .read<AuthBloc>()
                            .add(const AuthEvent.signIn()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
