import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/modules/auth/auth_repository.dart';
import 'package:e_commerce/shared/errors/base_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final GlobalKey<FormState> formKey = GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  UserModel? user;

  void login() async {
    try {
      if (formKey.currentState!.validate()) {
        emit(LoginLoading());
        user = await AuthRepository.login(
          emailController.text.trim(),
          passwordController.text.trim(),
        );
        emit(LoginSucceeded());
      }
    } on BaseException catch (e) {
      emit(LoginFailed(e.message));
    }
  }
}
