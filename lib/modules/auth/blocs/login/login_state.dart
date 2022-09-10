part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSucceeded extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginFailed extends LoginState {
  const LoginFailed(this.message);

  final String message;

  @override
  List<Object> get props => [];
}
