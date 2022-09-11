import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/modules/profile/profile_repository.dart';
import 'package:e_commerce/shared/errors/base_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit()
      : user = UserModel.getInstance(),
        super(ProfileInitial());

  final UserModel user;

  void logout() async {
    try {
      emit(ProfileLogoutLoading());
      await ProfileRepository.logout();
      emit(ProfileLogoutDone());
    } on BaseException catch (e) {
      emit(ProfileLogoutFailed(message: e.message));
    }
  }
}
