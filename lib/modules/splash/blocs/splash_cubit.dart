import 'package:e_commerce/modules/splash/repositories/splash_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashStateInitial());

  void getData() async {
    emit(SplashStateLoading());
    await Future.delayed(const Duration(seconds: 2));
    final isLoggedIn = SplashRepository.isLoggedIn();
    isLoggedIn.fold<void>(
      (l) => emit(SplashStateError(message: l)),
      _isLoggedInSuccessCallback,
    );
  }

  void _isLoggedInSuccessCallback(bool isLoggedIn) async {
    if (isLoggedIn) {
      final result = await SplashRepository.getUserProfile();
      result.fold<void>(
        (l) => emit(SplashStateError(message: l)),
        (r) => emit(SplashStateLoggedIn()),
      );
    } else {
      emit(SplashStateNotLoggedIn());
    }
  }
}
