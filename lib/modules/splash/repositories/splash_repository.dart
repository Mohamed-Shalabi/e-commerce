import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/utils/app_strings.dart';
import 'package:e_commerce/modules/auth/models/user_model.dart';
import 'package:e_commerce/modules/profile/services/profile_service.dart';
import 'package:e_commerce/modules/splash/services/splash_local_service.dart';

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
      if (result.statusCode == 200) {
        final jsonData = json.decode(result.body);
        UserModel.init(jsonData);
        return const Right<String, void>(null);
      }

      return Left<String, void>(result.body);
    } on SocketException {
      return const Left<String, void>(AppStrings.connectionError);
    } catch (_) {
      return const Left<String, void>(AppStrings.unknownError);
    }
  }
}
