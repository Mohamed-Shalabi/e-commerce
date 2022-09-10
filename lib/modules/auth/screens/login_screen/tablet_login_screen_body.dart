import 'package:e_commerce/modules/auth/widgets/login_form.dart';
import 'package:e_commerce/modules/auth/widgets/login_screen_welcome_text.dart';
import 'package:e_commerce/modules/auth/widgets/navigate_to_sign_up_widget.dart';
import 'package:flutter/material.dart';

class TabletLoginScreenBody extends StatelessWidget {
  const TabletLoginScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: LoginScreenWelcomeText(),
          ),
        ),
        VerticalDivider(),
        Expanded(flex: 5, child: LoginForm()),
      ],
    );
  }
}
