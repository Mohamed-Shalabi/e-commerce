import 'package:e_commerce/modules/auth/widgets/sign_up_form.dart';
import 'package:e_commerce/modules/auth/widgets/sign_up_welcome_text.dart';
import 'package:flutter/material.dart';

class TabletSignUpScreenBody extends StatelessWidget {
  const TabletSignUpScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: const [
          Expanded(
            flex: 1,
            child: SignUpWelcomeText(),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: SignUpForm(),
            ),
          ),
        ],
      ),
    );
  }
}
