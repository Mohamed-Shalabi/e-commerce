part of 'sign_up_cubit.dart';

abstract class SignUpState {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpLoading extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpSucceeded extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpFailed extends SignUpState {
  const SignUpFailed(this.message);

  final String message;

  @override
  List<Object> get props => [];
}
