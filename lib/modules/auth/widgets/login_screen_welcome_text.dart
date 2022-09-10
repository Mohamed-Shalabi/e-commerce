import 'package:e_commerce/shared/components/my_card.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';

class LoginScreenWelcomeText extends StatelessWidget {
  const LoginScreenWelcomeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      padding: const EdgeInsets.all(16),
      child: Text(
        AppStrings.welcomeLogin,
        style: context.textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}
