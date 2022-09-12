import 'package:e_commerce/modules/auth/auth_repository.dart';
import 'package:e_commerce/modules/cart/blocs/base_shipping_data_cubit.dart';

part 'sign_up_state.dart';

class SignUpCubit extends BaseShippingDataCubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  void signUp() async {
    if (signUpFormKey.currentState!.validate()) {
      emit(SignUpLoading());
      final result = await AuthRepository.signUp(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        phone: phoneController.text.trim(),
        country: countryController.text.trim(),
        city: cityController.text.trim(),
        address: addressController.text.trim(),
      );

      result.fold<void>(
        (l) => emit(SignUpFailed(l)),
        (r) => emit(SignUpSucceeded()),
      );
    }
  }
}
