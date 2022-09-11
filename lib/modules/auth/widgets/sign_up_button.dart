import 'package:e_commerce/modules/auth/blocs/sign_up/sign_up_cubit.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: MaterialButton(
          onPressed: context.read<SignUpCubit>().signUp,
          color: context.colorScheme.secondary,
          child: MyText(
            AppStrings.signUp,
            style: TextStyle(color: context.colorScheme.onSecondary),
          ),
        ),
      ),
    );
  }
}
