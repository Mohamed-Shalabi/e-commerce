import 'package:e_commerce/modules/auth/blocs/login/login_cubit.dart';
import 'package:e_commerce/modules/auth/widgets/login_button.dart';
import 'package:e_commerce/modules/auth/widgets/navigate_to_sign_up_widget.dart';
import 'package:e_commerce/shared/components/my_card.dart';
import 'package:e_commerce/shared/functions/functions.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<LoginCubit>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyCard(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          padding: const EdgeInsets.all(16),
          child: Form(
            key: viewModel.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: viewModel.emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: 'email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? text) {
                    text = text ?? '';
                    if (!text.isValidEmail) {
                      return AppStrings.writeAnEmail;
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: viewModel.passwordController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: 'password',
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  validator: (String? text) {
                    text = text ?? '';
                    if (text.isEmpty) {
                      return AppStrings.writeAPassword;
                    }

                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        const LoginButton(),
        const SizedBox(height: 16),
        const NavigateToSignUpWidget(),
      ],
    );
  }
}
