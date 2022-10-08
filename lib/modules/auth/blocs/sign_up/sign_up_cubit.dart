import 'package:e_commerce/modules/auth/repositories/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final signUpFormKey = GlobalKey<FormState>();

  bool get isSignUpFormValidated => signUpFormKey.currentState!.validate();

  void signUp(
    String phone,
    String country,
    String city,
    String address,
  ) async {
    emit(SignUpLoading());
    final result = await AuthRepository.signUp(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      phone: phone,
      country: country,
      city: city,
      address: address,
    );

    result.fold<void>(
      (l) => emit(SignUpFailed(l)),
      (r) => emit(SignUpSucceeded()),
    );
  }
}
