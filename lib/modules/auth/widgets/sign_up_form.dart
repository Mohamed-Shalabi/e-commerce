import 'package:e_commerce/modules/auth/blocs/sign_up/sign_up_cubit.dart';
import 'package:e_commerce/modules/auth/widgets/sign_up_button.dart';
import 'package:e_commerce/modules/auth/blocs/shipping/shipping_data_provider.dart';
import 'package:e_commerce/responsive/responsive_widget.dart';
import 'package:e_commerce/shared/components/my_card.dart';
import 'package:e_commerce/shared/functions/functions.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      padding: const EdgeInsets.all(16),
      child: ResponsiveWidget(
        mobileWidget: Column(
          children: const [
            BasicInputFormFields(),
            SizedBox(height: 8),
            AdditionalInputFormFields(),
            SizedBox(height: 8),
            SignUpButton(),
          ],
        ),
        tabletWidget: Row(
          children: [
            Expanded(
              child: Column(
                children: const [
                  BasicInputFormFields(),
                  SizedBox(height: 8),
                  SignUpButton(),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Expanded(child: AdditionalInputFormFields()),
          ],
        ),
      ),
    );
  }
}

class BasicInputFormFields extends StatelessWidget {
  const BasicInputFormFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<SignUpCubit>();
    return Form(
      key: context.read<SignUpCubit>().signUpFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: viewModel.nameController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.transparent,
              hintText: 'name',
            ),
            keyboardType: TextInputType.name,
            validator: (value) {
              value ??= '';
              if (value.length < 3 || !value.trim().contains(' ')) {
                return AppStrings.nameValidationText;
              }

              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: viewModel.emailController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.transparent,
              hintText: 'email',
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              value ??= '';
              if (!value.isValidEmail) {
                return AppStrings.emailValidationText;
              }

              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: viewModel.passwordController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lock),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.transparent,
              hintText: 'password',
            ),
            obscureText: true,
            validator: (value) {
              value ??= '';
              if (value.length < 8) {
                return AppStrings.passwordValidationText;
              }

              return null;
            },
          )
        ],
      ),
    );
  }
}

class AdditionalInputFormFields extends StatelessWidget {
  const AdditionalInputFormFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ShippingDataProvider>();
    return Form(
      key: context.read<ShippingDataProvider>().shippingDataFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: viewModel.phoneController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.call),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.transparent,
              hintText: 'phone',
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              value ??= '';
              // TODO: Check if the phone number is valid bu stackoverflow
              if (value.length < 11 || value.trim().contains(' ')) {
                return AppStrings.phoneValidationText;
              }

              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: viewModel.countryController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.flag),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.transparent,
              hintText: 'country',
            ),
            validator: (value) {
              value ??= '';
              if (value.isEmpty) {
                return AppStrings.countryValidationText;
              }

              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: viewModel.cityController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.location_city_sharp),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.transparent,
              hintText: 'city',
            ),
            validator: (value) {
              value ??= '';
              if (value.isEmpty) {
                return AppStrings.cityValidationText;
              }

              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: viewModel.addressController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.location_on),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.transparent,
              hintText: 'address',
            ),
            keyboardType: TextInputType.streetAddress,
            validator: (value) {
              value ??= '';
              if (value.isEmpty) {
                return AppStrings.addressValidationText;
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}
