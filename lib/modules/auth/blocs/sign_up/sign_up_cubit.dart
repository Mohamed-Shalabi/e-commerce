import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/modules/auth/auth_repository.dart';
import 'package:e_commerce/modules/cart/blocs/base_shipping_data_cubit.dart';
import 'package:e_commerce/shared/errors/base_exception.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_state.dart';

class SignUpCubit extends BaseShippingDataCubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  UserModel? user;

  void signUp() async {
    try {
      if (signUpFormKey.currentState!.validate()) {
        emit(SignUpLoading());
        user = await AuthRepository.signUp(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          phone: phoneController.text.trim(),
          country: countryController.text.trim(),
          city: cityController.text.trim(),
          address: addressController.text.trim(),
        );

        emit(SignUpSucceeded());
      }
    } on BaseException catch (e) {
      emit(SignUpFailed(e.message));
    }
  }
}
