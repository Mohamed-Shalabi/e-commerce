import 'package:e_commerce/modules/auth/widgets/sign_up_form.dart';
import 'package:e_commerce/modules/auth/widgets/sign_up_welcome_text.dart';
import 'package:flutter/material.dart';

class MobileSignUpScreenBody extends StatelessWidget {
  const MobileSignUpScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: SignUpWelcomeText(),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: SignUpForm(),
        ),
      ],
    );
  }
}
