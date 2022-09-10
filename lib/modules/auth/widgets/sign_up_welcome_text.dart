import 'package:e_commerce/shared/components/my_card.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';

class SignUpWelcomeText extends StatelessWidget {
  const SignUpWelcomeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      padding: const EdgeInsets.all(16),
      child: MyText(
        AppStrings.signUpToUseTheApp,
        textAlign: TextAlign.center,
        style: context.textTheme.titleLarge,
      ),
    );
  }
}
