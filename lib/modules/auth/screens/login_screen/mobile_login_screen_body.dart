import 'package:e_commerce/modules/auth/widgets/login_form.dart';
import 'package:e_commerce/modules/auth/widgets/login_screen_welcome_text.dart';
import 'package:flutter/material.dart';

class MobileLoginScreenBody extends StatelessWidget {
  const MobileLoginScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: LoginScreenWelcomeText(),
        ),
        LoginForm(),
      ],
    );
  }
}
