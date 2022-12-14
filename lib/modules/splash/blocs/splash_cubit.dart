import 'package:e_commerce/modules/splash/splash_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this.splashRepository)
      : super(
          const SplashState(SplashStates.loading),
        ) {
    getData();
  }

  final SplashRepository splashRepository;

  void getData() async {
    await Future.delayed(const Duration(seconds: 3));
    final isLoggedIn = splashRepository.isLoggedIn();
    emit(
      SplashState(
        isLoggedIn ? SplashStates.userLoggedIn : SplashStates.userNotLoggedIn,
      ),
    );
  }
}
