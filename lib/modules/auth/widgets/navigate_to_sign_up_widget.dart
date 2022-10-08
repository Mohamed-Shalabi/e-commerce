import 'package:e_commerce/core/functions/navigate.dart';
import 'package:e_commerce/core/styles/app_themes.dart';
import 'package:e_commerce/core/utils/app_strings.dart';
import 'package:e_commerce/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class NavigateToSignUpWidget extends StatelessWidget {
  const NavigateToSignUpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '${AppStrings.alreadyHaveAnAccount} ',
        children: [
          TextSpan(
            text: AppStrings.signUp.toUpperCase(),
            style: context.textTheme.labelLarge!.copyWith(
              color: context.colorScheme.primary,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => context.navigate(Routes.signUpRouteName),
          ),
        ],
      ),
    );
  }
}
