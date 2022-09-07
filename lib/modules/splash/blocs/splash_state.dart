part of 'splash_cubit.dart';

enum SplashStates { loading, userLoggedIn, userNotLoggedIn }

@immutable
class SplashState {
  final SplashStates state;

  const SplashState(this.state);
}
