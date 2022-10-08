import 'package:e_commerce/core/components/my_text.dart';
import 'package:e_commerce/core/styles/app_themes.dart';
import 'package:e_commerce/core/utils/app_strings.dart';
import 'package:e_commerce/modules/auth/blocs/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<LoginCubit>();
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: MaterialButton(
          onPressed: viewModel.login,
          color: context.colorScheme.secondary,
          child: MyText(
            AppStrings.login,
            style: TextStyle(color: context.colorScheme.onSecondary),
          ),
        ),
      ),
    );
  }
}
