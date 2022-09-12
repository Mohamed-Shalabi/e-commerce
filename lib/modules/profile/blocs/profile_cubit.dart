import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/modules/profile/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit()
      : user = UserModel.getInstance(),
        super(ProfileInitial());

  final UserModel user;

  void logout() async {
    emit(ProfileLogoutLoading());
    final result = await ProfileRepository.logout();
    result.fold<void>(
      (l) => emit(ProfileLogoutFailed(message: l)),
      (r) => emit(ProfileLogoutDone()),
    );
  }
}
