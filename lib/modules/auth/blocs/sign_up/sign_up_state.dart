part of 'sign_up_cubit.dart';

class SignUpState implements ContextState {
  @override
  Set<Type> get parentStates => {SignUpState};
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSucceeded extends SignUpState {}

class SignUpFailed extends SignUpState {
  SignUpFailed(this.message);

  final String message;
}
