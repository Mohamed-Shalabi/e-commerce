part of 'splash_cubit.dart';

abstract class SplashState {}

class SplashStateInitial extends SplashState {}

class SplashStateLoading extends SplashState {}

class SplashStateNotLoggedIn extends SplashState {}

class SplashStateLoggedIn extends SplashState {}

class SplashStateNotConnected extends SplashState {}

class SplashStateError extends SplashState {
  final String message;

  SplashStateError({required this.message});
}
