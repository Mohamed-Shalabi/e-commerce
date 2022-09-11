part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLogoutLoading extends ProfileState {}

class ProfileLogoutDone extends ProfileState {}

class ProfileLogoutFailed extends ProfileState {
  final String message;

  ProfileLogoutFailed({required this.message});
}
