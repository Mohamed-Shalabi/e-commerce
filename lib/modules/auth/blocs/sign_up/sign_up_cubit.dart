import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/modules/auth/auth_repository.dart';
import 'package:e_commerce/shared/errors/base_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();

  UserModel? user;

  void signUp() async {
    try {
      emit(SignUpLoading());
      user = await AuthRepository.signUp(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        phone: phoneController.text.trim(),
        country: 'Egypt',
        city: 'Mansoura',
        address: addressController.text.trim(),
      );
      emit(SignUpSucceeded());
    } on BaseException catch (e) {
      emit(SignUpFailed(e.message));
    }
  }
}
