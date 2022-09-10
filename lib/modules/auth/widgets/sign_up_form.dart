import 'package:e_commerce/modules/auth/blocs/sign_up/sign_up_cubit.dart';
import 'package:e_commerce/modules/auth/widgets/sign_up_button.dart';
import 'package:e_commerce/responsive/responsive_Builder.dart';
import 'package:e_commerce/shared/components/my_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      padding: const EdgeInsets.all(16),
      child: Form(
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
      ),
    );
  }
}

class BasicInputFormFields extends StatelessWidget {
  const BasicInputFormFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<SignUpCubit>();
    return Column(
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
        )
      ],
    );
  }
}

class AdditionalInputFormFields extends StatelessWidget {
  const AdditionalInputFormFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<SignUpCubit>();
    return Column(
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
        ),
      ],
    );
  }
}
