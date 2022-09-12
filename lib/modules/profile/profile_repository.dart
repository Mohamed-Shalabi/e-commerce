import 'package:dartz/dartz.dart';
import 'package:e_commerce/modules/profile/profile_service.dart';

abstract class ProfileRepository {
  static Future<Either<String, bool>> logout() async {
    final result = await ProfileService.logout();
    if (result['status_code'] == 200) {
      return const Right<String, bool>(true);
    }

    return Left<String, bool>(result['message']);
  }
}
