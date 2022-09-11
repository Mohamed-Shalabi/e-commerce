import 'package:e_commerce/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit()
      : user = UserModel.getInstance(),
        super(ProfileInitial());

  final UserModel user;

}
