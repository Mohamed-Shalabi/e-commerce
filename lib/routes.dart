import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/auth/blocs/login/login_cubit.dart';
import 'package:e_commerce/modules/auth/blocs/sign_up/sign_up_cubit.dart';
import 'package:e_commerce/modules/auth/screens/login_screen/login_screen.dart';
import 'package:e_commerce/modules/auth/screens/sign_up_screen/sign_up_screen.dart';
import 'package:e_commerce/modules/cart/screens/cart_page.dart';
import 'package:e_commerce/modules/categories/blocs/categories_cubit.dart';
import 'package:e_commerce/modules/main_layout/blocs/main_layout_cubit.dart';
import 'package:e_commerce/modules/main_layout/screens/main_layout.dart';
import 'package:e_commerce/modules/products/blocs/products/products_cubit.dart';
import 'package:e_commerce/modules/products/blocs/single_product/product_cubit.dart';
import 'package:e_commerce/modules/products/screens/products_screen.dart';
import 'package:e_commerce/modules/products/screens/single_product_screen.dart';
import 'package:e_commerce/modules/splash/screens/splash_screen.dart';
import 'package:e_commerce/modules/wishlist/screens/wishlist_screen.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class Routes {
  static const splashRouteName = '/';
  static const mainLayoutRouteName = '/main_layout';
  static const wishlistRouteName = '/main_layout/wishlist';
  static const productsRouteName = '/main_layout/products';
  static const singleProductRouteName = '/main_layout/products/product';
  static const signUpRouteName = '/sign_up';
  static const loginRouteName = '/log_in';
  static const cartRouteName = '/main_layout/products/product/cart';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRouteName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case signUpRouteName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SignUpCubit(),
            child: const SignUpScreen(),
          ),
        );
      case loginRouteName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LoginCubit>(
            create: (_) => LoginCubit(),
            child: const LoginScreen(),
          ),
        );
      case mainLayoutRouteName:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) => MainLayoutCubit(context),
              ),
              BlocProvider(create: (_) => CategoriesCubit()..getCategories()),
            ],
            child: const MainLayout(),
          ),
        );
      case wishlistRouteName:
        return MaterialPageRoute(builder: (_) => const WishlistScreen());
      case productsRouteName:
        final category = settings.arguments as CategoryModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) {
              return ProductsCubit(category: category)..getProducts();
            },
            child: const ProductsScreen(),
          ),
        );
      case singleProductRouteName:
        final product = settings.arguments as ProductModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => ProductCubit(
              productId: product.id,
              categoryId: product.categoryId,
            )..getProductData(),
            child: const SingleProductScreen(),
          ),
        );
      case cartRouteName:
        return MaterialPageRoute(builder: (_) => const CartPage());
      default:
        throw Exception(AppStrings.routeError);
    }
  }
}
