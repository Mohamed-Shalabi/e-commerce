import 'package:e_commerce/modules/auth/repositories/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stateful_bloc/flutter_stateful_bloc.dart';

part 'login_state.dart';

class LoginCubit extends StatelessCubit<LoginState> {
  LoginCubit();

  final GlobalKey<FormState> formKey = GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoading());
      final result = await AuthRepository.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      result.fold<void>(
        (l) => emit(LoginFailed(l)),
        (r) => emit(LoginSucceeded()),
      );
    }
  }
}
