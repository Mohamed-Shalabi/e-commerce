import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/utils/app_strings.dart';
import 'package:e_commerce/modules/profile/services/profile_service.dart';

abstract class ProfileRepository {
  static Future<Either<String, bool>> logout() async {
    try {
      final result = await ProfileService.logout();
      if (result.statusCode == 200) {
        return const Right<String, bool>(true);
      }

      return Left<String, bool>(result.body);
    } on SocketException {
      return const Left<String, bool>(AppStrings.connectionError);
    } catch (_) {
      return const Left<String, bool>(AppStrings.unknownError);
    }
  }
}
