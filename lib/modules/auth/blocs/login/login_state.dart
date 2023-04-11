part of 'login_cubit.dart';

abstract class LoginState implements ContextState {
  @override
  Set<Type> get parentStates => {LoginState};

}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSucceeded extends LoginState {}

class LoginFailed extends LoginState {
  LoginFailed(this.message);

  final String message;
}
