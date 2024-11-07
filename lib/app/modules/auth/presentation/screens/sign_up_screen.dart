import 'package:flutter/material.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/main_button.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/input_text_widget.dart';
import 'package:happit_flutter/routes/routes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _userNameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '회원가입',
            style: TextStyle(
              color: Color(0xFF1F2329),
              fontSize: 18,
              fontFamily: 'Noto Sans KR',
              fontWeight: FontWeight.w700,
              height: 0,
              letterSpacing: -1.44,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  InputTextWidget.full(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    label: '이메일',
                    informationText: '이메일을 입력해주세요.',
                    hintText: '',
                    necessary: true,
                  ),
                  const SizedBox(height: 18),
                  InputTextWidget.full(
                    controller: _userNameController,
                    focusNode: _userNameFocusNode,
                    label: '유저이름',
                    informationText: '유저이름을 입력해주세요',
                    hintText: '',
                    necessary: true,
                  ),
                  const SizedBox(height: 18),
                  InputTextWidget.full(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    label: '비밀번호',
                    informationText: '비밀번호를 입력해주세요.',
                    hintText: '',
                    necessary: true,
                  ),
                ],
              ),
              Column(
                children: [
                  MainButton.basic(
                    text: '로그인으로 이동',
                    onPressed: () => const SignInRoute().go(context),
                  ),
                  const SizedBox(height: 16),
                  MainButton.cta(text: '회원가입', onPressed: () {}),
                ],
              )
            ],
          ),
        ));
  }
}
