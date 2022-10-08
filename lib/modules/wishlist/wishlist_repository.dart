import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/wishlist/wishlist_service.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';

abstract class WishlistRepository {
  static Future<Either<String, List<ProductListModel>>> getWishlist() async {
    try {
      final result = await WishlistService.fetchWishList();
      if (result['status_code'] == 200) {
        final jsonData = json.decode(result['data']);
        final wishlist = ProductListModel.parseList(
          jsonData.cast<Map<String, dynamic>>(),
        );
        return Right<String, List<ProductListModel>>(wishlist);
      }

      return Left<String, List<ProductListModel>>(result['message']);
    } on SocketException {
      return const Left<String, List<ProductListModel>>(
        AppStrings.connectionError,
      );
    } catch (_) {
      return const Left<String, List<ProductListModel>>(
        AppStrings.unknownError,
      );
    }
  }

  static Future<Either<String, List<ProductListModel>>> addProductToWishlist(
    int productId,
  ) async {
    try {
      final result = await WishlistService.addProductToWishlist(productId);
      if (result['status_code'] == 200) {
        final jsonData = json.decode(result['data']);
        final wishlist = ProductListModel.parseList(
          jsonData.cast<Map<String, dynamic>>(),
        );
        return Right<String, List<ProductListModel>>(wishlist);
      }

      return Left<String, List<ProductListModel>>(result['message']);
    } on SocketException {
      return const Left<String, List<ProductListModel>>(
        AppStrings.connectionError,
      );
    } catch (_) {
      return const Left<String, List<ProductListModel>>(
        AppStrings.unknownError,
      );
    }
  }

  static Future<Either<String, List<ProductListModel>>>
      removeProductFromWishlist(int productId) async {
    try {
      final result = await WishlistService.removeProductFromWishlist(productId);
      if (result['status_code'] == 200) {
        final jsonData = json.decode(result['data']);
        final wishlist = ProductListModel.parseList(
          jsonData.cast<Map<String, dynamic>>(),
        );
        return Right<String, List<ProductListModel>>(wishlist);
      }

      return Left<String, List<ProductListModel>>(result['message']);
    } on SocketException {
      return const Left<String, List<ProductListModel>>(
        AppStrings.connectionError,
      );
    } catch (_) {
      return const Left<String, List<ProductListModel>>(
        AppStrings.unknownError,
      );
    }
  }
}
