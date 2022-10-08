import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/utils/app_strings.dart';
import 'package:e_commerce/modules/products/models/product_model.dart';
import 'package:e_commerce/modules/wishlist/services/wishlist_service.dart';

abstract class WishlistRepository {
  static Future<Either<String, List<ProductListModel>>> getWishlist() async {
    try {
      final result = await WishlistService.fetchWishList();
      if (result.statusCode == 200) {
        final jsonData = json.decode(result.body);
        final wishlist = ProductListModel.parseList(
          jsonData.cast<Map<String, dynamic>>(),
        );
        return Right<String, List<ProductListModel>>(wishlist);
      }

      return Left<String, List<ProductListModel>>(result.body);
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
      if (result.statusCode == 200) {
        final jsonData = json.decode(result.body);
        final wishlist = ProductListModel.parseList(
          jsonData.cast<Map<String, dynamic>>(),
        );
        return Right<String, List<ProductListModel>>(wishlist);
      }

      return Left<String, List<ProductListModel>>(result.body);
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
      if (result.statusCode == 200) {
        final jsonData = json.decode(result.body);
        final wishlist = ProductListModel.parseList(
          jsonData.cast<Map<String, dynamic>>(),
        );
        return Right<String, List<ProductListModel>>(wishlist);
      }

      return Left<String, List<ProductListModel>>(result.body);
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
