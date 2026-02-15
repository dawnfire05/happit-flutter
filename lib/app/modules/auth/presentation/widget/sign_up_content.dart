import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/modules/auth/presentation/bloc/sign_up_bloc.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/main_button.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_text_widget.dart';
import 'package:happit_flutter/routes/routes.dart';

class SignUpContent extends StatelessWidget {
  const SignUpContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '회원가입',
          style: TextStyle(
            color: Color(0xFF1F2329),
            fontSize: 18,
            fontWeight: FontWeight.w700,
            height: 0,
            letterSpacing: -1.44,
          ),
        ),
      ),
      body: BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (prev, curr) =>
            prev.formEmail != curr.formEmail ||
            prev.formUsername != curr.formUsername ||
            prev.formPassword != curr.formPassword ||
            prev.isLoading != curr.isLoading,
        builder: (context, state) {
          final email = state.formEmail;
          final username = state.formUsername;
          final password = state.formPassword;
          final isLoading = state.isLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
            child: AutofillGroup(
              child: Column(
                children: [
                  InputTextWidget.full(
                    value: email,
                    onChanged: (v) => context.read<SignUpBloc>().add(
                      SignUpEvent.emailChanged(v),
                    ),
                    label: '이메일',
                    informationText: '이메일을 입력해주세요.',
                    hintText: '',
                    necessary: true,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.email],
                  ),
                  const SizedBox(height: 18),
                  InputTextWidget.full(
                    value: username,
                    onChanged: (v) => context.read<SignUpBloc>().add(
                      SignUpEvent.usernameChanged(v),
                    ),
                    label: '유저이름',
                    informationText: '유저이름을 입력해주세요',
                    hintText: '',
                    necessary: true,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.username],
                  ),
                  const SizedBox(height: 18),
                  InputTextWidget.full(
                    value: password,
                    onChanged: (v) => context.read<SignUpBloc>().add(
                      SignUpEvent.passwordChanged(v),
                    ),
                    label: '비밀번호',
                    informationText: '비밀번호를 입력해주세요.',
                    hintText: '',
                    necessary: true,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.newPassword],
                  ),
                  const SizedBox(height: 24),
                  MainButton.basic(
                    text: '로그인으로 이동',
                    onPressed: isLoading
                        ? null
                        : () => const SignInRoute().go(context),
                  ),
                  const SizedBox(height: 16),
                  MainButton.cta(
                    text: '회원가입',
                    onPressed: isLoading
                        ? null
                        : () => context.read<SignUpBloc>().add(
                            const SignUpEvent.signUp(),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
