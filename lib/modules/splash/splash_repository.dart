import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/modules/profile/profile_service.dart';
import 'package:e_commerce/modules/splash/splash_local_service.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';

abstract class SplashRepository {
  static Either<String, bool> isLoggedIn() {
    try {
      final isLoggedIn = SplashLocalService.isLoggedIn();
      return Right<String, bool>(isLoggedIn);
    } on SocketException {
      return const Left<String, bool>(AppStrings.connectionError);
    } catch (_) {
      return const Left<String, bool>(AppStrings.unknownError);
    }
  }

  static Future<Either<String, void>> getUserProfile() async {
    try {
      final result = await ProfileService.getUserProfile();
      if (result['status_code'] == 200) {
        UserModel.init(result['data']);
        return const Right<String, void>(null);
      }

      return Left<String, void>(result['message']);
    } on SocketException {
      return const Left<String, void>(AppStrings.connectionError);
    } catch (_) {
      return const Left<String, void>(AppStrings.unknownError);
    }
  }
}
