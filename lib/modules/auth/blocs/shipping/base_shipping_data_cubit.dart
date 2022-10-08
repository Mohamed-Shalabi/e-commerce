import 'package:e_commerce/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class ShippingDataProvider {
  final phoneController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();

  final shippingDataFormKey = GlobalKey<FormState>();

  bool get isShippingDataFormValidated =>
      shippingDataFormKey.currentState!.validate();

  void updateShippingData() {
    final user = UserModel.getInstance();
    phoneController.text = user.phone;
    countryController.text = user.country;
    cityController.text = user.city;
    addressController.text = user.address;
  }
}
