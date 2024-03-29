import 'package:e_commerce/core/database/api/api.dart';
import 'package:e_commerce/core/local/prefs.dart';
import 'package:e_commerce/core/styles/app_themes.dart';
import 'package:e_commerce/modules/auth/blocs/shipping/shipping_data_provider.dart';
import 'package:e_commerce/modules/cart/blocs/cart_cubit.dart';
import 'package:e_commerce/modules/wishlist/blocs/wishlist_cubit.dart';
import 'package:e_commerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Prefs.init();
  await Api.init();
  initializeDateFormatting();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppThemesCubit()),
        BlocProvider(create: (_) => WishlistCubit()),
        BlocProvider(create: (_) => CartCubit()),
      ],
      child: RepositoryProvider(
        create: (_) => ShippingDataProvider(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLight = context.watch<AppThemesCubit>().isLight;
    return MaterialApp(
      title: 'Market App',
      themeMode: isLight ? ThemeMode.light : ThemeMode.dark,
      theme: AppThemesCubit.lightTheme,
      darkTheme: AppThemesCubit.darkTheme,
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
