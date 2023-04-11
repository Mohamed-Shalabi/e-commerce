import 'package:e_commerce/core/utils/app_strings.dart';
import 'package:e_commerce/modules/auth/screens/login_screen/login_screen.dart';
import 'package:e_commerce/modules/auth/screens/sign_up_screen/sign_up_screen.dart';
import 'package:e_commerce/modules/cart/screens/cart_page.dart';
import 'package:e_commerce/modules/categories/blocs/categories_cubit.dart';
import 'package:e_commerce/modules/categories/categories/category_model.dart';
import 'package:e_commerce/modules/main_layout/blocs/main_layout_cubit.dart';
import 'package:e_commerce/modules/main_layout/screens/main_layout.dart';
import 'package:e_commerce/modules/my_orders/blocs/my_orders_cubit.dart';
import 'package:e_commerce/modules/my_orders/screens/my_orders_screen.dart';
import 'package:e_commerce/modules/products/blocs/products/products_cubit.dart';
import 'package:e_commerce/modules/products/blocs/single_product/product_cubit.dart';
import 'package:e_commerce/modules/products/models/product_model.dart';
import 'package:e_commerce/modules/products/screens/products_screen.dart';
import 'package:e_commerce/modules/products/screens/single_product_screen.dart';
import 'package:e_commerce/modules/splash/blocs/splash_cubit.dart';
import 'package:e_commerce/modules/splash/screens/splash_screen.dart';
import 'package:e_commerce/modules/wishlist/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class Routes {
  static const splashRouteName = '/';
  static const mainLayoutRouteName = '/main_layout';
  static const wishlistRouteName = '/wishlist';
  static const productsRouteName = '/products';
  static const singleProductRouteName = '/product';
  static const signUpRouteName = '/sign_up';
  static const loginRouteName = '/log_in';
  static const cartRouteName = '/cart';
  static const myOrdersRouteName = '/my_orders';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRouteName:
        return MaterialPageRoute<void>(
          builder: (_) => BlocProvider<SplashCubit>(
            create: (_) => SplashCubit()..getData(),
            child: const SplashScreen(),
          ),
        );
      case signUpRouteName:
        return MaterialPageRoute<void>(
          builder: (_) => const SignUpScreen(),
        );
      case loginRouteName:
        return MaterialPageRoute<void>(
          builder: (_) => const LoginScreen(),
        );
      case mainLayoutRouteName:
        return MaterialPageRoute<void>(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<MainLayoutCubit>(
                create: (BuildContext context) => MainLayoutCubit(context),
              ),
              BlocProvider<CategoriesCubit>(
                create: (_) => CategoriesCubit()..getCategories(),
              ),
            ],
            child: const MainLayout(),
          ),
        );
      case wishlistRouteName:
        return MaterialPageRoute<void>(builder: (_) => const WishlistScreen());
      case productsRouteName:
        final category = settings.arguments as CategoryModel;
        return MaterialPageRoute<void>(
          builder: (_) => BlocProvider<ProductsCubit>(
            create: (_) {
              return ProductsCubit(category: category)..getProducts();
            },
            child: const ProductsScreen(),
          ),
        );
      case singleProductRouteName:
        final product = settings.arguments as ProductListModel;
        return MaterialPageRoute<void>(
          builder: (_) => BlocProvider<ProductCubit>(
            create: (_) => ProductCubit(
              productId: product.id,
              categoryId: product.categoryId,
            )..getProductData(),
            child: const SingleProductScreen(),
          ),
        );
      case cartRouteName:
        return MaterialPageRoute<void>(builder: (_) => const CartPage());
      case myOrdersRouteName:
        return MaterialPageRoute<void>(
          builder: (_) => BlocProvider<MyOrdersCubit>(
            create: (context) => MyOrdersCubit()..getOrders(),
            child: const MyOrdersScreen(),
          ),
        );
      default:
        throw Exception(AppStrings.routeError);
    }
  }
}
