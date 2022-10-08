import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/modules/auth/auth_service.dart';

abstract class AuthRepository {
  static Future<Either<String, UserModel>> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String country,
    required String city,
    required String address,
  }) async {
    try {
      final result = await AuthService.signUp(
        name: name,
        email: email,
        password: password,
        phone: phone,
        country: country,
        city: city,
        address: address,
      );

      if (result['status_code'] == 200) {
        final data = json.decode(result['data']);
        UserModel.init(data);
        return Right<String, UserModel>(UserModel.getInstance());
      }

      return Left<String, UserModel>(result['message']);
    } catch (e) {
      return Left<String, UserModel>(e.toString());
    }
  }

  static Future<Either<String, UserModel>> login(
    String email,
    String password,
  ) async {
    try {
      final result = await AuthService.login(email, password);

      if (result['status_code'] == 200) {
        final data = json.decode(result['data']);
        UserModel.init(data);
        return Right<String, UserModel>(UserModel.getInstance());
      }

      return Left<String, UserModel>(result['message']);
    } catch (e) {
      return Left<String, UserModel>(e.toString());
    }
  }
}
